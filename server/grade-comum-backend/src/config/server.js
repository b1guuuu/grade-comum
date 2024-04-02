// Importa o express e middlewares base
const express = require('express')
const cors = require('cors')

// Importa exceções customizadas
const CampoInvalidoException = require('../exception/CampoInvalidoException')
const NaoEncontradoException = require('../exception/NaoEncontradoException')
const RequisicaoInvalidaException = require('../exception/RequisicaoInvalidaException')

// Importa arquivos responsáveis por cada rota
const disciplinaController = require('../controller/disciplinaController')

// Cria instância do servidor
const app = express()

// Implementa os middlewares no servidor
app.use(cors({ origin: '*', methods: ['GET', 'POST', 'DELETE', 'PUT'] }))
app.use(express.json())
app.use(express.urlencoded({ extended: true }))

// Denomina as rotas
app.use('/disciplina', disciplinaController)

// Trata os erros que ocorrerem durante o processamento
app.use((error, req, res, next) => {
  let status = 500
  if (error instanceof NaoEncontradoException) {
    status = 404
  }
  if (error instanceof CampoInvalidoException || error instanceof RequisicaoInvalidaException) {
    status = 400
  }
  res.status(status)
  res.send({
    id: error.idError,
    message: error.message
  }
  )
})

module.exports = app
