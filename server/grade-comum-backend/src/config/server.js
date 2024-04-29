// Importa o express e middlewares base
const express = require('express')
const cors = require('cors')

// Importa exceções customizadas
const CampoInvalidoException = require('../exception/CampoInvalidoException')
const NaoEncontradoException = require('../exception/NaoEncontradoException')
const RequisicaoInvalidaException = require('../exception/RequisicaoInvalidaException')
const AlunoInvalidoException = require('../exception/AlunoInvalidoException')

// Importa arquivos responsáveis por cada rota
const disciplinaController = require('../controller/disciplinaController')
const alunoController = require('../controller/alunoController')
const professorController = require('../controller/professorController')
const turmaController = require('../controller/turmaController')
const inscricaoController = require('../controller/inscricaoController')
const horarioController = require('../controller/horarioController')
const anotacaoController = require('../controller/anotacaoController')
const cursoController = require('../controller/cursoController')

// Cria instância do servidor
const app = express()

// Implementa os middlewares no servidor
app.use(cors({ origin: '*', methods: ['GET', 'POST', 'DELETE', 'PUT'] }))
app.use(express.json())
app.use(express.urlencoded({ extended: true }))

// Denomina as rotas
app.use('/disciplina', disciplinaController)
app.use('/aluno', alunoController)
app.use('/professor', professorController)
app.use('/turma', turmaController)
app.use('/inscricao', inscricaoController)
app.use('/horario', horarioController)
app.use('/anotacao', anotacaoController)
app.use('/curso', cursoController)

// Trata os erros que ocorrerem durante o processamento
app.use((error, req, res, next) => {
  let status = 500
  if (error instanceof NaoEncontradoException) {
    status = 404
  }
  if (error instanceof CampoInvalidoException || error instanceof RequisicaoInvalidaException || error instanceof AlunoInvalidoException) {
    status = 400
  }
  res.status(status)
  res.send({
    id: error.idError,
    message: error.message,
    error
  }
  )
})

module.exports = app
