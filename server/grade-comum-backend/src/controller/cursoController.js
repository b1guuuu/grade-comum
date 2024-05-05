const Curso = require('../repository/curso')

const router = require('express').Router()

router.get('/', async (req, res, next) => {
  try {
    const cursos = await Curso.findAll({
      order: ['nome']
    })
    res.status(200)
    res.json(cursos.map(d => d.toJSON()))
  } catch (error) {
    console.error(error)
    next(error)
  }
})

router.post('/', async (req, res, next) => {
  try {
    const dataRequisicao = req.body
    const curso = await Curso.create(dataRequisicao)
    res.status(201)
    res.json(curso.toJSON())
  } catch (error) {
    console.error(error)
    next(error)
  }
})

router.delete('/', async (req, res, next) => {
  try {
    const dataRequisicao = req.body
    const curso = Curso.build(dataRequisicao)
    await curso.destroy()
    res.status(204)
    res.json()
  } catch (error) {
    console.error(error)
    next(error)
  }
})

module.exports = router
