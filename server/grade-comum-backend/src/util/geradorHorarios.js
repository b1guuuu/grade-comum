const periodos = [
  { inicio: '18:00', fim: '18:50' },
  { inicio: '18:50', fim: '19:40' },
  { inicio: '19:40', fim: '20:30' },
  { inicio: '20:40', fim: '21:30' },
  { inicio: '21:30', fim: '22:20' }
]

module.exports.geradorHorarios = (numDisciplina = 0, idTurma = 0) => {
  let horarios = []
  switch (numDisciplina) {
    case 1:
      horarios = [
        { diaSemana: 0, inicio: periodos[0].inicio, fim: periodos[0].fim, sala: 'N/A', ordem: 0, idTurma },
        { diaSemana: 0, inicio: periodos[1].inicio, fim: periodos[1].fim, sala: 'N/A', ordem: 1, idTurma },
        { diaSemana: 0, inicio: periodos[2].inicio, fim: periodos[2].fim, sala: 'N/A', ordem: 2, idTurma },
        { diaSemana: 1, inicio: periodos[2].inicio, fim: periodos[2].fim, sala: 'N/A', ordem: 2, idTurma }
      ]
      break
    case 2:
      horarios = [
        { diaSemana: 0, inicio: periodos[3].inicio, fim: periodos[3].fim, sala: 'N/A', ordem: 3, idTurma },
        { diaSemana: 0, inicio: periodos[4].inicio, fim: periodos[4].fim, sala: 'N/A', ordem: 4, idTurma },
        { diaSemana: 1, inicio: periodos[0].inicio, fim: periodos[0].fim, sala: 'N/A', ordem: 0, idTurma },
        { diaSemana: 1, inicio: periodos[1].inicio, fim: periodos[1].fim, sala: 'N/A', ordem: 1, idTurma }
      ]
      break
    case 3:
      horarios = [
        { diaSemana: 1, inicio: periodos[3].inicio, fim: periodos[3].fim, sala: 'N/A', ordem: 3, idTurma },
        { diaSemana: 1, inicio: periodos[4].inicio, fim: periodos[4].fim, sala: 'N/A', ordem: 4, idTurma },
        { diaSemana: 2, inicio: periodos[3].inicio, fim: periodos[3].fim, sala: 'N/A', ordem: 3, idTurma },
        { diaSemana: 2, inicio: periodos[4].inicio, fim: periodos[4].fim, sala: 'N/A', ordem: 4, idTurma }
      ]
      break
    case 4:
      horarios = [
        { diaSemana: 2, inicio: periodos[0].inicio, fim: periodos[0].fim, sala: 'N/A', ordem: 0, idTurma },
        { diaSemana: 2, inicio: periodos[1].inicio, fim: periodos[1].fim, sala: 'N/A', ordem: 1, idTurma },
        { diaSemana: 2, inicio: periodos[2].inicio, fim: periodos[2].fim, sala: 'N/A', ordem: 2, idTurma },
        { diaSemana: 3, inicio: periodos[2].inicio, fim: periodos[2].fim, sala: 'N/A', ordem: 2, idTurma }
      ]
      break
    case 5:
      horarios = [
        { diaSemana: 3, inicio: periodos[0].inicio, fim: periodos[0].fim, sala: 'N/A', ordem: 0, idTurma },
        { diaSemana: 3, inicio: periodos[1].inicio, fim: periodos[1].fim, sala: 'N/A', ordem: 1, idTurma },
        { diaSemana: 4, inicio: periodos[2].inicio, fim: periodos[2].fim, sala: 'N/A', ordem: 2, idTurma },
        { diaSemana: 4, inicio: periodos[3].inicio, fim: periodos[3].fim, sala: 'N/A', ordem: 3, idTurma }
      ]
      break
    case 6:
      horarios = [
        { diaSemana: 3, inicio: periodos[3].inicio, fim: periodos[3].fim, sala: 'N/A', ordem: 3, idTurma },
        { diaSemana: 3, inicio: periodos[4].inicio, fim: periodos[4].fim, sala: 'N/A', ordem: 4, idTurma },
        { diaSemana: 4, inicio: periodos[0].inicio, fim: periodos[0].fim, sala: 'N/A', ordem: 0, idTurma },
        { diaSemana: 4, inicio: periodos[1].inicio, fim: periodos[1].fim, sala: 'N/A', ordem: 1, idTurma }
      ]
      break

    default:
      break
  }

  return horarios
}
