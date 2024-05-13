const router = require('express').Router()
const Presenca = require('../repository/presenca')
const Professor = require('../repository/professor')

router.get('/', async (req, res, next) => {
  try {
    const professores = await Professor.findAll({
      order: ['nome']
    })
    res.status(200)
    res.json(professores.map(d => d.toJSON()))
  } catch (error) {
    console.error(error)
    next(error)
  }
})

router.post('/', async (req, res, next) => {
  try {
    const dataRequisicao = req.body
    const professor = await Professor.create(dataRequisicao)
    const presenca = Presenca.build({ presente: true, idProfessor: professor.id })
    await presenca.save()
    res.status(201)
    res.json(professor.toJSON())
  } catch (error) {
    console.error(error)
    next(error)
  }
})

router.put('/', async (req, res, next) => {
  try {
    const { id, nome } = req.body
    const professor = await Professor.findByPk(id)
    professor.nome = nome
    await professor.save()
    res.status(204)
    res.json()
  } catch (error) {
    console.error(error)
    next(error)
  }
})

router.delete('/', async (req, res, next) => {
  try {
    const dataRequisicao = req.body
    const professor = Professor.build(dataRequisicao)
    await professor.destroy()
    res.status(204)
    res.json()
  } catch (error) {
    console.error(error)
    next(error)
  }
})

module.exports = router
