"use strict"

module.exports = (sequelize, DataTypes) => {
  var Category = sequelize.define(
    "Category",
    {
      name: DataTypes.STRING
    },
    { timestamps: false }
  )
  Category.associate = function(models) {}
  return Category
}
