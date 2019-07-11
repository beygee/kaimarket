const Router = require("koa-router")
const request = require("request-promise")
const { generateToken } = require("lib/token")

const ctrl = {}

ctrl.login = async ctx => {
  ctx.body = "OK"
}

ctrl.authWithGoogle = async ctx => {
  const { access_token } = ctx.request.body
  console.log(access_token)
  ctx.body = "OK"
}

ctrl.authWithFacebook = async ctx => {
  const { access_token } = ctx.request.body
  const { User } = ctx.db

  try {
    const body = await request.post(
      `https://graph.facebook.com/v2.12/me?fields=name,first_name,last_name,email,picture&access_token=${access_token}`
    )

    const data = JSON.parse(body)
    const { email } = data

    //이메일로 회원가입했는지 구분한다.
    const user = await User.findOne({ email })
    if (!user) {
      const newUser = new User(data)
      await newUser.save()

      //JWT 토큰
      const token = await generateToken({ id: newUser._id })
      ctx.body = token
    } else {
      //JWT 토큰
      const token = await generateToken({ id: user._id })
      ctx.body = token
    }
  } catch (e) {
    ctx.error(401, "INVALID", { code: 1 })
  }

  //데이터를 넣는다.

  ctx.body = "OK"
}

ctrl.authWithNaver = async ctx => {
  const { access_token } = ctx.request.body
  const { User } = ctx.db

  const header = "Bearer " + access_token
  const body = await request.get("https://openapi.naver.com/v1/nid/me", {
    headers: { Authorization: header }
  })

  const data = JSON.parse(body)
  const { email } = data.response

  //이메일로 회원가입했는지 구분한다.
  const user = await User.findOne({ email })
  if (!user) {
    const newUser = new User(data)
    await newUser.save()

    //JWT 토큰
    const token = await generateToken({ id: newUser._id })
    ctx.body = token
  } else {
    //JWT 토큰
    const token = await generateToken({ id: user._id })
    ctx.body = token
  }
}

ctrl.authWithKakao = async ctx => {
  const { access_token } = ctx.request.body
  const { User } = ctx.db

  const header = "Bearer " + access_token
  const body = await request.get("https://kapi.kakao.com/v2/user/me", {
    headers: { Authorization: header }
  })

  const data = JSON.parse(body)
  const { email } = data.kakao_account
  const { nickname: name } = data.properties

  //이메일로 회원가입했는지 구분한다.
  const user = await User.findOne({ email })
  if (!user) {
    const newUser = new User({ email, name })
    await newUser.save()

    //JWT 토큰
    const token = await generateToken({ id: newUser._id })
    ctx.body = token
  } else {
    //JWT 토큰
    const token = await generateToken({ id: user._id })
    ctx.body = token
  }
}

ctrl.authWithGuest = async ctx => {
  const { User } = ctx.db

  const email = "guest@naver.com"
  const name = "손님ㅎ"

  //이메일로 회원가입했는지 구분한다.
  const user = await User.findOne({ email })
  if (!user) {
    const newUser = new User({ email, name })
    await newUser.save()

    //JWT 토큰
    const token = await generateToken({ id: newUser._id })
    ctx.body = token
  } else {
    //JWT 토큰
    const token = await generateToken({ id: user._id })
    ctx.body = token
  }
}

module.exports = ctrl
