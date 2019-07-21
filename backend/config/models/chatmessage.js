"use strict"

module.exports = (sequelize, DataTypes) => {
  var ChatMessage = sequelize.define(
    "ChatMessage",
    {
      chatId: DataTypes.INTEGER,
      userId: DataTypes.INTEGER,
      postId: DataTypes.INTEGER,
      text: DataTypes.TEXT,
      createdAt: DataTypes.DATETIME(6),
      updatedAt: DataTypes.DATETIME(6)
    },
    {}
  )
  ChatMessage.associate = function(models) {}
  return ChatMessage
}
