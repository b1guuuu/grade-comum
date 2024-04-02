const { DataTypes } = require('sequelize')
const { conexao } = require('../util/conexao')

module.exports = conexao.define('professor', {
  id: {
    type: DataTypes.INTEGER,
    primaryKey: true,
    autoIncrement: true,
    allowNull: false
  },
  nome: {
    type: DataTypes.STRING,
    allowNull: false
  }
}, { tableName: 'professor', timestamps: false })
