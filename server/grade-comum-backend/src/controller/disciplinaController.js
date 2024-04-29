const router = require('express').Router()
const Disciplina = require('../repository/disciplina')
const Turma = require('../repository/turma')
const Inscricao = require('../repository/inscricao')
const Anotacao = require('../repository/anotacao')
const Requisito = require('../repository/requisito')

router.get('/', async (req, res, next) => {
  try {
    const disciplinas = await Disciplina.findAll()
    res.status(200)
    res.json(disciplinas.map(d => d.toJSON()))
  } catch (error) {
    console.error(error)
    next(error)
  }
})

router.post('/', async (req, res, next) => {
  try {
    const { requisitos, ...dadosNovaDisciplina } = req.body
    const disciplina = await Disciplina.create(dadosNovaDisciplina)
    const dadosRequisitos = requisitos == null ? [] : requisitos.map((requisito) => { return { idDisciplina: disciplina.id, idDisciplinaRequisito: requisito.id } })
    const requisitosInseridos = await Requisito.bulkCreate(dadosRequisitos)
    res.status(201)
    res.json({ ...disciplina.toJSON(), requisitos: requisitosInseridos.map((requisito) => requisito.toJSON()) })
  } catch (error) {
    console.error(error)
    next(error)
  }
})

router.get('/aluno/anotacoes', async (req, res, next) => {
  try {
    const { idAluno } = req.query

    const disciplinas = await Disciplina.findAll({
      include: [
        { model: Anotacao, required: true, as: 'disciplinaanotacao', where: { idAluno }, attributes: [] }
      ],
      order: ['nome']
    })

    res.status(200)
    res.json(disciplinas)
  } catch (error) {
    console.error(error)
    next(error)
  }
})

router.get('/aluno/inscrito', async (req, res, next) => {
  try {
    const { idAluno } = req.query

    const disciplinas = await Disciplina.findAll({
      include: [
        {
          model: Turma,
          required: true,
          as: 'disciplinaturma',
          include: [
            { model: Inscricao, required: true, as: 'turmainscricao', where: { idAluno }, attributes: [] }
          ],
          attributes: []
        }
      ],
      order: ['nome']
    })

    res.status(200)
    res.json(disciplinas)
  } catch (error) {
    console.error(error)
    next(error)
  }
})
module.exports = router
