const router = require('express').Router()
const { Op } = require('sequelize')
const Anotacao = require('../repository/anotacao')
const Disciplina = require('../repository/disciplina')

router.get('/', async (req, res, next) => {
  try {
    const anotacoes = await Anotacao.findAll()
    res.status(200)
    res.json(anotacoes)
  } catch (error) {
    console.error(error)
    next(error)
  }
})

router.get('/aluno', async (req, res, next) => {
  try {
    const { idAluno, idDisciplina } = req.query
    let anotacoes = await Anotacao.findAll({
      include: [
        { model: Disciplina, required: true, as: 'anotacaodisciplina', where: { id: idDisciplina } }
      ],
      where: { idAluno },
      order: ['iddisciplina']
    })

    anotacoes = anotacoes.map((anotacao) => {
      const anotacaoJson = anotacao.toJSON().renameProperty('anotacaodisciplina', 'disciplina')
      return anotacaoJson
    })
    res.status(200)
    res.json(anotacoes)
  } catch (error) {
    console.error(error)
    next(error)
  }
})

router.get('/calendario/aluno', async (req, res, next) => {
  try {
    const { idAluno } = req.query
    let anotacoes = await Anotacao.findAll({
      include: [
        { model: Disciplina, required: true, as: 'anotacaodisciplina' }
      ],
      where: { idAluno, dataCalendario: { [Op.not]: null } },
      order: ['datacalendario']
    })

    anotacoes = anotacoes.map((anotacao) => {
      const anotacaoJson = anotacao.toJSON().renameProperty('anotacaodisciplina', 'disciplina')
      return anotacaoJson
    })
    res.status(200)
    res.json(anotacoes)
  } catch (error) {
    console.error(error)
    next(error)
  }
})

router.post('/', async (req, res, next) => {
  try {
    const dataRequisicao = req.body
    console.log({ dataRequisicao })
    const anotacao = await Anotacao.create(dataRequisicao)
    res.status(201)
    res.json(anotacao.toJSON())
  } catch (error) {
    console.error(error)
    next(error)
  }
})

module.exports = router
