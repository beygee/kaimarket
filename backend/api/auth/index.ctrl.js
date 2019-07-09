const Router = require("koa-router")

const ctrl = {}

ctrl.login = async ctx => {
  ctx.body = "OK"
}

ctrl.join = async ctx => {
  ctx.body = "OK"
}

module.exports = ctrl
