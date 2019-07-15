const ctrl = {}
const mongoose = require("mongoose")
const ObjectId = mongoose.Types.ObjectId
const { stripNull } = require("lib/common")
const moment = require("lib/moment")

ctrl.getPosts = async ctx => {
  const { Post, Category } = ctx.db
  const { q, category } = ctx.query

  const fetchedCategory = await Category.findOne({ id: category })

  let posts = await Post.find({
    ...(q ? { title: new RegExp(q) } : {}),
    ...(category && category != 0
      ? { category: ObjectId(fetchedCategory._id) }
      : {})
  })
    .sort({ created: -1 })
    .populate({ path: "user" })
    .populate("category")

  posts = posts.map(p => {
    p = p.toJSON()
    return {
      ...p,
      created: moment(p.created).fromNow(),
      updated: moment(p.updated).fromNow(),
      user: { ...p.user, salesCount: p.user.sales.length }
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

  const post = await Post.create(
    stripNull({
      ...data,
      category: await Category.findOne({ id: data.category.id }),
      user: await User.findById(user.id)
    })
  )

  const fetchedUser = await User.findById(ObjectId(user.id))
  fetchedUser.sales.push(post)
  await fetchedUser.save()

  ctx.body = "OK"
}

ctrl.increaseView = async ctx => {
  const { id } = ctx.params
  const { Post } = ctx.db

  const post = await Post.findById(ObjectId(id))
  post.view++
  await post.save()

  ctx.body = "OK"
}

module.exports = ctrl
