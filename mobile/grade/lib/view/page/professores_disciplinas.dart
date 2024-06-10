import 'package:flutter/material.dart';
import 'package:grade/controller/disciplina_controller.dart';
import 'package:grade/model/disciplina.dart';
import 'package:grade/view/component/carregando.dart';
import 'package:grade/view/component/container_base.dart';
import 'package:grade/view/component/my_simple_tile.dart';
import 'package:grade/view/page/professores.dart';

class ProfessoresDisciplinasPage extends StatefulWidget {
  static const rota = '${ProfessoresPage.rota}/disciplinas';
  final int idProfessor;

  const ProfessoresDisciplinasPage({super.key, required this.idProfessor});

  @override
  State<ProfessoresDisciplinasPage> createState() {
    return ProfessoresDisciplinasPageState();
  }
}

class ProfessoresDisciplinasPageState
    extends State<ProfessoresDisciplinasPage> {
  final _disciplinaController = DisciplinaController();
  List<Disciplina> _disciplinas = [];
  bool _carregando = true;
  @override
  void initState() {
    super.initState();
    _listarDisciplinas();
  }

  void _listarDisciplinas() async {
    setState(() {
      _carregando = true;
    });
    var temp = await _disciplinaController
        .listarDisciplinasProfessor(widget.idProfessor);
    setState(() {
      _disciplinas = temp;
      _carregando = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Disciplinas Ministradas'),
      ),
      body: _carregando
          ? const Carregando()
          : ContainerBase(
              child: ListView.separated(
                  separatorBuilder: (context, index) => const SizedBox(
                        height: 5.0,
                      ),
                  itemCount: _disciplinas.length,
                  itemBuilder: (context, index) => MySimpleTile(
                        title: Text(_disciplinas[index].nome!),
                        subtitle:
                            Text('${_disciplinas[index].periodo}° período'),
                      ))),
    );
  }
}
