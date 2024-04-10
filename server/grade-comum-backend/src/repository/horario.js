const { DataTypes } = require('sequelize')
const { conexao } = require('../util/conexao')

const Horario = conexao.define('horario', {
  id: {
    type: DataTypes.INTEGER,
    primaryKey: true,
    autoIncrement: true,
    allowNull: false
  },
  diaSemana: {
    type: DataTypes.INTEGER,
    allowNull: false,
    field: 'diasemana'
  },
  inicio: {
    type: DataTypes.STRING,
    allowNull: false
  },
  fim: {
    type: DataTypes.STRING,
    allowNull: false
  },
  sala: {
    type: DataTypes.STRING,
    allowNull: false
  },
  ordem: {
    type: DataTypes.INTEGER,
    allowNull: false
  },
  idTurma: {
    type: DataTypes.INTEGER,
    references: {
      model: 'turma',
      key: 'id'
    },
    field: 'idturma'
  }
}, { tableName: 'horario', timestamps: false, freezeTableName: true })

module.exports = Horario
