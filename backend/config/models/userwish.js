"use strict"

module.exports = (sequelize, DataTypes) => {
  var UserWish = sequelize.define(
    "UserWish",
    {
      postId: DataTypes.INTEGER,
      userId: DataTypes.INTEGER
    },
    { timestamps: false }
  )
  UserWish.associate = function(models) {}
  return UserWish
}
