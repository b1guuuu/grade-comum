import 'package:accordion/accordion.dart';
import 'package:accordion/controllers.dart';
import 'package:flutter/material.dart';
import 'package:grade/controller/global_controller.dart';
import 'package:grade/controller/horario_controller.dart';
import 'package:grade/model/horario.dart';
import 'package:grade/view/component/carregando.dart';
import 'package:grade/view/component/navegacao.dart';
import 'package:grade/view/component/tabela_grade.dart';

class GradePage extends StatefulWidget {
  static const rota = '/grade';

  const GradePage({super.key});

  @override
  State<GradePage> createState() {
    return GradePageState();
  }
}

class GradePageState extends State<GradePage> {
  final HorarioController _controller = HorarioController();
  late List<Horario> _horarios = [];
  late List<List<String>> _gradeTabela;
  late List<List<Horario>> _gradeAccordion = [];
  late bool _carregando = true;
  late bool _visualizacaoTabela = true;
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
    _buscaHorariosInscritos();
  }

  Future<void> _buscaHorariosInscritos() async {
    setState(() {
      _carregando = true;
    });
    var resposta = await _controller
        .buscaHorariosInscritos(GlobalController.instance.aluno!.id);
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
          var valorCelula = '${horario.turma.disciplina.nome}\n${horario.sala}';
          linha.add(valorCelula);
        }
      }
      grade.add(linha);
    }

    setState(() {
      _gradeTabela = grade;
    });

    _montaGradeAccordion();
  }

  void _montaGradeAccordion() {
    late List<List<Horario>> tempGrade = [];
    for (var i = 0; i < _diasSemana.length; i++) {
      List<Horario> horariosDia =
          _horarios.where((horario) => horario.diaSemana == i).toList();
      horariosDia.sort(
          (horario1, horario2) => horario1.ordem.compareTo(horario2.ordem));
      if (horariosDia.isNotEmpty) {
        tempGrade.add(horariosDia);
      }
    }
    setState(() {
      _gradeAccordion = tempGrade;
      _carregando = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Grade'),
          actions: [
            IconButton(
                onPressed: () => {
                      setState(() {
                        _visualizacaoTabela = !_visualizacaoTabela;
                      })
                    },
                icon: Icon(_visualizacaoTabela
                    ? Icons.view_agenda
                    : Icons.table_chart))
          ],
        ),
        drawer: const Drawer(
          child: Navegacao(),
        ),
        body: Container(
          color: const Color.fromARGB(255, 208, 208, 208),
          padding: const EdgeInsets.all(5.0),
          child: _carregando
              ? const Carregando()
              : _visualizacaoTabela
                  ? TabelaGrade(grade: _gradeTabela, dias: _diasSemana)
                  : Accordion(
                      maxOpenSections: 5,
                      headerBorderColor: Colors.blueGrey,
                      headerBorderColorOpened: Colors.transparent,
                      // headerBorderWidth: 1,
                      headerBackgroundColorOpened: Colors.green,
                      contentBackgroundColor: Colors.white,
                      contentBorderColor: Colors.green,
                      contentBorderWidth: 3,
                      contentHorizontalPadding: 20,
                      scaleWhenAnimating: true,
                      openAndCloseAnimation: true,
                      headerPadding: const EdgeInsets.symmetric(
                          vertical: 7, horizontal: 15),
                      sectionOpeningHapticFeedback: SectionHapticFeedback.heavy,
                      sectionClosingHapticFeedback: SectionHapticFeedback.light,
                      children: _gradeAccordion
                          .map((horarios) => AccordionSection(
                                isOpen: true,
                                contentVerticalPadding: 20,
                                header:
                                    Text(_diasSemana[horarios.first.diaSemana]),
                                content: Column(
                                  children: horarios
                                      .map((horario) => Text(
                                          '${horario.inicio} - ${horario.fim} ${horario.turma.disciplina.nome} (${horario.sala})'))
                                      .toList(),
                                ),
                              ))
                          .toList(),
                    ),
        ));
  }
}
