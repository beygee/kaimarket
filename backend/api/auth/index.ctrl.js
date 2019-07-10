const Router = require("koa-router")
const request = require("request-promise")

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
  console.log(access_token)

  const body = await request.post(
    `https://graph.facebook.com/v2.12/me?fields=name,first_name,last_name,email,picture&access_token=${access_token}`
  )

  console.log(body)
  ctx.body = "OK"
}

ctrl.authWithNaver = async ctx => {
  const { access_token } = ctx.request.body
  console.log(access_token)
  ctx.body = "OK"
}

ctrl.authWithKakao = async ctx => {
  const { access_token } = ctx.request.body
  console.log(access_token)
  ctx.body = "OK"
}

module.exports = ctrl
