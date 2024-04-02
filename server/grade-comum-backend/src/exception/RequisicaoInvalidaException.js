class RequisicaoInvalidaException extends Error {
  constructor (campos = []) {
    super(`Não foram fornecidos dados para os campos: ${campos.join(', ')}`)
    this.nome = 'RequisicaoInvalida'
    this.idError = 3
  }
}

module.exports = RequisicaoInvalidaException
