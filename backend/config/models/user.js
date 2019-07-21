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
    User.hasMany(models.UserSale, {
      as: "sales",
      foreignKey: "userId",
      sourceKey: "id"
    })
  }
  return User
}
