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
  late List<Horario> _horarios = [];
  late List<List<String>> _gradeTabela;
  late bool _carregando = true;
  final _diasSemana = [
    'Segunda-feira',
    'Terça-feira',
    'Quarta-feira',
    'Quinta-feira',
    'Sexta-feira'
  ];

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
    List<List<String>> grade = [];

    for (var i = 0; i < 5; i++) {
      List<String> linha = [periodos[i]];
      for (var j = 0; j < 5; j++) {
        var horarioQuery = _horarios
            .where((horario) => horario.diaSemana == j && horario.ordem == i);
        if (horarioQuery.isEmpty) {
          linha.add('');
        } else {
          var horario = horarioQuery.first;
          var valorCelula = horario.sala;
          linha.add(valorCelula);
        }
      }
      grade.add(linha);
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
          title: const Text('Presença Professor'),
        ),
        body: ContainerBase(
          child: _carregando
              ? const Carregando()
              : _horarios.isNotEmpty
                  ? TabelaGrade(grade: _gradeTabela, dias: _diasSemana)
                  : const Center(
                      child: Text(
                          'Não há horários cadastrados para o docente selecionado'),
                    ),
        ));
  }
}
