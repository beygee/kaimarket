const moment = require("moment")

moment.updateLocale("ko", {
  relativeTime: {
    future: "",
    past: "%s",
    s: "방금",
    ss: "%d초 전",
    m: "1분 전",
    mm: "%d분 전",
    h: "1시간 전",
    hh: "%d시간 전",
    d: "어제",
    ////////////////// 밑에 안씀.
    dd: "%d일 전",
    M: "한달 전",
    MM: "%d달 전",
    y: "일년 전",
    yy: "%d년 전"
  },
  meridiem: function(hours, minutes, isLower) {
    return hours < 12 ? "오전" : "오후"
  }
})

moment.relativeTimeThreshold("s", 60)
moment.relativeTimeThreshold("ss", 10)
moment.relativeTimeThreshold("m", 60)
moment.relativeTimeThreshold("h", 24)
moment.relativeTimeThreshold("d", 31)
moment.relativeTimeThreshold("M", 12)

moment.relativeTimeRounding(Math.floor)

module.exports = moment
