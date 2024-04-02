const server = require('./src/config/server')

const PORT = process.env.PORT

server.listen(PORT, () => { console.log(`Servidor executando na porta ${PORT}`) })
