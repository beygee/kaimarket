const Koa = require("koa")
const Router = require("koa-router")
const router = new Router()

const auth = require("./auth")
const users = require("./users")
const me = require("./me")

router.use("/auth", auth.routes())
router.use("/users", users.routes())
router.use("/me", me.routes())

module.exports = router
