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
  Chat.associate = function(models) {}
  return Chat
}
