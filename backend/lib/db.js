const mongoose = require("mongoose")
const Schema = mongoose.Schema

const db = {}

const UserSchema = new Schema({
  name: String,
  email: { type: String, unique: true, required: true },
  purchases: [{ type: Schema.Types.ObjectId, ref: "post" }], //구매내역
  sales: [{ type: Schema.Types.ObjectId, ref: "post" }], //판매내역
  valid: Boolean, //학번 인증 여부
  hakbun: String //학번
})
const PostSchema = new Schema({
  _user: { type: Schema.Types.ObjectId, ref: "user" },
  title: String,
  price: Number,
  view: Number,
  created: { type: Date, default: Date.now }
})
// const Wish

db.User = mongoose.model("user", UserSchema)
db.Post = mongoose.model("post", PostSchema)

module.exports = db
