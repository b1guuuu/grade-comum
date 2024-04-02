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

    if (alunoRecuperadoDoBanco) {
      const senhasIguais = await encriptador.compararSenhas(alunoComDadosInformados.senha, alunoRecuperadoDoBanco.senha)
      if (senhasIguais) {
        alunoRecuperadoDoBanco.senha = ''
        alunoRecuperadoDoBanco.senhaSalt = ''
        res.status(200)
        res.json(alunoRecuperadoDoBanco)
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
    res.json(aluno)
  } catch (error) {
    console.error(error)
    next(error)
  }
})

module.exports = router
