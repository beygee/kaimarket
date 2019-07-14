const socket = require("socket.io")
const _ = require("lodash")

module.exports = function(server) {
  const io = socket(server, {
    transports: ["websocket", "polling"]
  })

  io.sockets.on("connection", async function(socket) {
    console.log("소켓 연결")

    socket.on("message", message => {
      console.log(message)
      socket.emit("message", message)
    })

    socket.on("disconnect", () => {
      console.log("소켓 연결 해제")
    })
  })
}

// console.log('a user connected: ' + socket.id + ', ' + io.sockets.server.engine.clientsCount)
// console.log(
//   `[${socket.handshake.address}] ${JSON.stringify(socket.handshake.query)}, ${socket.handshake.headers.connection}`
// )
