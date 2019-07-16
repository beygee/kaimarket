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

  //DB 연결
  await mongoose.connect("mongodb://localhost:27017/kaimarket", {
    useNewUrlParser: true
  })
  const db = require("lib/db")
  app.use((ctx, next) => {
    ctx.db = db
    return next()
  })

  //DB 복구하기
  // const posts = await db.Post.find({ user: { $ne: "5d26c168d118a3691c97564a" } })
  // for (let i = 0; i < posts.length; i++) {
  //   console.log(posts[i].title)
  //   posts[i].user = mongoose.Types.ObjectId('5d2d5d8d8bd4fc7e8a0bb957')
  //   await posts[i].save()
  // }
  // console.log(posts.length)

  // const chat = new db.Chat({
  //   seller: await db.User.findById(mongoose.Types.ObjectId('5d26db570145306b417f1581')),
  //   buyer: await db.User.findById(mongoose.Types.ObjectId('5d26c168d118a3691c97564a')),
  //   post: await db.Post.findById(mongoose.Types.ObjectId('5d2b508b26acd940b9273137')),
  // })

  // await chat.save()

  // const createCategory = require("lib/createCategory")
  // await createCategory(db.Category)

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
  createSocketServer(server, db)

  console.ready({
    message: `서버 오픈 :) ${port} >_ <`,
    badge: true
  })
}

start()
