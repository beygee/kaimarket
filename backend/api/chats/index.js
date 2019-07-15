const Router = require("koa-router")
const router = new Router()

const ctrl = require("./index.ctrl")

router.get("/", ctrl.getChats)
router.get('/:id', ctrl.getChat)

router.post('/', ctrl.enterChat)


module.exports = router
