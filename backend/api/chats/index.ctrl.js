const ctrl = {}
const mongoose = require("mongoose")
const ObjectId = mongoose.Types.ObjectId

ctrl.getChats = async ctx => {
  const { User, Chat } = ctx.db
  const { id: userId } = ctx.user

  //내가 판매자인것과 내가 구매자인 채팅 목록을 다가져온다.
  const chats = await Chat.find({
    $or: [{ buyer: userId }, { seller: userId }]
  })
    .populate("seller")
    .populate("buyer")
    .populate({ path: "post", populate: "category" })

  ctx.body = chats
}

ctrl.getChat = async ctx => {
  const { Chat } = ctx.db
  const { id } = ctx.params
  const { id: userId } = ctx.user

  const chat = await Chat.findById(id)
    .populate({ path: "post", populate: ["category", "user"] })
    .populate("buyer")
    .populate("seller")

  //읽은 채팅 시간 갱신해준다.
  if (chat.buyer._id == userId) {
    chat.buyerRead = Date.now
  } else if (chat.seller._id == userId) {
    chat.sellerRead = Date.now
  }

  ctx.body = chat
}
//채팅방이 존재하지 않으면 새로 생성해준다.
ctrl.enterChat = async ctx => {
  const { sellerId, postId } = ctx.request.body
  const { User, Chat, Post } = ctx.db
  const { id: userId } = ctx.user

  //채팅방 존재 확인
  const chat = await Chat.findOne({ seller: sellerId, post: postId })
  if (!chat) {
    const newChat = await Chat.create({
      seller: sellerId,
      post: postId,
      buyer: userId
    })

    //두 유저에게 채팅방을 파준다.
    await User.update({ _id: sellerId }, { $push: { chats: newChat._id } })
    await User.update({ _id: userId }, { $push: { chats: newChat._id } })

    ctx.body = newChat
  } else {
    ctx.body = chat
  }
}
// ctrl.test = async ctx => {
//   const { User, Chat } = ctx.db

//   const chat = await Chat.aggregate([
//     { $match: { _id: ObjectId("5d2b50fb3af44c40ec39fa0e") } },
//     // { $unwind: "$messages" },
//     { $sort: { "messages.time": -1 } },
//     { $group: { _id: "$_id", messages: { $push: "$messages" } } }
//   ])

//   ctx.body = chat
// }

module.exports = ctrl
