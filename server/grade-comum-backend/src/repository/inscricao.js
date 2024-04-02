const { conexao } = require('../util/conexao')

module.exports = conexao.define('inscricao', {
  idTurma: {
    references: {
      model: 'turma',
      key: 'id'
    },
    primaryKey: true
  },
  idAluno: {
    references: {
      model: 'aluno',
      key: 'id'
    },
    primaryKey: true
  }
}, { tableName: 'inscricao', timestamps: false })
