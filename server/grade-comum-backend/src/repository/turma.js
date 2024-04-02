const { DataTypes } = require('sequelize')
const { conexao } = require('../util/conexao')

module.exports = conexao.define('turma', {
  id: {
    type: DataTypes.INTEGER,
    primaryKey: true,
    autoIncrement: true,
    allowNull: false
  },
  codigo: {
    type: DataTypes.INTEGER,
    allowNull: false
  },
  numero: {
    type: DataTypes.INTEGER,
    allowNull: false
  },
  idDisciplina: {
    references: {
      model: 'disciplina',
      key: 'id'
    }
  },
  idProfessor: {
    references: {
      model: 'professor',
      key: 'id'
    }
  }
}, { tableName: 'turma', timestamps: false })
