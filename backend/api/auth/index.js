const Router = require("koa-router")
const router = new Router()

const ctrl = require("./index.ctrl")

router.post("/google", ctrl.authWithGoogle, ctrl.authToken)
router.post("/facebook", ctrl.authWithFacebook, ctrl.authToken)
router.post("/naver", ctrl.authWithNaver, ctrl.authToken)
router.post("/kakao", ctrl.authWithKakao, ctrl.authToken)
router.post("/guest", ctrl.authWithGuest, ctrl.authToken)

router.post("/valid", ctrl.validHakbun)

module.exports = router
