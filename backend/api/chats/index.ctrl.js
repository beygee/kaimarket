const ctrl = {}
const mongoose = require("mongoose")
const moment = require("moment")
const models = require("config/models")
const Sequelize = require("sequelize")
const { Op } = Sequelize

ctrl.getChats = async ctx => {
  const { id: userId } = ctx.user

  //내가 판매자인것과 내가 구매자인 채팅 목록을 다가져온다.
  let chats = await models.Chat.findAll({
    where: { [Op.or]: [{ buyerId: userId }, { sellerId: userId }] },
    include: [
      {
        model: models.User,
        as: "seller"
      },
      {
        model: models.User,
        as: "buyer"
      },
      {
        model: models.Post,
        as: "post",
        include: {model: models.PostImage, as: 'images'}
      },
      {
        model: models.ChatMessage,
        as: "messages"
      }
    ]
  })

  //최근 메시지
  chats = chats.map(c => {
    c = c.toJSON()
    let recentMessage = { text: "메시지가 없습니다." }
    if (c.messages.length > 0) {
      recentMessage = c.messages[c.messages.length - 1]
    }

    //안읽은 메시지
    const buyerNonReadCount = c.messages.filter(m =>
      moment(m.time).isAfter(c.buyerRead)
    ).length
    const sellerNonReadCount = c.messages.filter(m =>
      moment(m.time).isAfter(c.sellerRead)
    ).length

    return { ...c, recentMessage, buyerNonReadCount, sellerNonReadCount }
  })

  ctx.body = chats
}

ctrl.getChat = async ctx => {
  const { id } = ctx.params
  const { id: userId } = ctx.user

  const chat = await models.Chat.findOne({
    where: { id },
    include: [
      {
        model: models.Post,
        as: "post",
        include: { model: models.PostImage, as: "images" }
      },
      { model: models.User, as: "seller" },
      { model: models.User, as: "buyer" },
      { model: models.ChatMessage, as: "messages" }
    ]
  })

  //읽은 채팅 시간 갱신해준다.
  // if (chat.buyer._id == userId) {
  //   chat.buyerRead = new Date()
  // } else if (chat.seller._id == userId) {
  //   chat.sellerRead = new Date()
  // }
  // await chat.save()

  ctx.body = chat
}

//채팅방이 존재하지 않으면 새로 생성해준다.
ctrl.enterChat = async ctx => {
  const { sellerId, postId } = ctx.request.body
  const { id: userId } = ctx.user

  //채팅방 존재 확인
  const chat = await models.Chat.findOne({
    where: { sellerId, postId, buyerId: userId }
  })

  if (!chat) {
    const newChat = await models.Chat.create({
      sellerId,
      postId,
      buyerId: userId
    })

    ctx.body = newChat.id
  } else {
    ctx.body = chat.id
  }
}


module.exports = ctrl
