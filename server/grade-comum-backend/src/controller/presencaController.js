const router = require('express').Router()
const { Op } = require('sequelize')
const Presenca = require('../repository/presenca')
const Professor = require('../repository/professor')
const Turma = require('../repository/turma')
const { presencaComProfessor } = require('../util/criaObjetoComPropriedadeRenomeada')
const { conexao } = require('../util/conexao')

router.get('/', async (req, res, next) => {
  try {
    let presencas = await Presenca.findAll({
      include: [{ model: Professor, as: 'presencaprofessor' }],
      order: ['ultimaatualizacao']
    })
    presencas = presencas.map((presenca) => presencaComProfessor(presenca))
    res.status(200)
    res.json(presencas)
  } catch (error) {
    console.error(error)
    next(error)
  }
})

router.get('/aluno', async (req, res, next) => {
  try {
    const { idAluno } = req.query
    let presencas = await Presenca.findAll({
      include: [{
        model: Professor,
        as: 'presencaprofessor',
        required: true,
        include: [
          {
            model: Turma,
            as: 'professorturma',
            required: true,
            attributes: [],
            where: {
              id: {
                [Op.in]: conexao.literal(`(SELECT idturma FROM inscricao WHERE idaluno=${idAluno})`)
              }
            }
          }
        ]
      }],
      order: ['ultimaatualizacao']
    })
    presencas = presencas.map((presenca) => presencaComProfessor(presenca))
    res.status(200)
    res.json(presencas)
  } catch (error) {
    console.error(error)
    next(error)
  }
})

router.get('/professor', async (req, res, next) => {
  try {
    const { idProfessor } = req.query
    let presenca = await Presenca.findOne({
      where: { idProfessor },
      include: [
        { model: Professor, as: 'presencaprofessor', required: true }
      ]
    })
    presenca = presencaComProfessor(presenca)
    res.status(200)
    res.json(presenca)
  } catch (error) {
    console.error(error)
    next(error)
  }
})

router.get('/faltas', async (req, res, next) => {
  try {
    let presencas = await Presenca.findAll({
      include: [{ model: Professor, required: true, as: 'presencaprofessor' }],
      where: { presente: false }
    })
    presencas = presencas.map((presenca) => presencaComProfessor(presenca))

    res.status(200)
    res.json(presencas)
  } catch (error) {
    console.error(error)
    next(error)
  }
})

router.put('/', async (req, res, next) => {
  try {
    const { id, presente, observacao, ultimaAtualizacao } = req.body

    const presenca = await Presenca.findOne({ where: { id } })

    presenca.set('presente', presente)
    presenca.set('observacao', observacao)
    presenca.set('ultimaatualizacao', ultimaAtualizacao)

    await presenca.save()
    res.status(204)
    res.json()
  } catch (error) {
    console.error(error)
    next(error)
  }
})

module.exports = router
