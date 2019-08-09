const path = require('path')
const uuidv1 = require('uuid/v1')

//아마존 SDK
const aws = require('aws-sdk')
aws.config.loadFromPath(path.resolve('config', 'awsconfig.json'))

//이미지 업로드 모듈
const multer = require('koa-multer')
const multerS3 = require('multer-sharp-s3')

const upload = multer({
  storage: multerS3({
    s3: new aws.S3(),
    Bucket: 'kaimarket.com',
    Key: function(req, file, cb) {
      //파일명 변경
      const filename = uuidv1() + path.extname(file.originalname)
      cb(null, `uploads/${filename}`)
    },
    ACL: 'public-read-write',
    resize: {
      width: 900,
      height: 500
    },
    max: true
  }),
  // limits: { fileSize: 1024 * 1024 * 3 /* 3MB */ }
})

module.exports = upload

// const path = require("path")
// const multer = require("koa-multer")

// let storage = multer.diskStorage({
//   destination: function(req, file, cb) {
//     cb(null, "./public")
//   },
//   filename: function(req, file, cb) {
//     cb(
//       null,
//       file.fieldname + "-" + Date.now() + path.extname(file.originalname)
//     )
//   }
// })

// const upload = multer({ storage: storage }).single("image")

// module.exports = upload
