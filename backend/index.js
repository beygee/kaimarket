const Koa = require("koa")
const Router = require("koa-router")
const consola = require("consola")
const koaBody = require("koa-body")

consola.wrapConsole()

const app = new Koa()
const port = 3000

const start = async () => {
  const router = new Router()
  const api = require("./api")

  app.use(koaBody())
  router.use("/api", api.routes())
  app.use(router.routes()).use(router.allowedMethods())

  app.listen(port)
  console.ready({
    message: `서버 오픈: ${port}`,
    badge: true
  })
}

start()
