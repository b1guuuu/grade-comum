const Horario = require('../repository/horario')
const Turma = require('../repository/turma')
const Disciplina = require('../repository/disciplina')
const Inscricao = require('../repository/inscricao')
const { horarioComTurmaEDisciplina } = require('../util/criaObjetoComPropriedadeRenomeada')

const router = require('express').Router()

router.get('/', async (req, res, next) => {
  try {
    const horarios = await Horario.findAll()
    res.status(200)
    res.json(horarios.map(d => d.toJSON()))
  } catch (error) {
    console.error(error)
    next(error)
  }
})

router.get('/aluno', async (req, res, next) => {
  try {
    const { idAluno } = req.query
    let horarios = await Horario.findAll({
      include: [
        {
          model: Turma,
          as: 'horarioturma',
          required: true,
          include: [
            { model: Disciplina, as: 'turmadisciplina', required: true },
            { model: Inscricao, as: 'turmainscricao', required: true, where: { idAluno }, attributes: [] }
          ]
        }
      ],
      order: ['diaSemana']
    })
    horarios = horarios.map((horario) => horarioComTurmaEDisciplina(horario))
    res.status(200)
    res.json(horarios)
  } catch (error) {
    console.error(error)
    next(error)
  }
})

router.get('/professor', async (req, res, next) => {
  try {
    const { idProfessor } = req.query
    const horarios = await Horario.findAll({
      include: [
        {
          model: Turma,
          as: 'horarioturma',
          required: true,
          attributes: [],
          where: { idProfessor }
        }
      ],
      order: ['diaSemana']
    })
    res.status(200)
    res.json(horarios)
  } catch (error) {
    console.error(error)
    next(error)
  }
})

router.get('/turma', async (req, res, next) => {
  try {
    const { idTurma } = req.query
    const horarios = await Horario.findAll({
      include: [
        {
          model: Turma,
          as: 'horarioturma',
          required: true,
          attributes: [],
          where: { id: idTurma }
        }
      ],
      order: ['diaSemana']
    })
    res.status(200)
    res.json(horarios)
  } catch (error) {
    console.error(error)
    next(error)
  }
})

router.post('/', async (req, res, next) => {
  try {
    const dataRequisicao = req.body
    const horario = await Horario.create(dataRequisicao)
    res.status(201)
    res.json(horario.toJSON())
  } catch (error) {
    console.error(error)
    next(error)
  }
})

router.delete('/', async (req, res, next) => {
  try {
    const dataRequisicao = req.body
    const horario = Horario.build(dataRequisicao)
    await horario.destroy()
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
    const horario = Horario.build(dataRequisicao)
    await horario.save()
    res.status(204)
    res.json()
  } catch (error) {
    console.error(error)
    next(error)
  }
})

router.put('/turma', async (req, res, next) => {
  try {
    const dataRequisicao = req.body
    for await (const data of dataRequisicao) {
      const horarioDB = await Horario.findByPk(data.id)
      horarioDB.sala = data.sala
      await horarioDB.save()
    }
    res.status(204)
    res.json()
  } catch (error) {
    console.error(error)
    next(error)
  }
})

module.exports = router
