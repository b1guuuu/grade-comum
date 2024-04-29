const { conexao } = require('../util/conexao')
const { DataTypes } = require('sequelize')

const Progresso = conexao.define('progresso', {
  idDisciplina: {
    references: {
      model: 'disciplina',
      key: 'id'
    },
    primaryKey: true,
    field: 'iddisciplina',
    type: DataTypes.INTEGER
  },
  idAluno: {
    references: {
      model: 'aluno',
      key: 'id'
    },
    primaryKey: true,
    field: 'idaluno',
    type: DataTypes.INTEGER
  }
}, { tableName: 'progresso', timestamps: false, freezeTableName: true })

module.exports = Progresso
