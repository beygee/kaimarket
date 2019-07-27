"use strict"

module.exports = (sequelize, DataTypes) => {
  var ChatMessage = sequelize.define(
    "ChatMessage",
    {
      chatId: DataTypes.INTEGER,
      userId: DataTypes.INTEGER,
      postId: DataTypes.INTEGER,
      text: DataTypes.TEXT,
      createdAt: DataTypes.DATE(6),
      updatedAt: DataTypes.DATE(6)
    },
    {}
  )
  ChatMessage.associate = function(models) {
    ChatMessage.belongsTo(models.User, {
      as: "user",
      foreignKey: "userId",
      targetKey: "id"
    })
    ChatMessage.belongsTo(models.User, {
      as: "chat",
      foreignKey: "chatId",
      targetKey: "id"
    })
    ChatMessage.belongsTo(models.Post, {
      as: "post",
      foreignKey: "postId",
      targetKey: "id"
    })
  }
  return ChatMessage
}
