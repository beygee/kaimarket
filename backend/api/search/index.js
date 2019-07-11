const Router = require("koa-router")
const router = new Router()

const ctrl = require("./index.ctrl")

router.get("/books", ctrl.searchBooks)

module.exports = router
