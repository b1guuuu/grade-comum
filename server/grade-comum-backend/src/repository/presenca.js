const { DataTypes } = require('sequelize')
const { conexao } = require('../util/conexao')
const Professor = require('./professor')

const Presenca = conexao.define('presenca', {
  id: {
    type: DataTypes.INTEGER,
    primaryKey: true,
    autoIncrement: true,
    allowNull: false
  },
  presente: {
    type: DataTypes.BOOLEAN,
    allowNull: false
  },
  observacao: {
    type: DataTypes.STRING
  },
  ultimaAtualizacao: {
    type: DataTypes.DATE,
    allowNull: false
  },
  idProfessor: {
    references: {
      model: 'professor',
      key: 'id'
    },
    field: 'idprofessor'
  }
}, { tableName: 'presenca', timestamps: false })

Professor.hasOne(Presenca, { foreignKey: 'id' })
Presenca.belongsTo(Professor, { foreignKey: { name: 'idProfessor', field: 'idprofessor' }, targetKey: 'id' })

module.exports = Presenca
