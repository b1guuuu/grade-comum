const Aluno = require('../repository/aluno')
const Disciplina = require('../repository/disciplina')
const Horario = require('../repository/horario')
const Inscricao = require('../repository/inscricao')
const Presenca = require('../repository/presenca')
const Professor = require('../repository/professor')
const Turma = require('../repository/turma')

Aluno.hasMany(Inscricao, { foreignKey: { name: 'idAluno', field: 'idaluno' }, as: 'alunoinscricao' })
Inscricao.belongsTo(Aluno, { targetKey: 'id', foreignKey: { name: 'idAluno', field: 'idaluno' }, as: 'inscricaoaluno' })

Disciplina.hasMany(Turma, { foreignKey: { name: 'idDisciplina', field: 'iddisciplina' }, as: 'disciplinaturma' })
Turma.belongsTo(Disciplina, { targetKey: 'id', foreignKey: { name: 'idDisciplina', field: 'iddisciplina' }, as: 'turmadisciplina' })

Horario.belongsTo(Turma, { targetKey: 'id', foreignKey: { name: 'idTurma', field: 'idturma' }, as: 'horarioturma' })
Turma.hasMany(Horario, { foreignKey: { name: 'idTurma', field: 'idturma' }, as: 'turmahorario' })

Inscricao.belongsTo(Turma, { targetKey: 'id', foreignKey: { name: 'idTurma', field: 'idturma' }, as: 'inscricaoturma' })
Turma.hasMany(Inscricao, { foreignKey: { name: 'idTurma', field: 'idturma' }, as: 'turmainscricao' })

Presenca.belongsTo(Professor, { targetKey: 'id', foreignKey: { name: 'idProfessor', field: 'idprofessor' }, as: 'presencaprofessor' })
Professor.hasOne(Presenca, { foreignKey: { name: 'idProfessor', field: 'idprofessor' }, as: 'professorpresenca' })

Professor.hasMany(Turma, { foreignKey: { name: 'idProfessor', field: 'idprofessor' }, as: 'professorturma' })
Turma.belongsTo(Professor, { targetKey: 'id', foreignKey: { name: 'idProfessor', field: 'idprofessor' }, as: 'turmaprofessor' })

console.log('Relações definidas')
