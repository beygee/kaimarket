const Koa = require("koa")
const Router = require("koa-router")
const router = new Router()

const auth = require("./auth")
const users = require("./users")
const me = require("./me")

//오류 검출
router.use(async (ctx, next) => {
  //코드, 메시지
  ctx.error = (status, message, body) => {
    ctx.status = status
    ctx.message = message
    ctx.body = {
      message: message,
      ...body
    }
  }

  await next()
})

router.use("/auth", auth.routes())
router.use("/users", users.routes())
router.use("/me", me.routes())

module.exports = router
