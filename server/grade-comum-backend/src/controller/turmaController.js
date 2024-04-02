const router = require('express').Router()
const Turma = require('../repository/turma')
const Aluno = require('../repository/aluno')
const Disciplina = require('../repository/disciplina')
const Professor = require('../repository/professor')

router.get('/', async (req, res, next) => {
  try {
    const turmas = await Turma.findAll({
      include: [Disciplina, Professor],
      order: ['numero']
    })
    res.status(200)
    res.json(turmas.map(d => d.toJSON()))
  } catch (error) {
    console.error(error)
    next(error)
  }
})

router.post('/', async (req, res, next) => {
  try {
    const dataRequisicao = req.body
    const turma = await Turma.create(dataRequisicao)
    res.status(201)
    res.json(turma.toJSON())
  } catch (error) {
    console.error(error)
    next(error)
  }
})

router.get('/aluno', async (req, res, next) => {
  try {
    const { idAluno } = req.query
    const turmas = await Turma.findAll({
      include: [{
        model: Aluno, where: { id: idAluno }, attributes: []
      }, Disciplina, Professor],
      order: ['numero']
    })
    res.status(200)
    res.json(turmas.map(d => d.toJSON()))
  } catch (error) {
    console.error(error)
    next(error)
  }
})

module.exports = router
