require('dotenv').config()
const Sequelize = require("sequelize")

module.exports = {
  development: {
    username: process.env.DB_USER,
    password: process.env.DB_PASS,
    database: process.env.DB_NAME,
    host: process.env.DB_HOST,
    dialect: "mysql",
    logging: function(str) {
      const { "0": sql, "1": runCostMs, "2": options } = arguments
      if (runCostMs >= 500) {
        console.log("SQL 쿼리 비용이 너무 심함!!")
        console.log(`[${runCostMs}Ms] ${sql}`)
      }
    },
    benchmark: true,
    operatorsAliases: Sequelize.Op,
    timezone: "+09:00", // for writing to database
    pool: {
      max: 30,
      min: 0,
      idle: 10000,
      acquire: 60000
    },
    define: {
      freezeTableName: true
    }
  },
  test: {
    username: process.env.DB_USER,
    password: process.env.DB_PASS,
    database: process.env.DB_NAME,
    host: process.env.DB_HOST,
    dialect: "mysql",
    logging: function(str) {
      const { "0": sql, "1": runCostMs, "2": options } = arguments
      if (runCostMs >= 500) {
        console.log("SQL 쿼리 비용이 너무 심함!!")
        console.log(`[${runCostMs}Ms] ${sql}`)
      }
    },
    benchmark: true,
    operatorsAliases: Sequelize.Op,
    timezone: "+09:00", // for writing to database
    pool: {
      max: 30,
      min: 0,
      idle: 10000,
      acquire: 60000
    },
    define: {
      freezeTableName: true
    }
  },
  production: {
    username: process.env.DB_USER,
    password: process.env.DB_PASS,
    database: process.env.DB_NAME,
    host: process.env.DB_HOST,
    dialect: "mysql",
    timezone: "+09:00", // for writing to database
    logging: false,
    operatorsAliases: Sequelize.Op,
    pool: {
      max: 30,
      min: 0,
      idle: 10000,
      acquire: 60000
    },
    define: {
      freezeTableName: true
    }
  }
}
