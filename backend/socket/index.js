const socket = require("socket.io")
const jwtAuth = require("socketio-jwt-auth")
const moment = require("moment")
const _ = require("lodash")
const models = require("config/models")

//소켓 리스트에 유저 아이디를 연결한다.
const addUsers = (sockets, userId, socketId) => {
  if (sockets["" + userId]) {
    sockets["" + userId].push(socketId)
  } else {
    sockets["" + userId] = [socketId]
  }
}

//해당 소켓 아이디를 저장소에서 지운다.
const removeUsers = (sockets, userId, socketId) => {
  if (sockets["" + userId]) {
    sockets["" + userId] = sockets["" + userId].filter(s => s != socketId)
  }
}

module.exports = function(server) {
  const io = socket(server, {
    transports: ["websocket", "polling"]
  })

  const sockets = {}

  const nsp = io.of("/test1")

  //해당 유저에게 이벤트 함수를 보낸다.
  const emitToUser = (userId, event, data) => {
    if (sockets["" + userId]) {
      for (let i = 0; i < sockets["" + userId].length; i++) {
        nsp.to(sockets["" + userId][i]).emit(event, data)
      }
    }
  }

  nsp.use(
    jwtAuth.authenticate(
      { secret: "mySecret!kaimarket@@" },
      async (payload, done) => {
        try {
          const user = await models.User.findOne({ where: { id: payload.id } })
          if (!user) {
            return done(null, false, "user does not exist")
          }
          return done(null, user)
        } catch (e) {
          return done(e)
        }
      }
    )
  )

  nsp.on("connection", async function(socket) {
    try {
      const { id: userId, name } = socket.request.user
      console.log(`소켓 연결 ${io.engine.clientsCount}`)
      // console.log(io.engine.clientsCount)
      addUsers(sockets, userId, socket.id)
      // console.log(sockets)

      socket.on("message", async message => {
        const { userId, to, text, chatId } = message

        //로그인한 유저와 메시지를 받는 유저 둘다에게 소켓을 보내준다.
        emitToUser(userId, "message", {
          ...message,
          createdAt: moment().format("YYYY-MM-DD HH:mm")
        })
        emitToUser(to, "message", {
          ...message,
          createdAt: moment().format("YYYY-MM-DD HH:mm")
        })


        process.nextTick(async () => {
          const chat = await models.Chat.findOne({ where: { id: chatId } })
          await models.ChatMessage.create({
            chatId,
            postId: chat.postId,
            userId,
            text
          })

          //읽은 채팅 시간 갱신해준다.
          if (chat.buyerId == userId) {
            chat.buyerRead = new Date()
          } else if (chat.sellerId == userId) {
            chat.sellerRead = new Date()
          }
          await chat.save()
        })
      })

      socket.on("disconnect", () => {
        removeUsers(sockets, userId, socket.id)
        console.log("소켓 연결 해제")
      })
    } catch (e) {
      console.log(e)
    }
  })
}
