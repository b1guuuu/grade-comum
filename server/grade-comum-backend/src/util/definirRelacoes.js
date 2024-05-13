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
Aluno.hasMany(Inscricao, { foreignKey: { name: 'idAluno', field: 'idaluno' }, as: 'alunoinscricao', onDelete: 'CASCADE', onUpdate: 'CASCADE' })
Inscricao.belongsTo(Aluno, { targetKey: 'id', foreignKey: { name: 'idAluno', field: 'idaluno' }, as: 'inscricaoaluno', onDelete: 'CASCADE', onUpdate: 'CASCADE' })

// Curso <-> Aluno
Curso.hasMany(Aluno, { foreignKey: { name: 'idCurso', field: 'idcurso' }, as: 'cursoaluno', onDelete: 'CASCADE', onUpdate: 'CASCADE' })
Aluno.belongsTo(Curso, { targetKey: 'id', foreignKey: { name: 'idCurso', field: 'idcurso' }, as: 'alunocurso', onDelete: 'CASCADE', onUpdate: 'CASCADE' })

// Curso <-> Disciplina
Curso.hasMany(Disciplina, { foreignKey: { name: 'idCurso', field: 'idcurso' }, as: 'cursodisciplina', onDelete: 'CASCADE', onUpdate: 'CASCADE' })
Disciplina.belongsTo(Curso, { targetKey: 'id', foreignKey: { name: 'idCurso', field: 'idcurso' }, as: 'disciplinacurso', onDelete: 'CASCADE', onUpdate: 'CASCADE' })

// Disciplina <-> Turma
Disciplina.hasMany(Turma, { foreignKey: { name: 'idDisciplina', field: 'iddisciplina' }, as: 'disciplinaturma', onDelete: 'CASCADE', onUpdate: 'CASCADE' })
Turma.belongsTo(Disciplina, { targetKey: 'id', foreignKey: { name: 'idDisciplina', field: 'iddisciplina' }, as: 'turmadisciplina', onDelete: 'CASCADE', onUpdate: 'CASCADE' })

// Disciplina <-> Requisito (Base)
Disciplina.hasMany(Requisito, { foreignKey: { name: 'idDisciplina', field: 'iddisciplina' }, as: 'disciplinabaserequisito', onDelete: 'CASCADE', onUpdate: 'CASCADE' })
Requisito.belongsTo(Disciplina, { targetKey: 'id', foreignKey: { name: 'idDisciplina', field: 'iddisciplina' }, as: 'requisitodisciplinabase', onDelete: 'CASCADE', onUpdate: 'CASCADE' })

// Disciplina <-> Requisito (Disciplina Requisito)
Disciplina.hasMany(Requisito, { foreignKey: { name: 'idDisciplinaRequisito', field: 'iddisciplinarequisito' }, as: 'disciplinarequisito', onDelete: 'CASCADE', onUpdate: 'CASCADE' })
Requisito.belongsTo(Disciplina, { targetKey: 'id', foreignKey: { name: 'idDisciplinaRequisito', field: 'iddisciplinarequisito' }, as: 'requisitodisciplina', onDelete: 'CASCADE', onUpdate: 'CASCADE' })

// Horario <-> Turma
Horario.belongsTo(Turma, { targetKey: 'id', foreignKey: { name: 'idTurma', field: 'idturma' }, as: 'horarioturma', onDelete: 'CASCADE', onUpdate: 'CASCADE' })
Turma.hasMany(Horario, { foreignKey: { name: 'idTurma', field: 'idturma' }, as: 'turmahorario', onDelete: 'CASCADE', onUpdate: 'CASCADE' })

// Inscricao <-> Turma
Inscricao.belongsTo(Turma, { targetKey: 'id', foreignKey: { name: 'idTurma', field: 'idturma' }, as: 'inscricaoturma', onDelete: 'CASCADE', onUpdate: 'CASCADE' })
Turma.hasMany(Inscricao, { foreignKey: { name: 'idTurma', field: 'idturma' }, as: 'turmainscricao', onDelete: 'CASCADE', onUpdate: 'CASCADE' })

// Presenca <-> Professor
Presenca.belongsTo(Professor, { targetKey: 'id', foreignKey: { name: 'idProfessor', field: 'idprofessor' }, as: 'presencaprofessor', onDelete: 'CASCADE', onUpdate: 'CASCADE' })
Professor.hasOne(Presenca, { foreignKey: { name: 'idProfessor', field: 'idprofessor' }, as: 'professorpresenca', onDelete: 'CASCADE', onUpdate: 'CASCADE' })

// Professsor <-> Turma
Professor.hasMany(Turma, { foreignKey: { name: 'idProfessor', field: 'idprofessor' }, as: 'professorturma', onDelete: 'CASCADE', onUpdate: 'CASCADE' })
Turma.belongsTo(Professor, { targetKey: 'id', foreignKey: { name: 'idProfessor', field: 'idprofessor' }, as: 'turmaprofessor', onDelete: 'CASCADE', onUpdate: 'CASCADE' })

// Aluno <-> Anotacao
Aluno.hasMany(Anotacao, { foreignKey: { name: 'idAluno', field: 'idaluno' }, as: 'alunoanotacao', onDelete: 'CASCADE', onUpdate: 'CASCADE' })
Anotacao.belongsTo(Aluno, { targetKey: 'id', foreignKey: { name: 'idAluno', field: 'idaluno' }, as: 'anotacaoaluno', onDelete: 'CASCADE', onUpdate: 'CASCADE' })

// Disciplina <-> Anotacao
Disciplina.hasMany(Anotacao, { foreignKey: { name: 'idDisciplina', field: 'iddisciplina' }, as: 'disciplinaanotacao', onDelete: 'CASCADE', onUpdate: 'CASCADE' })
Anotacao.belongsTo(Disciplina, { targetKey: 'id', foreignKey: { name: 'idDisciplina', field: 'iddisciplina' }, as: 'anotacaodisciplina', onDelete: 'CASCADE', onUpdate: 'CASCADE' })

// Aluno <-> Inscrição
Aluno.hasMany(Progresso, { foreignKey: { name: 'idAluno', field: 'idaluno' }, as: 'alunoprogresso', onDelete: 'CASCADE', onUpdate: 'CASCADE' })
Progresso.belongsTo(Aluno, { targetKey: 'id', foreignKey: { name: 'idAluno', field: 'idaluno' }, as: 'progressoaluno', onDelete: 'CASCADE', onUpdate: 'CASCADE' })

// Inscricao <-> Turma
Progresso.belongsTo(Disciplina, { targetKey: 'id', foreignKey: { name: 'idDisciplina', field: 'iddisciplina' }, as: 'progressodisciplina', onDelete: 'CASCADE', onUpdate: 'CASCADE' })
Disciplina.hasMany(Progresso, { foreignKey: { name: 'idDisciplina', field: 'iddisciplina' }, as: 'disciplinaprogresso', onDelete: 'CASCADE', onUpdate: 'CASCADE' })

console.log('Relações definidas')
