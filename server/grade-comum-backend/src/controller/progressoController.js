const Progresso = require('../repository/progresso')

const router = require('express').Router()

router.get('/', async (req, res, next) => {
  try {
    const progressos = await Progresso.findAll({
      order: ['idAluno']
    })
    res.status(200)
    res.json(progressos.map(d => d.toJSON()))
  } catch (error) {
    console.error(error)
    next(error)
  }
})

router.get('/aluno', async (req, res, next) => {
  try {
    const { idAluno } = req.query
    const progressos = await Progresso.findAll({
      where: { idAluno },
      order: ['idDisciplina']
    })
    res.status(200)
    res.json(progressos.map(d => d.toJSON()))
  } catch (error) {
    console.error(error)
    next(error)
  }
})

router.put('/concluir', async (req, res, next) => {
  try {
    const { idDisciplina, idAluno } = req.body
    const progresso = await Progresso.findOne({
      where: {
        idDisciplina,
        idAluno
      }
    })
    progresso.concluido = true
    await progresso.save()
    res.status(204)
    res.json()
  } catch (error) {
    console.error(error)
    next(error)
  }
})

module.exports = router
