const ctrl = {}

ctrl.getProfile = async ctx => {
  const { User } = ctx.db
  const { user } = ctx
  if (user) {
    ctx.body = "OK"
  } else {
    ctx.error(401, "NO VALID", { code: 1 })
  }
}

module.exports = ctrl
