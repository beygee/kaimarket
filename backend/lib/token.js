const jwt = require("jsonwebtoken")
const jwtSecret = "mySecret!kaimarket@@"
const moment = require("lib/moment")

function generateToken(payload) {
  return new Promise((res, rej) => {
    jwt.sign(payload, jwtSecret, { expiresIn: "7d" }, (err, token) => {
      if (err) rej(err)
      res(token)
    })
  })
}

function decodeToken(token) {
  return new Promise((res, rej) => {
    jwt.verify(token, jwtSecret, (err, decoded) => {
      if (err) rej(err)
      res(decoded)
    })
  })
}

exports.generateToken = generateToken
exports.decodeToken = decodeToken
exports.jwtMiddleware = async (ctx, next) => {
  const token = ctx.cookies.get("access_token")
  if (!token) return next()

  try {
    const decoded = await decodeToken(token)

    //토큰 만료일이 하루밖에 안남으면 토큰을 재발급한다.
    if (Date.now() / 1000 - decoded.iat > 60 * 60 * 24) {
      //하루가 지나면 갱신해준다.
      const { id, email } = decoded
      const freshToken = await generateToken({ id, email })
      ctx.cookies.set("access_token", freshToken, {
        maxAge: 1000 * 60 * 60 * 24 * 7,
        httpOnly: true
      })
    }
    ctx.user = decoded
  } catch (e) {
    ctx.user = null
  }

  return next()
}
