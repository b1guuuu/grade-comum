const { Sequelize } = require('sequelize')

const senha = process.env.POSTGRES_PASSWORD
const usuario = process.env.POSTGRES_USER
const db = process.env.POSTGRES_DB
const host = process.env.POSTGRES_HOST

const urlConexao = `postgres://${usuario}:${senha}@${host}:5432/${db}`

module.exports.conexao = new Sequelize(urlConexao)
