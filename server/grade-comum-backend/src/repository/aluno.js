const { DataTypes } = require('sequelize')
const { conexao } = require('../util/conexao')
const Turma = require('./turma')
const Inscricao = require('./inscricao')

const Aluno = conexao.define('aluno', {
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
  matricula: {
    type: DataTypes.STRING,
    allowNull: false
  },
  senha: {
    type: DataTypes.STRING,
    allowNull: false
  },
  senhaSalt: {
    type: DataTypes.STRING,
    allowNull: false,
    field: 'senhasalt'
  }
}, { tableName: 'aluno', timestamps: false })

Turma.belongsToMany(Aluno, { through: Inscricao, foreignKey: { name: 'idTurma', field: 'idturma' } })
Aluno.belongsToMany(Turma, { through: Inscricao, foreignKey: { name: 'idAluno', field: 'idaluno' } })

module.exports = Aluno
