import 'package:flutter/material.dart';
import 'package:grade/controller/curso_controller.dart';
import 'package:grade/model/curso.dart';
import 'package:grade/view/admin/admin_inicio.dart';
import 'package:grade/view/component/admin_formulario_curso.dart';
import 'package:grade/view/component/carregando.dart';
import 'package:grade/view/component/container_base.dart';
import 'package:grade/view/component/admin_navegacao.dart';

class AdminCursosPage extends StatefulWidget {
  static const rota = '${AdminInicioPage.rota}/cursos';

  const AdminCursosPage({super.key});

  @override
  State<AdminCursosPage> createState() {
    return AdminCursosPageState();
  }
}

class AdminCursosPageState extends State<AdminCursosPage> {
  final _cursoController = CursoController();
  List<Curso> _cursos = [];
  bool _carregando = true;

  @override
  void initState() {
    super.initState();
    _buscarCursos();
  }

  Future<void> _buscarCursos() async {
    setState(() {
      _carregando = true;
    });
    var cursos = await _cursoController.listar();
    setState(() {
      _cursos = cursos;
      _carregando = false;
    });
  }

  Future<void> _abrirFormulario(BuildContext context, Curso? curso) async {
    return showDialog(
        context: context,
        builder: (context) => AdminFormularioCurso(
              curso: curso,
            ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Administrador: Cursos'),
      ),
      drawer: const Drawer(
        child: AdminNavegacao(),
      ),
      body: _carregando
          ? const Carregando()
          : ContainerBase(
              child: ListView.builder(
              itemCount: _cursos.length,
              itemBuilder: (context, index) => ListTile(
                enableFeedback: true,
                onTap: () => _abrirFormulario(context, _cursos[index])
                    .then((value) => _buscarCursos()),
                title: Text(
                  _cursos[index].nome!,
                  maxLines: 3,
                  softWrap: true,
                ),
              ),
            )),
      floatingActionButton: FloatingActionButton(
          enableFeedback: true,
          child: const Icon(Icons.add_circle),
          onPressed: () =>
              _abrirFormulario(context, null).then((value) => _buscarCursos())),
    );
  }
}
