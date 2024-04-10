const router = require('express').Router()
const Turma = require('../repository/turma')
const Disciplina = require('../repository/disciplina')
const Professor = require('../repository/professor')
const Horario = require('../repository/horario')
const { geradorHorarios } = require('../util/geradorHorarios')
const Inscricao = require('../repository/inscricao')

router.get('/', async (req, res, next) => {
  try {
    let turmas = await Turma.findAll({
      include: [{ model: Disciplina, as: 'turmadisciplina' }, { model: Professor, as: 'turmaprofessor' }],
      order: ['numero']
    })
    turmas = turmas.map((turma) => {
      const turmaJson = turma.toJSON().renameProperty('turmadisciplina', 'disciplina')
      turmaJson.renameProperty('turmaprofessor', 'professor')
      return turmaJson
    })
    res.status(200)
    res.json(turmas)
  } catch (error) {
    console.error(error)
    next(error)
  }
})

router.post('/', async (req, res, next) => {
  try {
    const dataRequisicao = req.body
    const turma = await Turma.create(dataRequisicao)

    const horariosBase = geradorHorarios(turma.numero, turma.id)

    for await (const horarioBase of horariosBase) {
      const horario = Horario.build(horarioBase)
      await horario.save()
    }

    res.status(201)
    res.json(turma)
  } catch (error) {
    console.error(error)
    next(error)
  }
})

router.get('/aluno', async (req, res, next) => {
  try {
    const { idAluno } = req.query
    let turmas = await Turma.findAll({
      include: [
        { model: Disciplina, as: 'turmadisciplina', required: true },
        { model: Professor, as: 'turmaprofessor', required: true },
        { model: Inscricao, as: 'turmainscricao', required: true, where: { idAluno } }
      ],
      order: ['numero']
    })
    turmas = turmas.map((turma) => {
      const turmaJson = turma.toJSON().renameProperty('turmadisciplina', 'disciplina')
      turmaJson.renameProperty('turmaprofessor', 'professor')
      turmaJson.renameProperty('turmainscricao', 'inscricao')
      return turmaJson
    })
    res.status(200)
    res.json(turmas)
  } catch (error) {
    console.error(error)
    next(error)
  }
})

module.exports = router
