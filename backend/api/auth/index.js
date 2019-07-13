const Router = require("koa-router")
const router = new Router()

const ctrl = require("./index.ctrl")

router.post("/google", ctrl.authWithGoogle)
router.post("/facebook", ctrl.authWithFacebook)
router.post("/naver", ctrl.authWithNaver)
router.post("/kakao", ctrl.authWithKakao)
router.post("/guest", ctrl.authWithGuest)

router.post('/valid', ctrl.validHakbun)

module.exports = router
