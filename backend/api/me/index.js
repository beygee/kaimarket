const Router = require("koa-router")
const router = new Router()

const ctrl = require("./index.ctrl")


router.get("/", ctrl.getProfile)
router.get('/wish', ctrl.getWish)
router.get('/sales', ctrl.getSales)
router.get('/chats', ctrl.getChats)


router.get('/test', ctrl.test)

module.exports = router
