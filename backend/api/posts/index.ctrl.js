const ctrl = {}
const { stripNull } = require("lib/common")
const moment = require("lib/moment")
const Sequelize = require("sequelize")
const { Op } = Sequelize
const models = require("config/models")
const sanitizeHtml = require("sanitize-html")

ctrl.getPosts = async ctx => {
  const { q, category: categoryId, offset } = ctx.query
  const { id: userId } = ctx.user

  let posts = await models.Post.findAll({
    where: {
      ...(q ? { title: { [Op.like]: `%${q}%` } } : {}),
      ...(categoryId && categoryId != 0 ? { categoryId } : {})
    },
    order: [["createdAt", "desc"]],
    limit: 5,
    offset: parseInt(offset) || 0,
    attributes: {
      include: [
        [
          Sequelize.literal(
            `(select count(id) from UserWish where userId=${userId} && postId=Post.id)`
          ),
          "isWish"
        ]
      ]
    },
    include: [
      {
        model: models.PostImage,
        as: "images"
      }
    ]
  })

  //세일 개수
  posts = posts.map(p => {
    p = p.toJSON()
    return {
      ...p,
      isWish: !!p.isWish,
      createdAt: moment(p.createdAt).fromNow(),
      updatedAt: moment(p.updatedAt).fromNow()
    }
  })

  ctx.body = posts
}

ctrl.getPost = async ctx => {
  const { id } = ctx.params
  const { id: userId } = ctx.user

  let post = await models.Post.findOne({
    where: { id },
    attributes: {
      include: [
        [
          Sequelize.literal(
            `(select count(id) from UserWish where userId=${userId} && postId=Post.id)`
          ),
          "isWish"
        ]
      ]
    },
    include: [
      {
        model: models.User,
        as: "user",
        attributes: {
          include: [
            [
              Sequelize.literal(
                `(select count(id) from UserSale where userId=user.id)`
              ),
              "salesCount"
            ]
          ]
        }
      },
      {
        model: models.PostImage,
        as: "images"
      }
    ]
  })

  post.view++
  await post.save({ silent: true })

  post = post.toJSON()

  //관련된 카테고리 포스트를 5개 가져온다.
  let relatedPosts = await models.Post.findAll({
    where: {
      categoryId: post.categoryId,
      id: { [Op.ne]: post.id }
    },
    attributes: {
      include: [
        [
          Sequelize.literal(
            `(select count(id) from UserWish where userId=${userId} && postId=Post.id)`
          ),
          "isWish"
        ]
      ]
    },
    include: {
      model: models.PostImage,
      as: "images"
    },
    order: Sequelize.literal("rand()"),
    limit: 5
  })

  relatedPosts = relatedPosts.map(p => {
    p = p.toJSON()
    return {
      ...p,
      createdAt: moment(p.createdAt).fromNow(),
      updatedAt: moment(p.updatedAt).fromNow(),
      isWish: !!p.isWish
    }
  })

  //해당 포스트 위시 개수 가져오기
  const wish = await models.UserWish.count({
    where: { postId: id }
  })

  ctx.body = {
    ...post,
    createdAt: moment(post.createdAt).fromNow(),
    updatedAt: moment(post.updatedAt).fromNow(),
    relatedPosts,
    isWish: !!post.isWish,
    wish
  }
}

ctrl.createPost = async ctx => {
  const { id: userId } = ctx.user
  const { data } = ctx.request.body

  console.log(data)

  //포스트 생성
  const post = await models.Post.create(
    stripNull({
      ...data,
      stripTagContent: sanitizeHtml(data.content, {
        allowedTags: [],
        allowedAttributes: {}
      }),
      userId
    })
  )

  //이미지 생성
  await Promise.all(
    data.images.map(image =>
      models.PostImage.create({
        postId: post.id,
        thumb: image.thumb,
        url: image.url
      })
    )
  )

  //판매내역
  await models.UserSale.create({ postId: post.id, userId })

  ctx.body = "OK"
}

ctrl.updatePost = async ctx => {
  const { id } = ctx.params
  const { id: userId } = ctx.user
  const { data } = ctx.request.body

  //포스트 가져오기
  const post = await models.Post.findOne({ where: { id } })

  if (post.userId != userId) {
    ctx.error(403, "NOT MINE", { code: 1 })
    return
  }

  await post.update(data, {
    fields: [
      "categoryId",
      "title",
      "content",
      "price",
      "locationLat",
      "locationLng"
    ]
  })

  //이미지 업로드
  await models.PostImage.destroy({ where: { postId: post.id } })

  //이미지 생성
  await Promise.all(
    data.images.map(image =>
      models.PostImage.create({
        postId: post.id,
        thumb: image.thumb,
        url: image.url
      })
    )
  )

  ctx.body = "OK"
}

ctrl.wish = async ctx => {
  const { id } = ctx.params
  const { id: userId } = ctx.user

  const wish = await models.UserWish.findOne({ where: { userId, postId: id } })
  if (wish) {
    await wish.destroy()
  } else {
    await models.UserWish.create({ postId: id, userId })
  }

  ctx.body = { wish: !wish, postId: id }
}

ctrl.sold = async ctx => {
  const { id } = ctx.params
  const { id: userId } = ctx.user

  const post = await models.Post.findOne({ where: { id } })

  if (post.userId != userId) {
    ctx.error(403, "NOT MINE", { code: 1 })
    return
  }

  post.isSold = true
  await post.save()

  ctx.body = "OK"
}

ctrl.updateStatus = async ctx => {
  const { id, status } = ctx.params
  const { id: userId } = ctx.user

  const post = await models.Post.findOne({ where: { id } })

  if (post.userId != userId) {
    ctx.error(403, "NOT MINE", { code: 1 })
    return
  }

  post.status = status
  await post.save()

  ctx.body = "OK"
}

ctrl.deletePost = async ctx => {
  const { id: userId } = ctx.user
  const { id } = ctx.params

  const post = await models.Post.findOne({ where: { id } })

  //만약 주인이 아니면 거절한다.
  if (post.userId != userId) {
    ctx.error(403, "NOT MINE", { code: 1 })
    return
  }

  await post.destroy()

  ctx.body = "OK"
}

module.exports = ctrl
