module.exports = {
  //객체에 존재하는 null 이나 undefined 값을 제거해준다.
  stripNull: data => {
    const retObj = {}
    Object.keys(data).forEach(key => {
      if (data[key]) {
        retObj[key] = data[key]
      }
    })

    return retObj
  }
}
