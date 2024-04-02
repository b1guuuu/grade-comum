const Inscricao = require('../repository/inscricao')

const router = require('express').Router()

router.get('/', async (req, res, next) => {
  try {
    const inscricoes = await Inscricao.findAll()
    res.status(200)
    res.json(inscricoes.map(d => d.toJSON()))
  } catch (error) {
    console.error(error)
    next(error)
  }
})

router.post('/', async (req, res, next) => {
  try {
    const dataRequisicao = req.body
    const inscricao = await Inscricao.create(dataRequisicao)
    res.status(201)
    res.json(inscricao.toJSON())
  } catch (error) {
    console.error(error)
    next(error)
  }
})

module.exports = router
