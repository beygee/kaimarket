const Koa = require("koa")
const Router = require("koa-router")
const router = new Router()

router.get("/", ctx => {
  console.log("A")
  ctx.body = "Hello"
})

module.exports = router
