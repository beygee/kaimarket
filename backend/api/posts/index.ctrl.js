const ctrl = {}
const mongoose = require("mongoose")
const ObjectId = mongoose.Types.ObjectId
const { stripNull } = require("lib/common")
const moment = require("moment")

ctrl.createPost = async ctx => {
  const { User, Post, Category } = ctx.db
  const { user } = ctx
  const { data } = ctx.request.body

  const post = await Post.create(
    stripNull({
      ...data,
      category: await Category.findOne({ id: data.category.id }),
      user: await User.findById(user.id)
    })
  )

  ctx.body = "OK"
}

module.exports = ctrl
