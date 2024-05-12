import 'package:accordion/accordion.dart';
import 'package:accordion/controllers.dart';
import 'package:flutter/material.dart';
import 'package:grade/controller/disciplina_controller.dart';
import 'package:grade/controller/global_controller.dart';
import 'package:grade/model/disciplina.dart';
import 'package:grade/view/component/carregando.dart';
import 'package:grade/view/component/container_base.dart';
import 'package:grade/view/component/navegacao.dart';

class PPCPage extends StatefulWidget {
  static const rota = '/disciplinas';
  const PPCPage({super.key});

  @override
  State<PPCPage> createState() {
    return PPCPageState();
  }
}

class PPCPageState extends State<PPCPage> {
  final _disciplaController = DisciplinaController();
  List<Disciplina> _disciplinas = [];
  late bool _carregando = true;

  @override
  void initState() {
    super.initState();
    _buscarDisciplinas();
  }

  Future<void> _buscarDisciplinas() async {
    setState(() {
      _carregando = true;
    });

    var temp = await _disciplaController
        .listarPPC(GlobalController.instance.aluno!.idCurso!);

    setState(() {
      _disciplinas = temp;
      _carregando = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Disciplinas'),
      ),
      drawer: const Drawer(
        child: Navegacao(),
      ),
      body: _carregando
          ? const Carregando()
          : ContainerBase(
              child: Accordion(
              maxOpenSections: _disciplinas.length,
              headerBorderColor: Colors.blueGrey,
              headerBorderColorOpened: Colors.transparent,
              headerBackgroundColor: Colors.blueAccent,
              // headerBorderWidth: 1,
              headerBackgroundColorOpened: Colors.green,
              contentBackgroundColor: Colors.white,
              contentBorderColor: Colors.green,
              contentBorderWidth: 3,
              contentHorizontalPadding: 20,
              scaleWhenAnimating: true,
              openAndCloseAnimation: true,
              headerPadding:
                  const EdgeInsets.symmetric(vertical: 7, horizontal: 15),
              sectionOpeningHapticFeedback: SectionHapticFeedback.heavy,
              sectionClosingHapticFeedback: SectionHapticFeedback.light,
              children: _disciplinas
                  .map((disciplina) => AccordionSection(
                        contentVerticalPadding: 20,
                        header: Text(disciplina.nome!),
                        content: Column(
                          children: [
                            Text('Período: ${disciplina.periodo}'),
                            Text(disciplina.requisitos!.isNotEmpty
                                ? 'Requisitos:'
                                : ''),
                            ...disciplina.requisitos!
                                .map((requisito) => Text(requisito.nome!))
                          ],
                        ),
                      ))
                  .toList(),
            )),
    );
  }
}
