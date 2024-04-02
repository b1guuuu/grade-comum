const { DataTypes } = require('sequelize')
const { conexao } = require('../util/conexao')

module.exports = conexao.define('horario', {
  id: {
    type: DataTypes.INTEGER,
    primaryKey: true,
    autoIncrement: true,
    allowNull: false
  },
  diaSemana: {
    type: DataTypes.STRING,
    allowNull: false
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
  idTurma: {
    references: {
      model: 'turma',
      key: 'id'
    }
  }
}, { tableName: 'horario', timestamps: false })
