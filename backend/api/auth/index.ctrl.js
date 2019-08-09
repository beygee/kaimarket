const request = require("request-promise")
const { generateToken } = require("lib/token")
const validHakbun = require("lib/validHakbun")
const models = require("config/models")

const ctrl = {}

ctrl.login = async ctx => {
  ctx.body = "OK"
}

ctrl.authWithGoogle = async (ctx, next) => {
  const { access_token } = ctx.request.body

  const body = await request.get(
    `https://www.googleapis.com/oauth2/v1/userinfo?access_token=${access_token}`
  )
  const data = JSON.parse(body)
  ctx.data = data
  return next()
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

  const header = "Bearer " + access_token
  const body = await request.get("https://kapi.kakao.com/v2/user/me", {
    headers: { Authorization: header }
  })

  const data = JSON.parse(body)
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
  const { email, name } = ctx.data

  //이메일로 회원가입했는지 구분한다.
  const user = await models.User.findOne({ where: { email } })
  if (!user) {
    const newUser = await models.User.create({ email, name })

    //JWT 토큰
    const token = await generateToken({ id: newUser.id })
    ctx.set("access_token", token)
    ctx.body = { token, valid: false }
  } else {
    //JWT 토큰
    const token = await generateToken({ id: user.id })
    ctx.set("access_token", token)
    ctx.body = { token, valid: user.valid }
  }
}

ctrl.validHakbun = async ctx => {
  const { id, password } = ctx.request.body
  const { id: userId } = ctx.user

  //아이디 중복 체크
  if (await models.User.findOne({ where: { hakbun: id } })) {
    ctx.error(403, "EXIST", { code: 1 })
    return
  }

  const result = await validHakbun(id, password)

  if (result) {
    //DB에 저장한다.
    const user = await models.User.findOne({ where: { id: userId } })
    user.hakbun = id
    user.valid = true
    await user.save()
  }
  ctx.body = result
}

ctrl.updateName = async ctx => {
  const { id: userId } = ctx.user
  const { name } = ctx.request.body

  const user = await models.User.findOne({ where: { id: userId } })

  user.name = name
  await user.save()

  ctx.body = user
}
module.exports = ctrl
