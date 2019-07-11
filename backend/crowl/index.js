const puppeteer = require("puppeteer")

const start = async (authId, authPassword) => {
  const browser = await puppeteer.launch({ headless: false })
  const page = await browser.newPage()

  let result = false
  page.on("dialog", async dialog => {
    await dialog.dismiss()
    const message = dialog.message()
    result = false
  })

  try {
    await page.goto("https://portalsso.kaist.ac.kr/login.ps", {
      waitUntil: "networkidle0"
    })

    await page.waitFor("#userId")
    await page.waitFor("#password")

    await page.type("#userId", authId, { delay: 30 })
    await page.type("#password", authPassword, { delay: 30 })

    await Promise.all([
      page.waitForNavigation({ waitUntil: "networkidle0" }),
      page.click("#btn_login")
    ])

    //로그인 성공
    try {
      const bSuccess = await page.waitFor("#ptl_wrap", { timeout: 5000 })
      if (bSuccess) result = true
    } catch (e) {}

    return !!result
  } catch (e) {
    console.log(e)
  } finally {
    await page.close()
    await browser.close()
  }
}

module.exports = start
