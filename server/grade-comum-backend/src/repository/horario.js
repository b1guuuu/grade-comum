const { DataTypes } = require('sequelize')
const { conexao } = require('../util/conexao')
const Turma = require('./turma')

const Horario = conexao.define('horario', {
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
    type: DataTypes.INTEGER,
    references: {
      model: 'turma',
      key: 'id'
    },
    field: 'idturma'
  }
}, { tableName: 'horario', timestamps: false })

Turma.hasMany(Horario, {
  foreignKey: 'id'
})
Horario.belongsTo(Turma, { foreignKey: { name: 'idTurma', field: 'idturma' }, targetKey: 'id' })

module.exports = Horario
