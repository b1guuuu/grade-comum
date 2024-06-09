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
router.put('/historico', async (req, res, next) => {
  try {
    const { idAluno, atualizacoes } = req.body

    const insercoes = []
    const exclucoes = []

    for (const atualizacao of atualizacoes) {
      if (atualizacao.acao === 'inserir') {
        insercoes.push({
          idDisciplina: atualizacao.idDisciplina,
          idAluno,
          concluido: true
        })
      } else {
        exclucoes.push(atualizacao.idDisciplina)
      }
    }

    console.log('')
    console.log(insercoes)
    console.log('')
    console.log('')
    console.log(exclucoes)
    console.log('')

    try {
      await Progresso.bulkCreate(insercoes)
    } catch (error) {
      console.error('Erro bulkCreate')
      console.error(error)
      next(error)
    }

    try {
      await Progresso.destroy({ where: { idDisciplina: exclucoes, idAluno } })
    } catch (error) {
      console.error('Erro destroy')
      console.error(error)
      next(error)
    }

    res.status(204)
    res.json()
  } catch (error) {
    console.error(error)
    next(error)
  }
})

module.exports = router
