const ctrl = {}
const mongoose = require("mongoose")
const ObjectId = mongoose.Types.ObjectId
const moment = require("lib/moment")

ctrl.getProfile = async ctx => {
  const { User } = ctx.db
  const { user } = ctx
  if (user) {
    //인증 검사
    const fetchedUser = await User.findById(mongoose.Types.ObjectId(user.id))
      .populate("chats")
      .populate("wish")
      .populate("sales")
    ctx.body = fetchedUser
  } else {
    ctx.error(401, "NO VALID", { code: 1 })
  }
}

ctrl.getWish = async ctx => {
  const { User } = ctx.db
  const { id: userId } = ctx.user

  const user = await User.findById(userId)

  const fetchedUser = await User.aggregate([
    { $match: { _id: ObjectId(userId) } },
    {
      $lookup: {
        from: "posts",
        localField: "wish",
        foreignField: "_id",
        as: "wishObjects"
      }
    },
    { $unwind: "$wishObjects" },
    { $sort: { "wishObjects.created": -1 } },
    { $group: { _id: "$_id", wish: { $push: "$wishObjects" } } }
  ])

  console.log(fetchedUser)

  if (fetchedUser.length > 0) {
    const wish = fetchedUser[0].wish.map(p => {
      return {
        ...p,
        created: moment(p.created).fromNow(),
        updated: moment(p.updated).fromNow(),
        isWish: user.wish.includes(p._id)
      }
    })
    ctx.body = wish
  } else {
    ctx.body = []
  }
}
ctrl.getSales = async ctx => {
  const { User } = ctx.db
  const { id: userId } = ctx.user

  const user = await User.findById(userId)

  const fetchedUser = await User.aggregate([
    { $match: { _id: ObjectId(userId) } },
    {
      $lookup: {
        from: "posts",
        localField: "sales",
        foreignField: "_id",
        as: "salesObjects"
      }
    },
    { $unwind: "$salesObjects" },
    { $sort: { "salesObjects.created": -1 } },
    { $group: { _id: "$_id", sales: { $push: "$salesObjects" } } }
  ])
  const sales = fetchedUser[0].sales.map(p => {
    return {
      ...p,
      created: moment(p.created).fromNow(),
      updated: moment(p.updated).fromNow(),
      isWish: user.wish.includes(p._id)
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

//앱 로그인 시, 로그인 토큰과 기기 토큰을 묶음.
//로그아웃 시 기기 토큰 제거
//푸시 시 토큰을 꺼내 만료일을 확인하고 지나지 않았으면 푸시.
//토큰 갱신시  DB도 같이  Update
ctrl.test = async ctx => {
  const { fb } = ctx
  const message = {
    // data: {
    //   score: "850",
    //   time: "2:45"
    // },
    token:
      "eIExHX8PEZ4:APA91bHrSlECO1xsWUrGBSd4EgKU4pyoFle3py0ILAXDHso7Cv6rMy5DctTBMoOwqPW5KgUeIHdo5D1lq4MSSBHx2iiToCq1QvWFmqUedkt5q0Su0xvQuqKfJjdBKlodbaYiiR0QdKM6",
    notification: {
      title: "제목",
      body: "컨텐츠"
    }
  }

  try {
    const res = await fb.messaging().send(message)
    console.log(res)
  } catch (e) {
    console.log(e)
  }

  ctx.body = "OK"
}

module.exports = ctrl
