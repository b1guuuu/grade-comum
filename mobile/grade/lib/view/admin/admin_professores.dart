import 'package:flutter/material.dart';
import 'package:grade/controller/professor_controller.dart';
import 'package:grade/model/professor.dart';
import 'package:grade/view/admin/admin_inicio.dart';
import 'package:grade/view/component/admin_formulario_professor.dart';
import 'package:grade/view/component/carregando.dart';
import 'package:grade/view/component/container_base.dart';
import 'package:grade/view/component/admin_navegacao.dart';
import 'package:grade/view/component/my_simple_tile.dart';
import 'package:quickalert/models/quickalert_type.dart';
import 'package:quickalert/widgets/quickalert_dialog.dart';

class AdminProfessoresPage extends StatefulWidget {
  static const rota = '${AdminInicioPage.rota}/professores';

  const AdminProfessoresPage({super.key});
  @override
  State<AdminProfessoresPage> createState() {
    return AdminProfessoresPageState();
  }
}

class AdminProfessoresPageState extends State<AdminProfessoresPage> {
  final _professorController = ProfessorController();
  final _filtroTxtController = TextEditingController();
  List<Professor> _professores = [];
  List<Professor> _professoresFiltrados = [];
  bool _carregando = true;
  bool _habilitarFiltro = false;

  @override
  void initState() {
    super.initState();
    _buscarProfessores();
  }

  void _alternarVisualizacaoFiltro() {
    if (_habilitarFiltro) {
      setState(() {
        _professoresFiltrados = _professores;
      });
    }
    setState(() {
      _habilitarFiltro = !_habilitarFiltro;
      _filtroTxtController.clear();
    });
  }

  void _filtrarProfessores(filtro) {
    var temp = _professores
        .where((professor) => professor.nome
            .toUpperCase()
            .contains(_filtroTxtController.text.toUpperCase()))
        .toList();
    setState(() {
      _professoresFiltrados = temp;
    });
  }

  Future<void> _buscarProfessores() async {
    setState(() {
      _carregando = true;
    });
    var professores = await _professorController.listar();
    setState(() {
      _professores = professores;
      _professoresFiltrados = professores;
      _carregando = false;
    });
  }

  Future<void> _abrirFormulario(
      BuildContext context, Professor? professor) async {
    return showDialog(
        context: context,
        builder: (context) => AdminFormularioProfessor(
              professor: professor,
            ));
  }

  Future<void> _deletarProfessor(
      Professor professor, BuildContext context) async {
    return QuickAlert.show(
      context: context,
      type: QuickAlertType.confirm,
      cancelBtnText: 'Voltar',
      confirmBtnText: 'Deletar',
      confirmBtnColor: Color(Colors.red.value),
      onCancelBtnTap: () => Navigator.pop(context),
      onConfirmBtnTap: () async {
        try {
          await _professorController.deletar(professor);
          Navigator.pop(context);
          _buscarProfessores();
        } catch (e) {
          QuickAlert.show(
            context: context,
            type: QuickAlertType.error,
            confirmBtnText: 'Fechar',
            text: e.toString(),
            title: 'Erro ao deletar professor',
          );
        }
      },
      text: 'Deseja deletar "${professor.nome}"?',
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
                    hintText: 'Nome', label: Text('Nome professor')),
                controller: _filtroTxtController,
                onFieldSubmitted: _filtrarProfessores,
              )
            : const Text('Admin: Professores'),
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
            : ListView.separated(
                separatorBuilder: (context, index) => const SizedBox(
                  height: 5.0,
                ),
                itemCount: _professoresFiltrados.length,
                itemBuilder: (context, index) => MySimpleTile(
                  title: Text(_professoresFiltrados[index].nome),
                  onLongPress: () {
                    _abrirFormulario(context, _professoresFiltrados[index])
                        .then((value) => _buscarProfessores());
                  },
                  trailing: IconButton(
                      onPressed: () => _deletarProfessor(
                          _professoresFiltrados[index], context),
                      icon: const Icon(Icons.delete)),
                ),
              ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _abrirFormulario(context, null).then((value) => _buscarProfessores());
        },
        enableFeedback: true,
        child: const Icon(Icons.add_circle),
      ),
    );
  }
}
