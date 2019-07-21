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
  User.associate = function(models) {}
  return User
}
