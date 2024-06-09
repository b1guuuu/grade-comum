import 'package:accordion/accordion.dart';
import 'package:accordion/controllers.dart';
import 'package:flutter/material.dart';
import 'package:grade/controller/disciplina_controller.dart';
import 'package:grade/controller/global_controller.dart';
import 'package:grade/controller/progresso_controller.dart';
import 'package:grade/model/disciplina.dart';
import 'package:grade/model/progresso.dart';
import 'package:grade/view/component/carregando.dart';
import 'package:grade/view/component/container_base.dart';
import 'package:grade/view/component/formulario_disciplinas_cursadas.dart';
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
  final _progressoController = ProgressoController();
  List<Disciplina> _disciplinas = [];
  List<Progresso> _progressos = [];
  late bool _carregando = true;

  @override
  void initState() {
    super.initState();
    _buscarDados();
  }

  Future<void> _buscarDados() async {
    setState(() {
      _carregando = true;
    });

    var disciplinas = await _disciplaController
        .listarPPC(GlobalController.instance.aluno!.idCurso!);
    var progressos = await _progressoController
        .listarPorAluno(GlobalController.instance.aluno!.id!);

    setState(() {
      _disciplinas = disciplinas;
      _progressos = progressos;
      _carregando = false;
    });
  }

  Future<void> _apresentarModal(BuildContext context) async {
    return showDialog(
      context: context,
      builder: (context) {
        return FormularioDisciplinasCursadas(
          disciplinas: _disciplinas,
          progressos: _progressos,
        );
      },
    );
  }

  Color _defineCorHeader(Disciplina disciplina) {
    return _progressos.any((progresso) =>
            progresso.concluido && progresso.idDisciplina == disciplina.id)
        ? Colors.green
        : Colors.blueAccent;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Disciplinas'),
        actions: [
          IconButton(
              onPressed: () => _apresentarModal(context).then(
                    (value) => _buscarDados(),
                  ),
              icon: const Icon(Icons.edit))
        ],
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
              contentBorderColor: Colors.greenAccent,
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
                        headerBackgroundColor: _defineCorHeader(disciplina),
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
