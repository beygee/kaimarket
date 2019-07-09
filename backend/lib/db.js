const mongoose = require("mongoose")
const Schema = mongoose.Schema

const db = {}

const UserSchema = new Schema({ name: String, email: String, password: String })
db.User = mongoose.model("user", UserSchema)

module.exports = db
