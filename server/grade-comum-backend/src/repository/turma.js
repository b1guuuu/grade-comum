const { DataTypes } = require('sequelize')
const { conexao } = require('../util/conexao')

const Turma = conexao.define('turma', {
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
    type: DataTypes.INTEGER,
    references: {
      model: 'disciplina',
      key: 'id'
    },
    field: 'iddisciplina'
  },
  idProfessor: {
    type: DataTypes.INTEGER,
    references: {
      model: 'professor',
      key: 'id'
    },
    field: 'idprofessor'
  }
}, { tableName: 'turma', timestamps: false, freezeTableName: true })

module.exports = Turma
