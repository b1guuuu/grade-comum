const { DataTypes } = require('sequelize')
const { conexao } = require('../util/conexao')

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
    field: 'idprofessor',
    type: DataTypes.INTEGER
  }
}, { tableName: 'presenca', timestamps: false, freezeTableName: true })

module.exports = Presenca
