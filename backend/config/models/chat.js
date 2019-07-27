"use strict"

module.exports = (sequelize, DataTypes) => {
  var Chat = sequelize.define(
    "Chat",
    {
      sellerId: DataTypes.INTEGER,
      buyerId: DataTypes.INTEGER,
      postId: DataTypes.INTEGER,
      buyerRead: DataTypes.DATE(6),
      sellerRead: DataTypes.DATE(6)
    },
    {}
  )

  Chat.associate = function(models) {
    Chat.belongsTo(models.User, {
      as: "seller",
      foreignKey: "sellerId",
      targetKey: "id"
    })
    Chat.belongsTo(models.User, {
      as: "buyer",
      foreignKey: "buyerId",
      targetKey: "id"
    })
    Chat.belongsTo(models.Post, {
      as: "post",
      foreignKey: "postId",
      targetKey: "id"
    })
    Chat.hasMany(models.ChatMessage, {
      as: "messages",
      foreignKey: "chatId",
      sourceKey: "id"
    })
  }
  return Chat
}
