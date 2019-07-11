const Router = require("koa-router")
const router = new Router()

const ctrl = require("./index.ctrl")


router.get("/", ctrl.getProfile)

router.get('/test', ctrl.test)

module.exports = router
