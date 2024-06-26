import 'package:flutter/material.dart';
import 'package:grade/controller/disciplina_controller.dart';
import 'package:grade/model/disciplina.dart';
import 'package:grade/view/admin/admin_inicio.dart';
import 'package:grade/view/component/admin_formulario_disciplina.dart';
import 'package:grade/view/component/carregando.dart';
import 'package:grade/view/component/container_base.dart';
import 'package:grade/view/component/admin_navegacao.dart';
import 'package:grade/view/component/my_simple_tile.dart';
import 'package:quickalert/models/quickalert_type.dart';
import 'package:quickalert/widgets/quickalert_dialog.dart';

class AdminDisciplinasPage extends StatefulWidget {
  static const rota = '${AdminInicioPage.rota}/disciplinas';

  const AdminDisciplinasPage({super.key});

  @override
  State<AdminDisciplinasPage> createState() {
    return AdminDisciplinasPageState();
  }
}

class AdminDisciplinasPageState extends State<AdminDisciplinasPage> {
  final _disciplinaController = DisciplinaController();
  final _filtroTxtController = TextEditingController();
  List<Disciplina> _disciplinas = [];
  List<Disciplina> _disciplinasFiltradas = [];
  bool _carregando = true;
  bool _habilitarFiltro = false;

  @override
  void initState() {
    super.initState();
    _buscarDisciplinas();
  }

  void _alternarVisualizacaoFiltro() {
    if (_habilitarFiltro) {
      setState(() {
        _disciplinasFiltradas = _disciplinas;
      });
    }
    setState(() {
      _habilitarFiltro = !_habilitarFiltro;
      _filtroTxtController.clear();
    });
  }

  void _filtrarDisciplinas(filtro) {
    var temp = _disciplinas
        .where((disciplina) => disciplina.nome!
            .toUpperCase()
            .contains(_filtroTxtController.text.toUpperCase()))
        .toList();
    setState(() {
      _disciplinasFiltradas = temp;
    });
  }

  Future<void> _buscarDisciplinas() async {
    setState(() {
      _carregando = true;
    });
    var disciplinas = await _disciplinaController.listar();
    setState(() {
      _disciplinas = disciplinas;
      _disciplinasFiltradas = disciplinas;
      _carregando = false;
    });
  }

  Future<void> _apresentarModalNovaDisciplina(BuildContext context) async {
    return showDialog(
      context: context,
      builder: (context) {
        return const AdminFormularioDisciplina();
      },
    );
  }

  Future<void> _deletarDisciplina(
      Disciplina disciplina, BuildContext context) async {
    return QuickAlert.show(
      context: context,
      type: QuickAlertType.confirm,
      cancelBtnText: 'Voltar',
      confirmBtnText: 'Deletar',
      confirmBtnColor: Color(Colors.red.value),
      onCancelBtnTap: () => Navigator.pop(context),
      onConfirmBtnTap: () async {
        try {
          await _disciplinaController.deletar(disciplina);

          Navigator.pop(context);
          _buscarDisciplinas();
        } catch (e) {
          QuickAlert.show(
            context: context,
            type: QuickAlertType.error,
            confirmBtnText: 'Fechar',
            text: e.toString(),
            title: 'Erro ao deletar disciplina',
          );
        }
      },
      text: 'Deseja deletar "${disciplina.nome}"?',
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
                onFieldSubmitted: _filtrarDisciplinas,
              )
            : const Text('Admin: Disciplinas'),
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
                itemCount: _disciplinasFiltradas.length,
                itemBuilder: (context, index) => MySimpleTile(
                  title: Text(_disciplinasFiltradas[index].nome!),
                  subtitle: Text(_disciplinasFiltradas[index].curso!.nome!),
                  trailing: IconButton(
                      onPressed: () => _deletarDisciplina(
                          _disciplinasFiltradas[index], context),
                      icon: const Icon(Icons.delete)),
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
