"use strict"

module.exports = (sequelize, DataTypes) => {
  var PostImage = sequelize.define(
    "PostImage",
    {
      postId: DataTypes.INTEGER,
      url: DataTypes.STRING,
      thumb: DataTypes.STRING
    },
    { timestamps: false }
  )
  PostImage.associate = function(models) {}
  return PostImage
}
