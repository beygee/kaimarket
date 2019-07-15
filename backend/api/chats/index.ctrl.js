const ctrl = {}
const mongoose = require("mongoose")
const ObjectId = mongoose.Types.ObjectId

ctrl.getChats = async ctx => {
  const { User, Chat } = ctx.db
  const { user } = ctx

  const chats = await Chat.find()
    .populate("seller")
    .populate("buyer")
    .populate({ path: "post", populate: "category" })

  ctx.body = chats
}

ctrl.getChat = async ctx => {
  const { Chat } = ctx.db
  const { id } = ctx.params

  const chat = await Chat.findById(id)
    .populate({ path: "post", populate: "category" })
    .populate("buyer")
    .populate("seller")
  // .populate({ path: "post", populate: "category" })

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
