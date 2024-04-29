const { conexao } = require('../util/conexao')
const { DataTypes } = require('sequelize')

const Requisito = conexao.define('requisito', {
  idDisciplina: {
    type: DataTypes.INTEGER,
    references: {
      model: 'disciplina',
      key: 'id'
    },
    primaryKey: true,
    field: 'iddisciplina'
  },
  idDisciplinaRequisito: {
    type: DataTypes.INTEGER,
    references: {
      model: 'disciplina',
      key: 'id'
    },
    primaryKey: true,
    field: 'iddisciplinarequisito'
  }
}, { tableName: 'requisito', timestamps: false, freezeTableName: true })
module.exports = Requisito
