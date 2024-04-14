const router = require('express').Router()
const { Op } = require('sequelize')
const Anotacao = require('../repository/anotacao')
const Disciplina = require('../repository/disciplina')
const { anotacaoComDisciplina } = require('../util/criaObjetoComPropriedadeRenomeada')

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

    anotacoes = anotacoes.map((anotacao) => anotacaoComDisciplina(anotacao))
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

    anotacoes = anotacoes.map((anotacao) => anotacaoComDisciplina(anotacao))
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
    const anotacao = await Anotacao.create(dataRequisicao)
    res.status(201)
    res.json(anotacao.toJSON())
  } catch (error) {
    console.error(error)
    next(error)
  }
})

router.delete('/', async (req, res, next) => {
  try {
    const { id } = req.query
    await Anotacao.destroy({ where: { id } })
    res.status(204)
    res.json()
  } catch (error) {
    console.error(error)
    next(error)
  }
})

router.put('/', async (req, res, next) => {
  try {
    const dataRequisicao = req.body
    const anotacaoBanco = await Anotacao.findOne({ where: { id: dataRequisicao.id } })
    anotacaoBanco.conteudo = dataRequisicao.conteudo
    anotacaoBanco.dataCalendario = dataRequisicao.dataCalendario
    anotacaoBanco.tituloCalendario = dataRequisicao.dataCalendario
    await anotacaoBanco.save()
    res.status(204)
    res.json()
  } catch (error) {
    console.error(error)
    next(error)
  }
})
module.exports = router
