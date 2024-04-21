const { conexao } = require('../util/conexao')
const { DataTypes } = require('sequelize')

const Requisito = conexao.define('requisito', {
  idDisciplina: {
    references: {
      model: 'disciplina',
      key: 'id'
    },
    primaryKey: true,
    field: 'iddisciplina',
    type: DataTypes.INTEGER
  },
  idDisciplinaRequisito: {
    references: {
      references: {
        model: 'disciplina',
        key: 'id'
      },
      primaryKey: true,
      field: 'iddisciplinarequisito',
      type: DataTypes.INTEGER
    }
  }
}, { tableName: 'requisito', timestamps: false, freezeTableName: true })

module.exports = Requisito
