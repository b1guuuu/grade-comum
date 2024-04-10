const { conexao } = require('../util/conexao')
const { DataTypes } = require('sequelize')

const Inscricao = conexao.define('inscricao', {
  idTurma: {
    /*
    references: {
      model: 'turma',
      key: 'id'
    }, */
    primaryKey: true,
    field: 'idturma',
    type: DataTypes.INTEGER
  },
  idAluno: {
    /* references: {
      model: 'aluno',
      key: 'id'
    }, */
    primaryKey: true,
    field: 'idaluno',
    type: DataTypes.INTEGER
  }
}, { tableName: 'inscricao', timestamps: false, freezeTableName: true })

module.exports = Inscricao
