const Router = require("koa-router")
const router = new Router()

const ctrl = require("./index.ctrl")

router.get('/', ctrl.getPosts)
router.get('/:id', ctrl.getPost)

router.post("/", ctrl.createPost)
router.post('/:id/view', ctrl.increaseView)

module.exports = router
