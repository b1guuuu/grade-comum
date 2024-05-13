const Inscricao = require('../repository/inscricao')
const Progresso = require('../repository/progresso')
const Disciplina = require('../repository/disciplina')
const Turma = require('../repository/turma')

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
    const disciplina = await Disciplina.findOne({
      include: [
        { model: Turma, required: true, as: 'disciplinaturma', attributes: [], where: { id: inscricao.idTurma } }
      ]
    })
    let progresso = await Progresso.findOne({
      where: {
        idDisciplina: disciplina.id,
        idAluno: inscricao.idAluno
      }
    })

    if (progresso == null) {
      progresso = await Progresso.create({
        idDisciplina: disciplina.id,
        idAluno: inscricao.idAluno
      })
    } else {
      progresso.tentativas = progresso.tentativas + 1
      await progresso.save()
    }

    res.status(201)
    res.json({
      inscricao: inscricao.toJSON(),
      disciplina: disciplina.toJSON(),
      progresso: progresso.toJSON()
    })
  } catch (error) {
    console.error(error)
    next(error)
  }
})

router.delete('/', async (req, res, next) => {
  try {
    const dataRequisicao = req.body
    const inscricao = Inscricao.build(dataRequisicao)
    await inscricao.destroy()
    res.status(204)
    res.json()
  } catch (error) {
    console.error(error)
    next(error)
  }
})

module.exports = router
