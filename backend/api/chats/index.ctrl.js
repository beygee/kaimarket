const ctrl = {}
const mongoose = require("mongoose")

ctrl.getChats = async ctx => {
  const { User, Chat } = ctx.db
  const { user } = ctx

  const chats = await Chat.find().populate('seller').populate('buyer').populate({path: 'post', populate: 'category'})

  ctx.body = chats
}

module.exports = ctrl
