const router = require('express').Router()
const Disciplina = require('../repository/disciplina')

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
    const dataRequisicao = req.body
    const disciplina = await Disciplina.create(dataRequisicao)
    res.status(201)
    res.json(disciplina.toJSON())
  } catch (error) {
    console.error(error)
    next(error)
  }
})

module.exports = router
