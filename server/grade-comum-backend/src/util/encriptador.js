const bcrypt = require('bcrypt')
const saltRounds = 10

function criarSalt () {
  return bcrypt.genSalt(saltRounds)
}

function encriptarSenha (senha = '', salt = '') {
  return bcrypt.hash(senha, salt)
}

function compararSenhas (senhaInformada = '', senhaArmazenada = '') {
  return bcrypt.compare(senhaInformada, senhaArmazenada)
}

module.exports = {
  criarSalt, encriptarSenha, compararSenhas
}
