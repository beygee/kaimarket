const socket = require("socket.io")
const _ = require("lodash")

module.exports = function(server) {
  const io = socket(server, {
    transports: ["websocket", "polling"]
  })

  io.sockets.on("connection", async function(socket) {
    socket.on("disconnect", () => {})
  })
}

// console.log('a user connected: ' + socket.id + ', ' + io.sockets.server.engine.clientsCount)
// console.log(
//   `[${socket.handshake.address}] ${JSON.stringify(socket.handshake.query)}, ${socket.handshake.headers.connection}`
// )
