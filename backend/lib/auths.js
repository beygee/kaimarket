const mongoose = require("mongoose")

const auths = {}

auths.validAuth = async ctx => {
  const { User } = ctx.db
  const { user } = ctx

  //이메일로 회원가입했는지 구분한다.
  const fetchedUser = await User.findById(mongoose.Types.ObjectId(user.id))
  // // if(fetch)
  // if (!user) {
  //   const newUser = new User({ email, name })
  //   await newUser.save()

  //   //JWT 토큰
  //   const token = await generateToken({ id: newUser._id })
  //   ctx.set("access_token", token)
  //   ctx.body = { token, valid: false }
  // } else {
  //   //JWT 토큰
  //   const token = await generateToken({ id: user._id })
  //   ctx.set("access_token", token)
  //   ctx.body = { token, valid: user.valid || false }
  // }
}
module.exports = auths
