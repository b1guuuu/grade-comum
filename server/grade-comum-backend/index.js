const server = require('./src/config/server')
const { conexao } = require('./src/util/conexao')
require('./src/util/definirRelacoes')

const PORT = process.env.PORT

conexao.sync().then(() => {
  server.listen(PORT, () => { console.log(`Servidor executando na porta ${PORT}`) })
}).catch((e) => console.log(e))
