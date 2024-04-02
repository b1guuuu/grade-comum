class NaoEncontradoException extends Error {
  constructor (modelo = '') {
    super(`${modelo} não encontrado`)
    this.nome = 'NaoEncontrado'
    this.idError = 2
  }
}

module.exports = NaoEncontradoException
