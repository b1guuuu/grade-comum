import 'package:accordion/accordion.dart';
import 'package:accordion/controllers.dart';
import 'package:flutter/material.dart';
import 'package:grade/controller/global_controller.dart';
import 'package:grade/controller/horario_controller.dart';
import 'package:grade/model/horario.dart';
import 'package:grade/view/component/carregando.dart';
import 'package:grade/view/component/container_base.dart';
import 'package:grade/view/component/my_container.dart';
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
        .buscaHorariosInscritos(GlobalController.instance.aluno!.id!);
    setState(() {
      _horarios = resposta;
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
    var screenWidth = MediaQuery.of(context).size.width;
    var screenHeight = MediaQuery.of(context).size.height;
    var mainContainerHeight = screenHeight > 320 ? 320.0 : screenHeight * 0.9;
    var mainContainerWidth = screenWidth > 1050 ? 1050.0 : screenWidth * 0.9;

    var contentContainerWidth = mainContainerWidth * 0.9;
    var contentContainerHeight = mainContainerHeight * 0.9;
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
        body: ContainerBase(
          child: _carregando
              ? const Carregando()
              : _horarios.isEmpty
                  ? const Center(
                      child: Text('Sem Horários Inscritos'),
                    )
                  : _visualizacaoTabela
                      ? Center(
                          child: MyContainer(
                            mainContainerHeight: mainContainerHeight,
                            mainContainerWidth: mainContainerWidth,
                            contentContainerWidth: contentContainerWidth,
                            contentContainerHeight: contentContainerHeight,
                            child: const TabelaGrade(visualizacaoSemanal: true),
                          ),
                        )
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
                          sectionOpeningHapticFeedback:
                              SectionHapticFeedback.heavy,
                          sectionClosingHapticFeedback:
                              SectionHapticFeedback.light,
                          children: _gradeAccordion
                              .map((horarios) => AccordionSection(
                                    isOpen: true,
                                    contentVerticalPadding: 20,
                                    header: Text(
                                        _diasSemana[horarios.first.diaSemana]),
                                    content: Column(
                                      children: horarios
                                          .map((horario) => Text(
                                              '${horario.inicio} - ${horario.fim} ${horario.turma.disciplina!.nome} (${horario.sala})'))
                                          .toList(),
                                    ),
                                  ))
                              .toList(),
                        ),
        ));
  }
}
