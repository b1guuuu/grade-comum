const router = require('express').Router()
const Turma = require('../repository/turma')
const Disciplina = require('../repository/disciplina')
const Professor = require('../repository/professor')
const Horario = require('../repository/horario')
const { geradorHorarios } = require('../util/geradorHorarios')
const { turmaComDisciplinaEProfessor, turmaComDisciplinaProfessorEInscricao, disciplinaComRequisitos } = require('../util/criaObjetoComPropriedadeRenomeada')
const Inscricao = require('../repository/inscricao')
const { Op } = require('sequelize')
const { conexao } = require('../util/conexao')
const Requisito = require('../repository/requisito')
const AcaoInvalidaException = require('../exception/AcaoInvalidaException')

router.get('/', async (req, res, next) => {
  try {
    let turmas = await Turma.findAll({
      include: [{ model: Disciplina, as: 'turmadisciplina' }, { model: Professor, as: 'turmaprofessor' }],
      order: ['numero']
    })
    turmas = turmas.map((turma) => turmaComDisciplinaEProfessor(turma))
    res.status(200)
    res.json(turmas)
  } catch (error) {
    console.error(error)
    next(error)
  }
})

router.post('/', async (req, res, next) => {
  try {
    const dataRequisicao = req.body
    const turma = await Turma.create(dataRequisicao)

    const horariosBase = geradorHorarios(turma.numero, turma.id)

    for await (const horarioBase of horariosBase) {
      const horario = Horario.build(horarioBase)
      await horario.save()
    }

    res.status(201)
    res.json(turma)
  } catch (error) {
    console.error(error)
    next(error)
  }
})

router.get('/aluno', async (req, res, next) => {
  try {
    const { idAluno } = req.query
    let turmas = await Turma.findAll({
      include: [
        { model: Disciplina, as: 'turmadisciplina', required: true },
        { model: Professor, as: 'turmaprofessor', required: true },
        { model: Inscricao, as: 'turmainscricao', required: true, where: { idAluno } }
      ],
      order: ['numero']
    })
    turmas = turmas.map((turma) => turmaComDisciplinaProfessorEInscricao(turma))
    res.status(200)
    res.json(turmas)
  } catch (error) {
    console.error(error)
    next(error)
  }
})

router.get('/aluno/disponiveis', async (req, res, next) => {
  try {
    const { idAluno } = req.query

    // Busca as turmas de disciplinas não concluídas
    let turmas = await Turma.findAll({
      include: [
        {
          model: Disciplina,
          required: true,
          as: 'turmadisciplina',
          where: {
            id: {
              [Op.notIn]: conexao.literal(`
                (SELECT iddisciplina FROM progresso WHERE idaluno = ${idAluno} AND concluido=true)
              `)
            }
          }
        },
        {
          model: Professor, required: true, as: 'turmaprofessor'
        }
      ]
    })
    turmas = turmas.map((turma) => turmaComDisciplinaEProfessor(turma))

    // Busca as disciplinas já concluídas
    const disciplinasConcluidas = await Disciplina.findAll({
      where: {
        id: {
          [Op.in]: conexao.literal(`
            (SELECT iddisciplina FROM progresso WHERE concluido=true)
          `)
        }
      }
    })

    // Buscas as disciplinas pendentes e seus respectivos requisitos
    let disciplinasPendentesComRequisitos = await Disciplina.findAll({
      include: [{
        model: Requisito, as: 'disciplinabaserequisito'
      }],
      where: {
        id: {
          [Op.notIn]: conexao.literal(`
            (SELECT iddisciplina FROM progresso WHERE concluido=true)
          `)
        }
      }
    })
    disciplinasPendentesComRequisitos = disciplinasPendentesComRequisitos.map((disciplina) => disciplinaComRequisitos(disciplina))
    const turmasValidas = []

    // Filtrando turmas, retornando apenas as que o aluno pode se inscrever
    for (const turma of turmas) {
      const indexTurmaDisciplinaConcluida = disciplinasConcluidas.findIndex((disciplinaConcluida) => disciplinaConcluida.id === turma.id)
      if (indexTurmaDisciplinaConcluida === -1) {
        const disciplinaPendenteComRequisitos = disciplinasPendentesComRequisitos.find((disciplinaPendente) => disciplinaPendente.id === turma.disciplina.id)
        let contadorRequisitosCumpridos = 0
        for (const requisito of disciplinaPendenteComRequisitos.requisitos) {
          const indexDisciplinaRequisitoJaConcluida = disciplinasConcluidas.findIndex((disciplinaConcluida) => disciplinaConcluida.id === requisito.idDisciplinaRequissito)
          if (indexDisciplinaRequisitoJaConcluida > -1) {
            contadorRequisitosCumpridos++
          }
        }
        if (contadorRequisitosCumpridos === disciplinaPendenteComRequisitos.requisitos.length) {
          turmasValidas.push(turma)
        }
      }
    }
    res.status(200)
    res.json(turmasValidas)
  } catch (error) {
    console.error(error)
    next(error)
  }
})

router.delete('/', async (req, res, next) => {
  try {
    const dataRequisicao = req.body
    const turma = Turma.build(dataRequisicao)
    await turma.destroy()
    res.status(204)
    res.json()
  } catch (error) {
    console.error(error)
    if (error.name === 'SequelizeForeignKeyConstraintError') {
      next(new AcaoInvalidaException('EXCLUIR', 'TURMA', `Registro possui relação com tabela ${error.parent.table}`))
    }
    next(error)
  }
})
module.exports = router
