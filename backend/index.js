const Koa = require("koa")
const serve = require("koa-static")
const Router = require("koa-router")
const consola = require("consola")
const koaBody = require("koa-body")
const mount = require("koa-mount")
const mongoose = require("mongoose")
const { jwtMiddleware } = require("lib/token")
const admin = require("firebase-admin")

consola.wrapConsole()

//서버 생성
const app = new Koa()
const port = 3005

//소켓서버
const http = require("http")
const createSocketServer = require("socket/index")
const server = http.createServer(app.callback())

//시작 함수
const start = async () => {
  //정적 파일 제공
  const publicApp = new Koa()
  publicApp.use(serve("./public"))
  app.use(mount("/public", publicApp))

  //파이어베이스 연결
  const serviceAccount = require("data/firebase-admin.json")
  const fb = admin.initializeApp({
    credential: admin.credential.cert(serviceAccount),
    databaseURL: "https://kaimarket-1bf8c.firebaseio.com"
  })
  app.use((ctx, next) => {
    ctx.fb = fb
    return next()
  })

  //바디 파서
  app.use(koaBody())

  //JWT 인증
  app.use(jwtMiddleware)

  //라우터 연결
  const router = new Router()
  const api = require("./api")
  router.use("/api", api.routes())
  app.use(router.routes()).use(router.allowedMethods())

  //소켓 연결
  server.listen(port)
  createSocketServer(server)

  console.ready({
    message: `서버 오픈 :) ${port} >_ <`,
    badge: true
  })
}

start()
