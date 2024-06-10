import 'package:flutter/material.dart';
import 'package:grade/controller/global_controller.dart';
import 'package:grade/controller/horario_controller.dart';
import 'package:grade/model/horario.dart';
import 'package:grade/view/component/carregando.dart';

class TabelaGrade extends StatefulWidget {
  final bool visualizacaoSemanal;

  const TabelaGrade({super.key, required this.visualizacaoSemanal});

  @override
  State<TabelaGrade> createState() {
    return TabelaGradeState();
  }
}

class TabelaGradeState extends State<TabelaGrade> {
  final _controller = HorarioController();
  final _currentDay = DateTime.now();
  final _diasSemana = [
    'Segunda-feira',
    'Terça-feira',
    'Quarta-feira',
    'Quinta-feira',
    'Sexta-feira'
  ];

  List<Horario> _horarios = [];
  List<DataRow> _linhas = [];
  List<String> _diasVisualizacao = ['Fim de semana'];

  bool _carregando = true;

  @override
  void initState() {
    super.initState();

    _defineDiasVisualizacao();
    _buscaHorariosInscritos();
  }

  void _defineDiasVisualizacao() {
    if (widget.visualizacaoSemanal) {
      setState(() {
        _diasVisualizacao = _diasSemana;
      });
    } else {
      if (_currentDay.weekday <= 5) {
        setState(() {
          _diasVisualizacao = [_diasSemana[_currentDay.weekday - 1]];
        });
      }
    }
  }

  Future<void> _buscaHorariosInscritos() async {
    setState(() {
      _carregando = true;
    });
    var resposta = await _controller
        .buscaHorariosInscritos(GlobalController.instance.aluno!.id!);
    if (widget.visualizacaoSemanal) {
      setState(() {
        _horarios = resposta;
      });
    } else {
      setState(() {
        _horarios = resposta
            .where((horario) => horario.diaSemana == _currentDay.weekday - 1)
            .toList();
      });
    }
    if (resposta.isEmpty) {
      setState(() {
        _carregando = false;
      });
    } else {
      _montaGradeTabela();
    }
  }

  bool verificaHorarioAtual(String periodo) {
    var periodoSplit = periodo.split(' - ');
    var inicioSplit = periodoSplit[0].split(':');
    var fimSplit = periodoSplit[1].split(':');
    var verificacaoHorarioInicio =
        (int.parse(inicioSplit[0]) + (int.parse(inicioSplit[1]) / 60)) <=
            (_currentDay.hour + (_currentDay.minute / 60));

    var verificacaoHorarioFim =
        (int.parse(fimSplit[0]) + (int.parse(fimSplit[1]) / 60)) >=
            (_currentDay.hour + (_currentDay.minute / 60));
    return verificacaoHorarioInicio && verificacaoHorarioFim;
  }

  void _montaGradeTabela() {
    List<String> periodos = [
      '18:00 - 18:50',
      '18:50 - 19:40',
      '19:40 - 20:30',
      '20:40 - 21:30',
      '21:30 - 22:20'
    ];
    List<DataRow> grade = [];

    for (var i = 0; i < 5; i++) {
      List<DataCell> turmas = [];
      DataCell cellHorario = DataCell(Text(periodos[i]));
      int inicioLoop = widget.visualizacaoSemanal ? 0 : _currentDay.weekday - 1;
      int limiteLoop = widget.visualizacaoSemanal ? 5 : _currentDay.weekday;

      for (var j = inicioLoop; j < limiteLoop; j++) {
        DataCell cellTurma = DataCell.empty;
        var horarioQuery = _horarios
            .where((horario) => horario.diaSemana == j && horario.ordem == i);
        if (horarioQuery.isNotEmpty) {
          var horario = horarioQuery.first;
          var valorCelula =
              '${horario.turma.disciplina!.nome}\n${horario.sala}';
          Color bgColor = Colors.transparent;
          if (j == _currentDay.weekday - 1) {
            if (verificaHorarioAtual(periodos[i])) {
              bgColor = Colors.greenAccent;
            }
          }
          cellTurma = DataCell(Text(
            valorCelula,
            style: TextStyle(backgroundColor: bgColor),
          ));
        }
        turmas.add(cellTurma);
      }
      grade.add(DataRow(cells: [cellHorario, ...turmas]));
    }

    setState(() {
      _linhas = grade;
      _carregando = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return _carregando
        ? const Carregando()
        : _horarios.isEmpty
            ? const Center(
                child: Text('Sem Horários Inscritos'),
              )
            : DataTable(
                columns: ['Horário', ..._diasVisualizacao]
                    .map(
                        (tituloColuna) => DataColumn(label: Text(tituloColuna)))
                    .toList(),
                rows: _linhas);
  }
}
