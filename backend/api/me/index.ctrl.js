const ctrl = {}
const models = require("config/models")
const moment = require("lib/moment")
const Sequelize = require("sequelize")

ctrl.getProfile = async ctx => {
  if (ctx.user) {
    const { id: userId } = ctx.user
    //인증 검사
    const user = await models.User.findOne({ where: { id: userId } })
    ctx.body = user
  } else {
    ctx.error(401, "NO VALID", { code: 1 })
  }
}

ctrl.getWish = async ctx => {
  const { id: userId } = ctx.user

  //위시 리스트 불러온다.
  const user = await models.User.findOne({
    where: { id: userId },

    include: {
      model: models.Post,
      as: "wishes",
      attributes: {
        include: [
          [
            Sequelize.literal(
              `(select count(id) from UserWish where userId=${userId} && postId=wishes.id)`
            ),
            "isWish"
          ]
        ]
      },
      include: {
        model: models.PostImage,
        as: "images"
      }
    }
  })

  const wishes = user.wishes.map(p => {
    p = p.toJSON()
    return {
      ...p,
      isWish: !!p.isWish,
      createdAt: moment(p.createdAt).fromNow(),
      updatedAt: moment(p.updatedAt).fromNow()
    }
  })

  ctx.body = wishes
}
ctrl.getSales = async ctx => {
  const { id: userId } = ctx.user

  //위시 리스트 불러온다.
  const user = await models.User.findOne({
    where: { id: userId },
    include: {
      model: models.Post,
      as: "sales",
      attributes: {
        include: [
          [
            Sequelize.literal(
              `(select count(id) from UserWish where userId=${userId} && postId=sales.id)`
            ),
            "isWish"
          ]
        ]
      },
      include: {
        model: models.PostImage,
        as: "images"
      }
    }
  })

  const sales = user.sales.map(p => {
    p = p.toJSON()
    return {
      ...p,
      isWish: !!p.isWish,
      createdAt: moment(p.createdAt).fromNow(),
      updatedAt: moment(p.updatedAt).fromNow()
    }
  })

  ctx.body = sales
}
ctrl.getChats = async ctx => {
  // const { User } = ctx.db
  // const { user } = ctx
  // const fetchedUser = await User.aggregate([
  //   { $match: { _id: user.id } },
  //   {
  //     $lookup: {
  //       from: "posts",
  //       localField: "sales",
  //       foreignField: "_id",
  //       as: "salesObjects"
  //     }
  //   },
  //   { $unwind: "$salesObjects" },
  //   { $sort: { "salesObjects.created": -1 } },
  //   { $group: { _id: "$_id", sales: { $push: "$salesObjects" } } }
  // ])
  // ctx.body = fetchedUser[0].sales
}

module.exports = ctrl
