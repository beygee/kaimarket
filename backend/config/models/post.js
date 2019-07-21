"use strict"

module.exports = (sequelize, DataTypes) => {
  var Post = sequelize.define(
    "Post",
    {
      userId: DataTypes.INTEGER,
      categoryId: DataTypes.INTEGER,
      title: DataTypes.STRING,
      content: DataTypes.TEXT,
      srtipTagContent: DataTypes.STRING,
      price: DataTypes.INTEGER,
      view: DataTypes.INTEGER,
      wish: DataTypes.INTEGER,
      chat: DataTypes.INTEGER,
      locationLat: DataTypes.DOUBLE,
      locationLng: DataTypes.DOUBLE,
      isBook: DataTypes.BOOLEAN,
      bookMajor: DataTypes.STRING,
      bookAuthor: DataTypes.STRING,
      bookPublisher: DataTypes.STRING,
      bookImage: DataTypes.STRING,
      bookPrice: DataTypes.INTEGER,
      isSold: DataTypes.BOOLEAN
    },
    {}
  )
  Post.associate = function(models) {}
  return Post
}
