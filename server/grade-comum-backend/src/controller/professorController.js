const router = require('express').Router()
const Professor = require('../repository/professor')

router.get('/', async (req, res, next) => {
  try {
    const professores = await Professor.findAll()
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
    res.status(201)
    res.json(professor.toJSON())
  } catch (error) {
    console.error(error)
    next(error)
  }
})

module.exports = router
