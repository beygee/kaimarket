const Router = require("koa-router")
const router = new Router()

const ctrl = require('./index.ctrl')

router.post('/login', ctrl.login)
router.post('/join', ctrl.join)


module.exports = router
