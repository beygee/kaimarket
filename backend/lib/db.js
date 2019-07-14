const mongoose = require("mongoose")
const moment = require("moment")
const Schema = mongoose.Schema

const db = {}

const UserSchema = new Schema({
  name: String,
  email: { type: String, unique: true, required: true },
  purchases: [{ type: Schema.Types.ObjectId, ref: "post" }], //구매내역
  sales: [{ type: Schema.Types.ObjectId, ref: "post" }], //판매내역
  valid: { type: Boolean, default: false }, //학번 인증 여부
  hakbun: String //학번
})
const PostSchema = new Schema({
  user: { type: Schema.Types.ObjectId, ref: "user" },
  category: { type: Schema.Types.ObjectId, ref: "category" },
  title: String,
  content: String,
  price: { type: Number, default: 0 },
  view: { type: Number, default: 0 },
  wish: { type: Number, default: 0 },
  chat: { type: Number, default: 0 },
  created: { type: Date, default: Date.now },
  updated: { type: Date, default: Date.now },
  images: [String],
  locationLat: { type: Number, default: 0 },
  locationLng: { type: Number, default: 0 },
  isBook: { type: Boolean, default: false },
  bookMajor: String,
  bookAuthor: String,
  bookPublisher: String,
  bookPubDate: String,
  bookPrice: { type: Number, default: 0 }
})

const CategorySchema = new Schema({
  id: Number,
  name: String
})
// var user;
// var location;
// var category;

db.User = mongoose.model("user", UserSchema)
db.Post = mongoose.model("post", PostSchema)
db.Category = mongoose.model("category", CategorySchema)

module.exports = db
