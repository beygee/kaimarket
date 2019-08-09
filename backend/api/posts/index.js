const Router = require("koa-router")
const router = new Router()

const ctrl = require("./index.ctrl")

router.get("/", ctrl.getPosts)
router.get("/:id", ctrl.getPost)

router.post("/", ctrl.createPost)
router.post("/:id", ctrl.updatePost)
router.post("/:id/wish", ctrl.wish)

router.post("/:id/sold", ctrl.sold)
router.post("/:id/status/:status", ctrl.updateStatus)


router.delete("/:id", ctrl.deletePost)

module.exports = router
