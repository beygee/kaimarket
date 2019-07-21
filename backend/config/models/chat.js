"use strict"

module.exports = (sequelize, DataTypes) => {
  var Chat = sequelize.define(
    "Chat",
    {
      sellerId: DataTypes.INTEGER,
      buyerId: DataTypes.INTEGER,
      postId: DataTypes.INTEGER,
      buyerRead: DataTypes.DATETIME(6),
      sellerRead: DataTypes.DATETIME(6)
    },
    {}
  )
  Chat.associate = function(models) {}
  return Chat
}
