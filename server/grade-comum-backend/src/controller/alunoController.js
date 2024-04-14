const router = require('express').Router()
const Aluno = require('../repository/aluno')
const encriptador = require('../util/encriptador')
const NaoEncontradoException = require('../exception/NaoEncontradoException')
const AlunoInvalidoException = require('../exception/AlunoInvalidoException')

router.post('/login', async (req, res, next) => {
  try {
    const dataRequisicao = req.body
    const alunoComDadosInformados = Aluno.build(dataRequisicao)
    const alunoRecuperadoDoBanco = await Aluno.findOne({
      where: {
        matricula: dataRequisicao.matricula
      }
    })

    if (alunoRecuperadoDoBanco && alunoRecuperadoDoBanco !== null) {
      const senhasIguais = await encriptador.compararSenhas(alunoComDadosInformados.senha, alunoRecuperadoDoBanco.senha)
      if (senhasIguais) {
        alunoRecuperadoDoBanco.senha = ''
        alunoRecuperadoDoBanco.senhaSalt = ''
        res.status(200)
        res.json(alunoRecuperadoDoBanco.toJSON())
      } else {
        throw new AlunoInvalidoException()
      }
    } else {
      throw new NaoEncontradoException('Aluno')
    }
  } catch (error) {
    console.error(error)
    next(error)
  }
})

router.post('/cadastro', async (req, res, next) => {
  try {
    const dataRequisicao = req.body
    let aluno = Aluno.build(dataRequisicao)
    aluno.senhaSalt = await encriptador.criarSalt()
    aluno.senha = await encriptador.encriptarSenha(aluno.senha, aluno.senhaSalt)

    aluno = await aluno.save()
    aluno.senha = ''
    aluno.senhaSalt = ''
    res.status(201)
    res.json(aluno.toJSON())
  } catch (error) {
    console.error(error)
    next(error)
  }
})

router.put('/', async (req, res, next) => {
  try {
    const { id, nome, matricula, senha } = req.body
    const aluno = await Aluno.findOne({ where: { id } })
    aluno.set('nome', nome)
    aluno.set('matricula', matricula)
    if (senha && senha !== null) {
      const senhaSalt = await encriptador.criarSalt()
      aluno.set('senhaSalt', senhaSalt)
      const senhaEncriptada = await encriptador.encriptarSenha(senha, senhaSalt)
      aluno.set('senha', senhaEncriptada)
    }

    await aluno.save()
    res.status(204)
    res.json()
  } catch (error) {
    console.error(error)
    next(error)
  }
})

module.exports = router
