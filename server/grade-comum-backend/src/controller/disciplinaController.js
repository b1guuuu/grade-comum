const router = require('express').Router()
const Disciplina = require('../repository/disciplina')
const Turma = require('../repository/turma')
const Inscricao = require('../repository/inscricao')
const Anotacao = require('../repository/anotacao')
const Requisito = require('../repository/requisito')
const Professor = require('../repository/professor')
const { disciplinaComRequisitosFormatados, disciplinaComCurso } = require('../util/criaObjetoComPropriedadeRenomeada')
const { Op } = require('sequelize')
const { conexao } = require('../util/conexao')
const Curso = require('../repository/curso')
const AcaoInvalidaException = require('../exception/AcaoInvalidaException')

router.get('/', async (req, res, next) => {
  try {
    let disciplinas = await Disciplina.findAll({
      include: [
        { model: Curso, as: 'disciplinacurso', required: true }
      ],
      order: ['nome']
    })
    disciplinas = disciplinas.map((disciplina) => disciplinaComCurso(disciplina))
    res.status(200)
    res.json(disciplinas)
  } catch (error) {
    console.error(error)
    next(error)
  }
})

router.get('/requisitos', async (req, res, next) => {
  try {
    const { id } = req.query
    const disciplinas = await Disciplina.findAll({
      where: {
        id: {
          [Op.in]: conexao.literal(`(SELECT requisito.iddisciplinarequisito from requisito WHERE requisito.iddisciplina=${id})`)
        }
      }
    })
    res.status(200)
    res.json(disciplinas.map(d => d.toJSON()))
  } catch (error) {
    console.error(error)
    next(error)
  }
})

router.get('/curso', async (req, res, next) => {
  try {
    const { idCurso } = req.query
    const disciplinas = await Disciplina.findAll({
      where: {
        idCurso
      },
      order: ['nome']
    })
    res.status(200)
    res.json(disciplinas.map(d => d.toJSON()))
  } catch (error) {
    console.error(error)
    next(error)
  }
})

router.get('/ppc', async (req, res, next) => {
  try {
    const { idCurso } = req.query
    let disciplinas = await Disciplina.findAll({
      include: [
        {
          model: Requisito,
          as: 'disciplinabaserequisito',
          required: false,
          include: [
            { model: Disciplina, as: 'requisitodisciplina', required: false }
          ]
        }
      ],
      where: { idCurso },
      order: ['periodo']
    })
    disciplinas = disciplinas.map((disciplina) => disciplinaComRequisitosFormatados(disciplina))
    res.status(200)
    res.json(disciplinas)
  } catch (error) {
    console.error(error)
    next(error)
  }
})

router.post('/', async (req, res, next) => {
  try {
    const { requisitos, ...dadosNovaDisciplina } = req.body
    const disciplina = await Disciplina.create(dadosNovaDisciplina)
    const dadosRequisitos = requisitos == null ? [] : requisitos.map((requisito) => { return { idDisciplina: disciplina.id, idDisciplinaRequisito: requisito.id } })
    const requisitosInseridos = await Requisito.bulkCreate(dadosRequisitos)
    res.status(201)
    res.json({ ...disciplina.toJSON(), requisitos: requisitosInseridos.map((requisito) => requisito.toJSON()) })
  } catch (error) {
    console.error(error)
    next(error)
  }
})

router.delete('/', async (req, res, next) => {
  try {
    const dataRequisicao = req.body
    const disciplina = Disciplina.build(dataRequisicao)
    await disciplina.destroy()
    res.status(204)
    res.json()
  } catch (error) {
    console.error(error)
    if (error.name === 'SequelizeForeignKeyConstraintError') {
      next(new AcaoInvalidaException('EXCLUIR', 'DISCIPLINA', `Registro possui relação com tabela ${error.parent.table}`))
    }
    next(error)
  }
})

router.get('/aluno/anotacoes', async (req, res, next) => {
  try {
    const { idAluno } = req.query

    const disciplinas = await Disciplina.findAll({
      include: [
        { model: Anotacao, required: true, as: 'disciplinaanotacao', where: { idAluno }, attributes: [] }
      ],
      order: ['nome']
    })

    res.status(200)
    res.json(disciplinas)
  } catch (error) {
    console.error(error)
    next(error)
  }
})

router.get('/aluno/inscrito', async (req, res, next) => {
  try {
    const { idAluno } = req.query

    const disciplinas = await Disciplina.findAll({
      include: [
        {
          model: Turma,
          required: true,
          as: 'disciplinaturma',
          include: [
            { model: Inscricao, required: true, as: 'turmainscricao', where: { idAluno }, attributes: [] }
          ],
          attributes: []
        }
      ],
      order: ['nome']
    })

    res.status(200)
    res.json(disciplinas)
  } catch (error) {
    console.error(error)
    next(error)
  }
})

router.get('/professor', async (req, res, next) => {
  try {
    const { idProfessor } = req.query

    const disciplinas = await Disciplina.findAll({
      include: [
        {
          model: Turma,
          required: true,
          as: 'disciplinaturma',
          include: [
            { model: Professor, required: true, as: 'turmaprofessor', where: { id: idProfessor }, attributes: [] }
          ],
          attributes: []
        }
      ],
      order: ['nome']
    })

    res.status(200)
    res.json(disciplinas)
  } catch (error) {
    console.error(error)
    next(error)
  }
})

module.exports = router
