const Router = require("koa-router")
const request = require("request-promise")
const { generateToken } = require("lib/token")

const ctrl = {}

ctrl.getProfile = async ctx => {
  ctx.body = "OK"
}

module.exports = ctrl
