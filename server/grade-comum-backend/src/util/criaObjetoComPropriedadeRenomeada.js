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

const disciplinaComRequisitos = (disciplina) => {
  let disciplinaJSON
  try {
    disciplinaJSON = disciplina.toJSON()
  } catch (error) {
    disciplinaJSON = disciplina
  }

  const { id, nome, periodo, idCurso } = disciplinaJSON
  return {
    id,
    nome,
    periodo,
    idCurso,
    requisitos: disciplinaJSON.disciplinabaserequisito
  }
}

const disciplinaComRequisitosFormatados = (disciplina) => {
  const disciplinaBase = disciplinaComRequisitos(disciplina)
  const requisitos = disciplinaBase.requisitos.map((requisito) => requisito.requisitodisciplina)
  disciplinaBase.requisitos = requisitos
  return disciplinaBase
}

const presencaComProfessor = (presenca) => {
  let presencaJSON
  try {
    presencaJSON = presenca.toJSON()
  } catch (error) {
    presencaJSON = presenca
  }
  return {
    id: presencaJSON.id,
    presente: presencaJSON.presente,
    observacao: presencaJSON.observacao,
    ultimaAtualizacao: presencaJSON.ultimaatualizacao,
    idProfessor: presencaJSON.idProfessor,
    professor: presencaJSON.presencaprofessor
  }
}
const disciplinaComCurso = (disciplina) => {
  const { disciplinacurso, ...atributos } = disciplina.toJSON()
  return { ...atributos, curso: disciplinacurso }
}

module.exports = {
  anotacaoComDisciplina,
  horarioComTurmaEDisciplina,
  turmaComDisciplina,
  turmaComDisciplinaEProfessor,
  turmaComDisciplinaProfessorEInscricao,
  disciplinaComRequisitos,
  disciplinaComRequisitosFormatados,
  presencaComProfessor,
  disciplinaComCurso
}
