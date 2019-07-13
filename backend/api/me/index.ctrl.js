const ctrl = {}
const mongoose = require("mongoose")

ctrl.getProfile = async ctx => {
  const { User } = ctx.db
  const { user } = ctx
  if (user) {
    //인증 검사
    const fetchedUser = await User.findById(mongoose.Types.ObjectId(user.id))
    ctx.body = fetchedUser
  } else {
    ctx.error(401, "NO VALID", { code: 1 })
  }
}

//앱 로그인 시, 로그인 토큰과 기기 토큰을 묶음.
//로그아웃 시 기기 토큰 제거
//푸시 시 토큰을 꺼내 만료일을 확인하고 지나지 않았으면 푸시.
//토큰 갱신시  DB도 같이  Update
ctrl.test = async ctx => {
  const { fb } = ctx
  const message = {
    // data: {
    //   score: "850",
    //   time: "2:45"
    // },
    token:
      "eIExHX8PEZ4:APA91bHrSlECO1xsWUrGBSd4EgKU4pyoFle3py0ILAXDHso7Cv6rMy5DctTBMoOwqPW5KgUeIHdo5D1lq4MSSBHx2iiToCq1QvWFmqUedkt5q0Su0xvQuqKfJjdBKlodbaYiiR0QdKM6",
    notification: {
      title: "제목",
      body: "컨텐츠"
    }
  }

  try {
    const res = await fb.messaging().send(message)
    console.log(res)
  } catch (e) {
    console.log(e)
  }

  ctx.body = "OK"
}

module.exports = ctrl
