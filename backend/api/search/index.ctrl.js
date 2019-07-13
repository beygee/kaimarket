const request = require("request-promise")
const qs = require("querystring")

const ctrl = {}

ctrl.searchBooks = async ctx => {
  const { q } = ctx.query
  const { user } = ctx

  try {
    const body = await request.get(
      `https://openapi.naver.com/v1/search/book.json?query=${qs.escape(
        q.trim()
      )}`,
      {
        headers: {
          "X-Naver-Client-Id": "4Wvtvdy5d0rhfthK3TjR",
          "X-Naver-Client-Secret": "xMRm7bLEuY"
        }
      }
    )

    const data = JSON.parse(body)

    ctx.body = data
  } catch (e) {
    ctx.error(403, "INVALID SEARCH", { code: 1 })
  }
}

module.exports = ctrl
