const socket = require("socket.io")
const jwtAuth = require("socketio-jwt-auth")
const mongoose = require("mongoose")
const ObjectId = mongoose.Types.ObjectId
const moment = require("moment")
const _ = require("lodash")

//소켓 리스트에 유저 아이디를 연결한다.
const addUsers = (sockets, userId, socketId) => {
  if (sockets[userId]) {
    sockets[userId].push(socketId)
  } else {
    sockets[userId] = [socketId]
  }
}

const removeUsers = (sockets, userId, socketId) => {
  if (sockets[userId]) {
    sockets[userId] = sockets[userId].filter(s => s != socketId)
  }
}

module.exports = function(server, db) {
  const io = socket(server, {
    transports: ["websocket", "polling"]
  })

  const sockets = {}

  const nsp = io.of("/test1")

  nsp.use(
    jwtAuth.authenticate(
      { secret: "mySecret!kaimarket@@" },
      async (payload, done) => {
        // db.User.find
        console.log(payload)
        try {
          const user = await db.User.findById(ObjectId(payload.id))
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
      const { _id: userId, name } = socket.request.user
      console.log("소켓 연결")
      console.log(io.engine.clientsCount)
      addUsers(sockets, userId, socket.id)
      console.log(sockets)

      socket.on("message", async message => {
        const { from, text, chatId } = message

        socket.emit("message", {
          ...message,
          time: moment().format("YYYY-MM-DD HH:mm")
        })

        const chat = await db.Chat.findById(ObjectId(chatId))
        chat.messages.push({ from, text, time: moment() })
        await chat.save()
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

// console.log('a user connected: ' + socket.id + ', ' + io.sockets.server.engine.clientsCount)
// console.log(
//   `[${socket.handshake.address}] ${JSON.stringify(socket.handshake.query)}, ${socket.handshake.headers.connection}`
// )

// db.Chat.findOne({})
// const chat = await db.Chat.findById(ObjectId(chatId)).sort({
//   "messages.time": 1
// })
//   const chat = await db.Chat.aggregate([
//  //   {
//    //   $match: { _id: ObjectId(chatId) }
//   //  },
//     { $unwind: "$messages" },
//     { $sort: { "messages.time": -1 } }
//   ])

//   console.log(chat)

// if (chat.messages.length > 0) {
//   const prevMessage = chat.messages[0]
//   console.log(moment(prevMessage.time))
//   console.log(moment())
//   console.log(moment(prevMessage.time).isSame(moment(), "minute"))
//   if (
//     prevMessage.from.toString() == from &&
//     moment(prevMessage.time).isSame(moment(), "minute")
//   ) {
//     prevMessage.showTime = false
//     await chat.save()
//     console.log("같음")
//   }
// }
