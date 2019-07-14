const Koa = require("koa")
const Router = require("koa-router")
const router = new Router()
const path = require("path")
const sharp = require("sharp")

const auth = require("./auth")
const users = require("./users")
const me = require("./me")
const search = require("./search")
const posts = require("./posts")
const chats = require("./chats")

//오류 검출
router.use(async (ctx, next) => {
  //코드, 메시지
  ctx.error = (status, message, body) => {
    ctx.status = status
    ctx.message = message
    ctx.body = {
      message: message,
      ...body
    }
  }

  await next()
})

router.use("/auth", auth.routes())
router.use("/users", users.routes())
router.use("/me", me.routes())
router.use("/search", search.routes())
router.use("/posts", posts.routes())
router.use("/chats", chats.routes())

//파일 업로드
const upload = require("lib/upload")
router.post("/upload", upload, async ctx => {
  const { file } = ctx.req

  //썸네일 만들기
  const fullPath = path.resolve(file.path)
  const thumb = await sharp(fullPath)
    .resize(200)
    .toFile(path.resolve("public", "thumb", file.filename))

  ctx.body = { thumb: `/${file.path}`, url: `/public/thumb/${file.filename}` }
})

module.exports = router
