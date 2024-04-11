const { DataTypes } = require('sequelize')
const { conexao } = require('../util/conexao')

const Anotacao = conexao.define('anotacao', {
  id: {
    type: DataTypes.INTEGER,
    primaryKey: true,
    autoIncrement: true,
    allowNull: false
  },
  conteudo: {
    type: DataTypes.STRING,
    allowNull: false
  },
  dataCalendario: {
    type: DataTypes.DATE,
    allowNull: true,
    field: 'datacalendario'
  },
  tituloCalendario: {
    type: DataTypes.STRING,
    allowNull: true,
    field: 'titulocalendario'
  },
  idAluno: {
    type: DataTypes.INTEGER,
    references: {
      model: 'aluno',
      key: 'id'
    },
    field: 'idaluno'
  },
  idDisciplina: {
    type: DataTypes.INTEGER,
    references: {
      model: 'disciplina',
      key: 'id'
    },
    field: 'iddisciplina'
  }
}, { tableName: 'anotacao', timestamps: false, freezeTableName: true })

module.exports = Anotacao
