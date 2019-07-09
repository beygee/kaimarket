const Koa = require("koa")
const Router = require("koa-router")
const consola = require("consola")

consola.wrapConsole()

const app = new Koa()
const port = 3000

const start = async () => {
  const router = new Router()

  app.listen(port)
  console.log(`서버 오픈: ${port}`)
}

start()
