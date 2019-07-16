const Router = require("koa-router")
const request = require("request-promise")
const { generateToken } = require("lib/token")
const validHakbun = require("lib/validHakbun")
const mongoose = require("mongoose")

const ctrl = {}

ctrl.login = async ctx => {
  ctx.body = "OK"
}

ctrl.authWithGoogle = async ctx => {
  const { access_token } = ctx.request.body
  ctx.body = "OK"
}

ctrl.authWithFacebook = async (ctx, next) => {
  const { access_token } = ctx.request.body

  try {
    const body = await request.post(
      `https://graph.facebook.com/v2.12/me?fields=name,first_name,last_name,email,picture&access_token=${access_token}`
    )

    const data = JSON.parse(body)
    ctx.data = data
    return next()
  } catch (e) {
    ctx.error(401, "INVALID", { code: 1 })
  }
}

ctrl.authWithNaver = async (ctx, next) => {
  const { access_token } = ctx.request.body

  const header = "Bearer " + access_token
  const body = await request.get("https://openapi.naver.com/v1/nid/me", {
    headers: { Authorization: header }
  })

  const data = JSON.parse(body)
  ctx.data = data.response
  return next()
}

ctrl.authWithKakao = async (ctx, next) => {
  const { access_token } = ctx.request.body

  console.log(ctx.request.body)
  const header = "Bearer " + access_token
  const body = await request.get("https://kapi.kakao.com/v2/user/me", {
    headers: { Authorization: header }
  })

  const data = JSON.parse(body)
  console.log(data)
  ctx.data = { email: data.kakao_account.email, name: data.properties.nickname }
  return next()
}

ctrl.authWithGuest = async (ctx, next) => {
  const email = "guest@naver.com"
  const name = "손님ㅎ"

  ctx.data = { email, name }

  return next()
}

ctrl.authToken = async ctx => {
  const { User } = ctx.db
  const { email, name } = ctx.data

  //이메일로 회원가입했는지 구분한다.
  const user = await User.findOne({ email })
  if (!user) {
    const newUser = new User({ email, name })
    await newUser.save()

    //JWT 토큰
    const token = await generateToken({ id: newUser._id })
    ctx.set("access_token", token)
    ctx.body = { token, valid: false }
  } else {
    //JWT 토큰
    const token = await generateToken({ id: user._id })
    ctx.set("access_token", token)
    ctx.body = { token, valid: user.valid || false }
  }
}

ctrl.validHakbun = async ctx => {
  const { id, password } = ctx.request.body
  const { User } = ctx.db
  const { user } = ctx
  const result = await validHakbun(id, password)

  if (result) {
    //DB에 저장한다.
    const fetchedUser = await User.findById(mongoose.Types.ObjectId(user.id))
    fetchedUser.valid = true
    await fetchedUser.save()
  }
  ctx.body = result
}

module.exports = ctrl
