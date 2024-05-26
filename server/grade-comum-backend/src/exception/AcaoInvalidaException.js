class AcaoInvalidaException extends Error {
  constructor (acao = '', tabela = '', motivo = '') {
    super(`A ação ${acao} na tabela ${tabela} é inválida. Motivo: ${motivo}`)
    this.nome = 'AcaoInvalida'
    this.idError = 5
  }
}

module.exports = AcaoInvalidaException
