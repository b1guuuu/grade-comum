const anotacaoComDisciplina = (anotacao) => {
  const { anotacaodisciplina, ...anotacaoJSON } = anotacao.toJSON()
  return {
    ...anotacaoJSON,
    disciplina: anotacaodisciplina
  }
}

const horarioComTurmaEDisciplina = (horario) => {
  const { horarioturma, ...horarioJSON } = horario.toJSON()
  return {
    ...horarioJSON, turma: turmaComDisciplina(horarioturma)
  }
}

const turmaComDisciplina = (turma) => {
  let turmaJSON
  try {
    turmaJSON = turma.toJSON()
  } catch (error) {
    turmaJSON = turma
  }
  return {
    id: turmaJSON.id,
    codigo: turmaJSON.codigo,
    numero: turmaJSON.numero,
    idDisciplina: turmaJSON.idDisciplina,
    idProfessor: turmaJSON.idProfessor,
    disciplina: turmaJSON.turmadisciplina
  }
}

const turmaComDisciplinaEProfessor = (turma) => {
  return {
    ...turmaComDisciplina(turma),
    professor: turma.toJSON().turmaprofessor
  }
}

const turmaComDisciplinaProfessorEInscricao = (turma) => {
  return {
    ...turmaComDisciplinaEProfessor(turma),
    inscricao: turma.toJSON().turmainscricao
  }
}

module.exports = {
  anotacaoComDisciplina,
  horarioComTurmaEDisciplina,
  turmaComDisciplina,
  turmaComDisciplinaEProfessor,
  turmaComDisciplinaProfessorEInscricao
}
