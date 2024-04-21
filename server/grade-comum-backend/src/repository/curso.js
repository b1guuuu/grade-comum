const { DataTypes } = require('sequelize')
const { conexao } = require('../util/conexao')

const Curso = conexao.define('curso', {
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
}, { tableName: 'curso', timestamps: false, freezeTableName: true })

module.exports = Curso
