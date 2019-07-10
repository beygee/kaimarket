const Router = require("koa-router")
const router = new Router()

const ctrl = require('./index.ctrl')

router.post('/login', ctrl.login)

router.post('/google', ctrl.authWithGoogle)
router.post('/facebook', ctrl.authWithFacebook)
router.post('/naver', ctrl.authWithNaver)
router.post('/kakao', ctrl.authWithKakao)


module.exports = router
