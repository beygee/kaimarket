const path = require("path")
const multer = require("koa-multer")

let storage = multer.diskStorage({
  destination: function(req, file, cb) {
    cb(null, "./public")
  },
  filename: function(req, file, cb) {
    cb(
      null,
      file.fieldname + "-" + Date.now() + path.extname(file.originalname)
    )
  }
})

const upload = multer({ storage: storage }).single("image")

module.exports = upload
