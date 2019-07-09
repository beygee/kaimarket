const moment = require("moment")

moment.updateLocale("ko", {
  meridiem: function(hours, minutes, isLower) {
    return hours < 12 ? "오전" : "오후"
  }
})

module.exports = moment
