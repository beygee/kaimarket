const Router = require("koa-router")
const router = new Router()

const ctrl = require("./index.ctrl")

router.post("/", ctrl.createPost)

module.exports = router
