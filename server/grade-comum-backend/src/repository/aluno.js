const { DataTypes } = require('sequelize')
const { conexao } = require('../util/conexao')

module.exports = conexao.define('aluno', {
  id: {
    type: DataTypes.INTEGER,
    primaryKey: true,
    autoIncrement: true,
    allowNull: false
  },
  nome: {
    type: DataTypes.STRING,
    allowNull: false
  },
  matricula: {
    type: DataTypes.STRING,
    allowNull: false
  },
  senha: {
    type: DataTypes.STRING,
    allowNull: false
  },
  senhaSalt: {
    type: DataTypes.STRING,
    allowNull: false,
    field: 'senhasalt'
  }
}, { tableName: 'aluno', timestamps: false })
