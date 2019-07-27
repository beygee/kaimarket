"use strict"

module.exports = (sequelize, DataTypes) => {
  var User = sequelize.define(
    "User",
    {
      name: DataTypes.STRING,
      email: DataTypes.STRING,
      valid: DataTypes.BOOLEAN,
      hakbun: DataTypes.STRING
    },
    {}
  )
  User.associate = function(models) {

    User.belongsToMany(models.Post, {
      foreignKey: "userId",
      otherKey: 'postId',
      as: "wishes",
      through: "UserWish"
    })

    User.belongsToMany(models.Post, {
      foreignKey: "userId",
      otherKey: 'postId',
      as: "sales",
      through: "UserSale"
    })
  }
  return User
}
