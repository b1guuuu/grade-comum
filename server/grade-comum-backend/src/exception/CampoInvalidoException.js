class CampoInvalidoException extends Error {
  constructor (campo = '') {
    super(`O campo ${campo} está inválido`)
    this.nome = 'CampoInvalido'
    this.idError = 1
  }
}

module.exports = CampoInvalidoException
