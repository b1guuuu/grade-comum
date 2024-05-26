import 'package:flutter/material.dart';
import 'package:grade/controller/turma_controller.dart';
import 'package:grade/model/turma.dart';
import 'package:grade/view/admin/admin_inicio.dart';
import 'package:grade/view/component/admin_formulario_turma.dart';
import 'package:grade/view/component/admin_navegacao.dart';
import 'package:grade/view/component/carregando.dart';
import 'package:grade/view/component/container_base.dart';
import 'package:quickalert/models/quickalert_type.dart';
import 'package:quickalert/widgets/quickalert_dialog.dart';

class AdminTurmasPage extends StatefulWidget {
  static const rota = '${AdminInicioPage.rota}/turmas';

  const AdminTurmasPage({super.key});

  @override
  State<AdminTurmasPage> createState() {
    return AdminTurmasPageState();
  }
}

class AdminTurmasPageState extends State<AdminTurmasPage> {
  final _turmaController = TurmaController();
  final _filtroTxtController = TextEditingController();
  List<Turma> _turmas = [];
  List<Turma> _turmasFiltrados = [];
  bool _carregando = true;
  bool _habilitarFiltro = false;

  @override
  void initState() {
    super.initState();
    _buscarTurmas();
  }

  void _alternarVisualizacaoFiltro() {
    if (_habilitarFiltro) {
      setState(() {
        _turmasFiltrados = _turmas;
      });
    }
    setState(() {
      _habilitarFiltro = !_habilitarFiltro;
      _filtroTxtController.clear();
    });
  }

  void _filtrarTurmaes(filtro) {
    var temp = _turmas
        .where((turma) => turma.disciplina!.nome!
            .toUpperCase()
            .contains(_filtroTxtController.text.toUpperCase()))
        .toList();
    setState(() {
      _turmasFiltrados = temp;
    });
  }

  Future<void> _buscarTurmas() async {
    setState(() {
      _carregando = true;
    });
    var turmas = await _turmaController.buscaTodas();
    setState(() {
      _turmas = turmas;
      _turmasFiltrados = turmas;
      _carregando = false;
    });
  }

  Future<void> _abrirFormulario(BuildContext context, Turma? turma) async {
    return showDialog(
        context: context, builder: (context) => const AdminFormularioTurma());
  }

  Future<void> _deletarTurma(Turma turma, BuildContext context) async {
    return QuickAlert.show(
      context: context,
      type: QuickAlertType.confirm,
      cancelBtnText: 'Voltar',
      confirmBtnText: 'Deletar',
      confirmBtnColor: Color(Colors.red.value),
      onCancelBtnTap: () => Navigator.pop(context),
      onConfirmBtnTap: () async {
        try {
          await _turmaController.deletar(turma);
          Navigator.pop(context);
          _buscarTurmas();
        } catch (e) {
          QuickAlert.show(
            context: context,
            type: QuickAlertType.error,
            confirmBtnText: 'Fechar',
            text: e.toString(),
            title: 'Erro ao deletar turma',
          );
        }
      },
      text: 'Deseja deletar a turma "${turma.codigo}"?',
      title: 'Confirmação',
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: _habilitarFiltro
            ? TextFormField(
                decoration: const InputDecoration(
                    hintText: 'Nome', label: Text('Nome disciplina')),
                controller: _filtroTxtController,
                onFieldSubmitted: _filtrarTurmaes,
              )
            : const Text('Admin: Turmas'),
        actions: [
          IconButton(
              onPressed: _alternarVisualizacaoFiltro,
              icon: _habilitarFiltro
                  ? const Icon(Icons.cancel)
                  : const Icon(Icons.search))
        ],
      ),
      drawer: const Drawer(
        child: AdminNavegacao(),
      ),
      body: ContainerBase(
        child: _carregando
            ? const Carregando()
            : ListView.builder(
                itemCount: _turmasFiltrados.length,
                itemBuilder: (context, index) => ListTile(
                  title: Text(_turmasFiltrados[index].disciplina!.nome!),
                  subtitle: Text(
                      'Código: ${_turmasFiltrados[index].codigo}\nProfessor(a): ${_turmasFiltrados[index].professor!.nome}'),
                  enableFeedback: true,
                  trailing: IconButton(
                      onPressed: () =>
                          _deletarTurma(_turmasFiltrados[index], context),
                      icon: const Icon(Icons.delete)),
                ),
              ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _abrirFormulario(context, null).then((value) => _buscarTurmas());
        },
        enableFeedback: true,
        child: const Icon(Icons.add_circle),
      ),
    );
  }
}
