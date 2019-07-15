const mongoose = require("mongoose")
const moment = require("moment")
const Schema = mongoose.Schema

const db = {}

const UserSchema = new Schema({
  name: { type: String, default: "" },
  email: { type: String, unique: true, required: true },
  purchases: [{ type: Schema.Types.ObjectId, ref: "post" }], //구매내역
  sales: [{ type: Schema.Types.ObjectId, ref: "post" }], //판매내역
  valid: { type: Boolean, default: false }, //학번 인증 여부
  hakbun: { type: String, default: "" },
  chats: [{ type: Schema.Types.ObjectId, ref: "chat" }],
  wish: [{ type: Schema.Types.ObjectId, ref: "post" }],
  keywords: [String]
})
const PostSchema = new Schema({
  user: { type: Schema.Types.ObjectId, ref: "user", required: true },
  category: { type: Schema.Types.ObjectId, ref: "category", required: true },
  title: { type: String, default: "" },
  content: { type: String, default: "" },
  price: { type: Number, default: 0 },
  view: { type: Number, default: 0 },
  wish: { type: Number, default: 0 },
  chat: { type: Number, default: 0 },
  created: { type: Date, default: Date.now },
  updated: { type: Date, default: Date.now },
  images: [new Schema({ url: String, thumb: String })],
  locationLat: { type: Number, default: 36.3708602 },
  locationLng: { type: Number, default: 127.3625224 },
  isBook: { type: Boolean, default: false },
  bookMajor: String,
  bookAuthor: String,
  bookPublisher: String,
  bookImage: String,
  bookPubDate: String,
  bookPrice: { type: Number, default: 0 },
  isSold: { type: Boolean, default: false }
})
const CategorySchema = new Schema({
  id: Number,
  name: String
})
const ChatSchema = new Schema({
  seller: { type: Schema.Types.ObjectId, ref: "user", required: true },
  sellerRead: { type: Date, default: Date.now },
  buyer: { type: Schema.Types.ObjectId, ref: "user", required: true },
  buyerRead: { type: Date, default: Date.now },
  messages: [
    new Schema({
      from: { type: Schema.Types.ObjectId, ref: "user", required: true },
      text: { type: String, default: "" },
      time: { type: Date, default: Date.now },
      showTime: { type: Boolean, default: true }
    })
  ],
  post: { type: Schema.Types.ObjectId, ref: "post", required: true }
})
// var user;
// var location;
// var category;

db.User = mongoose.model("user", UserSchema)
db.Post = mongoose.model("post", PostSchema)
db.Category = mongoose.model("category", CategorySchema)
db.Chat = mongoose.model("chat", ChatSchema)

module.exports = db
