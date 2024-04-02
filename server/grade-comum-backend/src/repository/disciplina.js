const { DataTypes } = require('sequelize')
const { conexao } = require('../util/conexao')

module.exports = conexao.define('disciplina', {
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
}, { tableName: 'disciplina', timestamps: false })
