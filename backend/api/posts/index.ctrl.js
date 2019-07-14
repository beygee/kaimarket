const ctrl = {}
const mongoose = require("mongoose")
const ObjectId = mongoose.Types.ObjectId
const { stripNull } = require("lib/common")
const moment = require("lib/moment")

ctrl.getPosts = async ctx => {
  const { Post } = ctx.db

  let posts = await Post.find()
    .populate("user")
    .populate("category")

  posts = posts.map(p => {
    p = p.toJSON()
    return {
      ...p,
      created: moment(p.created).fromNow(),
      updated: moment(p.updated).fromNow()
    }
  })

  ctx.body = posts
}

ctrl.getPost = async ctx => {
  const { Post } = ctx.db
  const { id } = ctx.params

  const post = await Post.findById(ObjectId(id))
    .populate("user")
    .populate("category")

  ctx.body = {
    ...post.toJSON(),
    created: moment(post.created).fromNow(),
    updated: moment(post.updated).fromNow()
  }
}

ctrl.createPost = async ctx => {
  const { User, Post, Category } = ctx.db
  const { user } = ctx
  const { data } = ctx.request.body

  await Post.create(
    stripNull({
      ...data,
      category: await Category.findOne({ id: data.category.id }),
      user: await User.findById(user.id)
    })
  )

  ctx.body = "OK"
}

module.exports = ctrl
