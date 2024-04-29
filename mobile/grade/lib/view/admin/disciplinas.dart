import 'package:flutter/material.dart';
import 'package:grade/controller/disciplina_controller.dart';
import 'package:grade/model/disciplina.dart';
import 'package:grade/view/admin/inicio.dart';
import 'package:grade/view/component/carregando.dart';
import 'package:grade/view/component/disciplina_cadastro.dart';
import 'package:grade/view/component/navegacao.dart';

class DisciplinasPage extends StatefulWidget {
  static const rota = '${InicioAdminPage.rota}/disciplinas';

  const DisciplinasPage({super.key});

  @override
  State<DisciplinasPage> createState() {
    return DisciplinasPageState();
  }
}

class DisciplinasPageState extends State<DisciplinasPage> {
  final DisciplinaController _disciplinaController = DisciplinaController();
  List<Disciplina> _disciplinas = [];
  bool _carregando = true;

  @override
  void initState() {
    super.initState();
    _buscarDisciplinas();
  }

  Future<void> _buscarDisciplinas() async {
    setState(() {
      _carregando = true;
    });
    var disciplinas = await _disciplinaController.listar();
    setState(() {
      _disciplinas = disciplinas;
      _carregando = false;
    });
  }

  Future<void> _apresentarModalNovaDisciplina(BuildContext context) async {
    return showDialog(
      context: context,
      builder: (context) {
        return DisciplinaCadastro(
          disciplinas: _disciplinas,
        );
      },
    );
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
      body: Container(
        color: const Color.fromARGB(255, 208, 208, 208),
        padding: const EdgeInsets.all(5.0),
        child: _carregando
            ? const Carregando()
            : ListView.builder(
                itemCount: _disciplinas.length,
                itemBuilder: (context, index) => ListTile(
                  title: Text(_disciplinas[index].nome!),
                  enableFeedback: true,
                ),
              ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _apresentarModalNovaDisciplina(context)
              .then((value) => _buscarDisciplinas());
        },
        enableFeedback: true,
        child: const Icon(Icons.add_circle),
      ),
    );
  }
}
