const { DataTypes } = require('sequelize')
const { conexao } = require('../util/conexao')

const Professor = conexao.define('professor', {
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
}, { tableName: 'professor', timestamps: false, freezeTableName: true })

module.exports = Professor
