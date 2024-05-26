const Aluno = require('../repository/aluno')
const Anotacao = require('../repository/anotacao')
const Curso = require('../repository/curso')
const Disciplina = require('../repository/disciplina')
const Horario = require('../repository/horario')
const Inscricao = require('../repository/inscricao')
const Presenca = require('../repository/presenca')
const Professor = require('../repository/professor')
const Requisito = require('../repository/requisito')
const Turma = require('../repository/turma')
const Progresso = require('../repository/progresso')

// Aluno <-> Inscrição
Aluno.hasMany(Inscricao, { foreignKey: { name: 'idAluno', field: 'idaluno' }, as: 'alunoinscricao' })
Inscricao.belongsTo(Aluno, { targetKey: 'id', foreignKey: { name: 'idAluno', field: 'idaluno' }, as: 'inscricaoaluno' })

// Curso <-> Aluno
Curso.hasMany(Aluno, { foreignKey: { name: 'idCurso', field: 'idcurso' }, as: 'cursoaluno' })
Aluno.belongsTo(Curso, { targetKey: 'id', foreignKey: { name: 'idCurso', field: 'idcurso' }, as: 'alunocurso' })

// Curso <-> Disciplina
Curso.hasMany(Disciplina, { foreignKey: { name: 'idCurso', field: 'idcurso' }, as: 'cursodisciplina' })
Disciplina.belongsTo(Curso, { targetKey: 'id', foreignKey: { name: 'idCurso', field: 'idcurso' }, as: 'disciplinacurso' })

// Disciplina <-> Turma
Disciplina.hasMany(Turma, { foreignKey: { name: 'idDisciplina', field: 'iddisciplina' }, as: 'disciplinaturma' })
Turma.belongsTo(Disciplina, { targetKey: 'id', foreignKey: { name: 'idDisciplina', field: 'iddisciplina' }, as: 'turmadisciplina' })

// Disciplina <-> Requisito (Base)
Disciplina.hasMany(Requisito, { foreignKey: { name: 'idDisciplina', field: 'iddisciplina' }, as: 'disciplinabaserequisito' })
Requisito.belongsTo(Disciplina, { targetKey: 'id', foreignKey: { name: 'idDisciplina', field: 'iddisciplina' }, as: 'requisitodisciplinabase' })

// Disciplina <-> Requisito (Disciplina Requisito)
Disciplina.hasMany(Requisito, { foreignKey: { name: 'idDisciplinaRequisito', field: 'iddisciplinarequisito' }, as: 'disciplinarequisito' })
Requisito.belongsTo(Disciplina, { targetKey: 'id', foreignKey: { name: 'idDisciplinaRequisito', field: 'iddisciplinarequisito' }, as: 'requisitodisciplina' })

// Horario <-> Turma
Horario.belongsTo(Turma, { targetKey: 'id', foreignKey: { name: 'idTurma', field: 'idturma' }, as: 'horarioturma' })
Turma.hasMany(Horario, { foreignKey: { name: 'idTurma', field: 'idturma' }, as: 'turmahorario' })

// Inscricao <-> Turma
Inscricao.belongsTo(Turma, { targetKey: 'id', foreignKey: { name: 'idTurma', field: 'idturma' }, as: 'inscricaoturma' })
Turma.hasMany(Inscricao, { foreignKey: { name: 'idTurma', field: 'idturma' }, as: 'turmainscricao' })

// Presenca <-> Professor
Presenca.belongsTo(Professor, { targetKey: 'id', foreignKey: { name: 'idProfessor', field: 'idprofessor' }, as: 'presencaprofessor' })
Professor.hasOne(Presenca, { foreignKey: { name: 'idProfessor', field: 'idprofessor' }, as: 'professorpresenca' })

// Professsor <-> Turma
Professor.hasMany(Turma, { foreignKey: { name: 'idProfessor', field: 'idprofessor' }, as: 'professorturma' })
Turma.belongsTo(Professor, { targetKey: 'id', foreignKey: { name: 'idProfessor', field: 'idprofessor' }, as: 'turmaprofessor' })

// Aluno <-> Anotacao
Aluno.hasMany(Anotacao, { foreignKey: { name: 'idAluno', field: 'idaluno' }, as: 'alunoanotacao' })
Anotacao.belongsTo(Aluno, { targetKey: 'id', foreignKey: { name: 'idAluno', field: 'idaluno' }, as: 'anotacaoaluno' })

// Disciplina <-> Anotacao
Disciplina.hasMany(Anotacao, { foreignKey: { name: 'idDisciplina', field: 'iddisciplina' }, as: 'disciplinaanotacao' })
Anotacao.belongsTo(Disciplina, { targetKey: 'id', foreignKey: { name: 'idDisciplina', field: 'iddisciplina' }, as: 'anotacaodisciplina' })

// Aluno <-> Inscrição
Aluno.hasMany(Progresso, { foreignKey: { name: 'idAluno', field: 'idaluno' }, as: 'alunoprogresso' })
Progresso.belongsTo(Aluno, { targetKey: 'id', foreignKey: { name: 'idAluno', field: 'idaluno' }, as: 'progressoaluno' })

// Inscricao <-> Turma
Progresso.belongsTo(Disciplina, { targetKey: 'id', foreignKey: { name: 'idDisciplina', field: 'iddisciplina' }, as: 'progressodisciplina' })
Disciplina.hasMany(Progresso, { foreignKey: { name: 'idDisciplina', field: 'iddisciplina' }, as: 'disciplinaprogresso' })

console.log('Relações definidas')
