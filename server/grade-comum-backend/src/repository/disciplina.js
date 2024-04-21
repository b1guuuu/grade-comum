const { DataTypes } = require('sequelize')
const { conexao } = require('../util/conexao')

const Disciplina = conexao.define('disciplina', {
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
  idCurso: {
    type: DataTypes.INTEGER,
    references: {
      model: 'curso',
      key: 'id'
    },
    field: 'idcurso'
  }
}, { tableName: 'disciplina', timestamps: false, freezeTableName: true })

module.exports = Disciplina
