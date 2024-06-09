import 'package:flutter/material.dart';
import 'package:grade/controller/horario_controller.dart';
import 'package:grade/model/horario.dart';
import 'package:grade/view/component/carregando.dart';
import 'package:grade/view/component/container_base.dart';
import 'package:grade/view/component/tabela_grade.dart';
import 'package:grade/view/page/grade.dart';

class ProfessoresGradePage extends StatefulWidget {
  static const rota = '${GradePage.rota}/professor';
  final int idProfessor;

  const ProfessoresGradePage({super.key, required this.idProfessor});

  @override
  State<ProfessoresGradePage> createState() {
    return ProfessoresGradePageState();
  }
}

class ProfessoresGradePageState extends State<ProfessoresGradePage> {
  final HorarioController _controller = HorarioController();
  final _diasSemana = [
    'Segunda-feira',
    'Terça-feira',
    'Quarta-feira',
    'Quinta-feira',
    'Sexta-feira'
  ];
  List<Horario> _horarios = [];
  List<DataRow> _linhas = [];
  bool _carregando = true;

  @override
  void initState() {
    super.initState();
    _buscaHorarios();
  }

  Future<void> _buscaHorarios() async {
    setState(() {
      _carregando = true;
    });
    var resposta = await _controller.buscaHorariosProfessor(widget.idProfessor);
    setState(() {
      _horarios = resposta;
    });
    _montaGradeTabela();
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
      for (var j = 0; j < 5; j++) {
        DataCell cellTurma = DataCell.empty;
        var horarioQuery = _horarios
            .where((horario) => horario.diaSemana == j && horario.ordem == i);
        if (horarioQuery.isNotEmpty) {
          var horario = horarioQuery.first;
          var valorCelula = horario.sala;
          cellTurma = DataCell(Text(valorCelula));
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
    return Scaffold(
        appBar: AppBar(
          title: const Text('Presença Professor'),
        ),
        body: ContainerBase(
          child: _carregando
              ? const Carregando()
              : _horarios.isNotEmpty
                  ? InteractiveViewer(
                      constrained: false,
                      child: DataTable(
                          columns: ['Horário', ..._diasSemana]
                              .map((tituloColuna) =>
                                  DataColumn(label: Text(tituloColuna)))
                              .toList(),
                          rows: _linhas),
                    )
                  : const Center(
                      child: Text(
                          'Não há horários cadastrados para o docente selecionado'),
                    ),
        ));
  }
}
