class AlunoInvalidoException extends Error {
  constructor () {
    super('Verifique os dados informados para o aluno')
    this.nome = 'AlunoInvalido'
    this.idError = 4
  }
}

module.exports = AlunoInvalidoException
