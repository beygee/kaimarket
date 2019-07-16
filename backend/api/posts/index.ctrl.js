const ctrl = {}
const mongoose = require("mongoose")
const ObjectId = mongoose.Types.ObjectId
const { stripNull } = require("lib/common")
const moment = require("lib/moment")

ctrl.getPosts = async ctx => {
  const { Post, Category, User } = ctx.db
  const { q, category } = ctx.query
  const { id: userId } = ctx.user

  const fetchedCategory = await Category.findOne({ id: category })

  const user = await User.findById(userId)

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
      user: { ...p.user, salesCount: p.user.sales.length },
      isWish: user.wish.includes(p._id)
    }
  })

  ctx.body = posts
}

ctrl.getPost = async ctx => {
  const { Post, User } = ctx.db
  const { id } = ctx.params
  const { id: userId } = ctx.user

  const user = await User.findById(userId)

  let post = await Post.findById(ObjectId(id))
    .populate("user")
    .populate("category")

  post.view++
  await post.save()

  post = post.toJSON()

  //관련된 카테고리 포스트를 5개 가져온다.
  let relatedPosts = await Post.find({
    category: post.category,
    _id: { $ne: post._id }
  })
    .sort({ _id: -1 })
    .limit(5)
    .populate("user")
    .populate("category")

  relatedPosts = relatedPosts.map(p => {
    p = p.toJSON()
    return {
      ...p,
      created: moment(p.created).fromNow(),
      updated: moment(p.updated).fromNow(),
      isWish: user.wish.includes(p._id)
    }
  })

  //찜 개수 가져오기
  const wish = await User.count({
    wish: { $elemMatch: { $eq: post._id } }
  })

  ctx.body = {
    ...post,
    created: moment(post.created).fromNow(),
    updated: moment(post.updated).fromNow(),
    user: { ...post.user, salesCount: post.user.sales.length },
    isWish: user.wish.includes(post._id),
    relatedPosts,
    wish
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

ctrl.wish = async ctx => {
  const { Post, User } = ctx.db
  const { id } = ctx.params
  const { id: userId } = ctx.user

  //해당 포스트를 위시리스트에 추가
  const user = await User.findById(userId)
  // const user = await User.findOne({ email: "doug0476@naver.com" })

  //해당 유저의 위시리스트에 포함되어있는지 확인
  // const users = await User.find({
  //   email: "doug0476@naver.com",
  //   wish: { $elemMatch: { $eq: id } }
  // })
  const users = await User.find({
    _id: userId,
    wish: { $elemMatch: { $eq: id } }
  })

  //위시리스트를 추가하지 않았다면
  let wish = false
  if (users.length == 0) {
    wish = true
    user.wish.push(id)
    await user.save()
  } else {
    user.wish.remove(id)
    await user.save()
  }

  ctx.body = { wish, postId: id }
}

module.exports = ctrl
