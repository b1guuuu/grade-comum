import 'package:flutter/material.dart';
import 'package:grade/controller/global_controller.dart';
import 'package:grade/controller/horario_controller.dart';
import 'package:grade/model/horario.dart';
import 'package:grade/view/component/carregando.dart';
import 'package:grade/view/component/container_base.dart';
import 'package:grade/view/component/navegacao.dart';
import 'package:grade/view/component/tabela_grade.dart';

class InicioPage extends StatefulWidget {
  static const rota = '/inicio';

  const InicioPage({super.key});

  @override
  State<InicioPage> createState() {
    return InicioPageState();
  }
}

class InicioPageState extends State<InicioPage> {
  final _horarioController = HorarioController();
  final _currentDay = DateTime.now();
  final _diasSemana = [
    'Segunda-feira',
    'Terça-feira',
    'Quarta-feira',
    'Quinta-feira',
    'Sexta-feira'
  ];

  List<Horario> _horarios = [];
  List<DataRow> _gradeTabela = [];
  bool _carregando = true;

  @override
  void initState() {
    super.initState();
    _buscaHorariosInscritos();
  }

  Future<void> _buscaHorariosInscritos() async {
    setState(() {
      _carregando = true;
    });
    var resposta = await _horarioController
        .buscaHorariosInscritos(GlobalController.instance.aluno!.id!);
    setState(() {
      _horarios = resposta.where((horario) => horario.diaSemana == _currentDay.weekday - 1).toList();
    });
    if(_horarios.isEmpty){
      setState(() {
        _carregando = false;
      });
    }else{
    _montaGradeTabela();
    }
  }

  bool verificaHorarioAtual(String periodo) {
    var periodoSplit = periodo.split(' - ');
    var inicioSplit = periodoSplit[0].split(':');
    var fimSplit = periodoSplit[1].split(':');
    var verificacaoHorarioInicio =
        (int.parse(inicioSplit[0]) <= _currentDay.hour) &&
            (int.parse(inicioSplit[1]) <= _currentDay.minute);

    verificacaoHorarioInicio = (int.parse(inicioSplit[0]) + (int.parse(inicioSplit[1])/60)) <= (_currentDay.hour + (_currentDay.minute/60));

    var verificacaoHorarioFim = (int.parse(fimSplit[0]) + (int.parse(fimSplit[1])/60)) >= (_currentDay.hour + (_currentDay.minute/60));
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
      DataCell cellHorario = DataCell(Text(periodos[i]));
      DataCell cellTurma = DataCell.empty;
      var horarioQuery = _horarios.where((horario) => horario.ordem == i);
      if (horarioQuery.isNotEmpty) {
        var horario = horarioQuery.first;
        var valorCelula = '${horario.turma.disciplina!.nome}\n${horario.sala}';
        Color bgColor = Colors.white;
        if (verificaHorarioAtual(periodos[i])) {
          bgColor = Colors.greenAccent;
        }
        cellTurma = DataCell(Text(
          valorCelula,
          style: TextStyle(backgroundColor: bgColor),
        ));
      }
      grade.add(DataRow(cells: [cellHorario, cellTurma]));
    }

    setState(() {
      _gradeTabela = grade;
      _carregando = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Inicio'),
        ),
        drawer: const Drawer(
          child: Navegacao(),
        ),
        body: ContainerBase(
          child: _carregando
              ? const Carregando()
              : _horarios.isEmpty ? const Center(child: Text('Não há turmas para o dia de hoje'),) : InteractiveViewer(
                  constrained: false,
                  child: DataTable(
                      columns: ['Horário', _diasSemana[0]]
                          .map((tituloColuna) =>
                              DataColumn(label: Text(tituloColuna)))
                          .toList(),
                      rows: _gradeTabela),
                ),
        ));
  }
}
