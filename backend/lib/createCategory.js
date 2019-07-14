module.exports = async Category => {
  const categories = [
    { id: 1, name: "디지털/가전" },
    { id: 2, name: "생활/가구" },
    { id: 3, name: "탈것" },
    { id: 4, name: "뷰티/미용" },
    { id: 5, name: "여성의류" },
    { id: 6, name: "남성의류" },
    { id: 7, name: "도서" },
    { id: 8, name: "기타" }
  ]

  for (category of categories) {
    const c = new Category(category)
    await c.save()
  }
}
