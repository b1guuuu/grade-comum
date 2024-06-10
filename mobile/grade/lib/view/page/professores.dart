import 'package:flutter/material.dart';
import 'package:grade/controller/global_controller.dart';
import 'package:grade/controller/presenca_controller.dart';
import 'package:grade/model/presenca.dart';
import 'package:grade/view/component/carregando.dart';
import 'package:grade/view/component/container_base.dart';
import 'package:grade/view/component/formulario_presenca_professor.dart';
import 'package:grade/view/component/my_simple_tile.dart';
import 'package:grade/view/component/navegacao.dart';
import 'package:grade/view/page/professores_disciplinas.dart';
import 'package:grade/view/page/professores_grade.dart';

class ProfessoresPage extends StatefulWidget {
  static const rota = '/professores';

  const ProfessoresPage({super.key});
  @override
  State<ProfessoresPage> createState() {
    return ProfessoresPageState();
  }
}

class ProfessoresPageState extends State<ProfessoresPage> {
  final _presencaController = PresencaController();
  final _filtroTxtController = TextEditingController();
  List<Presenca> _presencas = [];
  List<Presenca> _presencasFiltradas = [];
  bool _carregando = true;
  bool _habilitarFiltro = false;

  @override
  void initState() {
    super.initState();
    _listarApenasProfessoresDeTurmasInscritas();
  }

  void _alternarVisualizacaoFiltro() {
    if (_habilitarFiltro) {
      setState(() {
        _presencasFiltradas = _presencas;
      });
    }
    setState(() {
      _habilitarFiltro = !_habilitarFiltro;
      _filtroTxtController.clear();
    });
  }

  void _filtrarPresencas(filtro) {
    var temp = _presencas
        .where((presenca) => presenca.professor!.nome
            .toUpperCase()
            .contains(_filtroTxtController.text.toUpperCase()))
        .toList();
    setState(() {
      _presencasFiltradas = temp;
    });
  }

  Future<void> _buscarPresencas() async {
    setState(() {
      _carregando = true;
    });
    var presencas = await _presencaController.listar();
    setState(() {
      _presencas = presencas;
      _presencasFiltradas = presencas;
      _carregando = false;
    });
  }

  Future<void> _abrirFormulario(BuildContext context, Presenca presenca) async {
    return showDialog(
        context: context,
        builder: (context) => FormularioPresencaProfessor(presenca: presenca));
  }

  Future<void> _listarApenasProfessoresDeTurmasInscritas() async {
    setState(() {
      _carregando = true;
    });
    var presencas = await _presencaController
        .listarAluno(GlobalController.instance.aluno!.id!);
    setState(() {
      _presencas = presencas;
      _presencasFiltradas = presencas;
      _carregando = false;
    });
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
                onFieldSubmitted: _filtrarPresencas,
              )
            : const Text('Professores'),
        actions: [
          IconButton(
              onPressed: _alternarVisualizacaoFiltro,
              icon: _habilitarFiltro
                  ? const Icon(Icons.cancel)
                  : const Icon(Icons.search)),
          PopupMenuButton(
            enableFeedback: true,
            icon: const Icon(Icons.menu),
            itemBuilder: (BuildContext context) {
              return [
                PopupMenuItem(
                  child: const Text('Professores de turmas inscritas'),
                  onTap: () => _listarApenasProfessoresDeTurmasInscritas(),
                ),
                PopupMenuItem(
                  child: const Text('Todos os professores'),
                  onTap: () => _buscarPresencas(),
                ),
              ];
            },
          )
        ],
      ),
      drawer: const Drawer(
        child: Navegacao(),
      ),
      body: ContainerBase(
        child: _carregando
            ? const Carregando()
            : _presencasFiltradas.isEmpty
                ? const Center(
                    child: Text('Não há professores para os filtros definidos'),
                  )
                : ListView.separated(
                    separatorBuilder: (context, index) => const SizedBox(
                      height: 5,
                    ),
                    itemCount: _presencasFiltradas.length,
                    itemBuilder: (context, index) => MySimpleTile(
                      title: Text(_presencasFiltradas[index].professor!.nome),
                      subtitle: Text(
                          'Presente: ${_presencasFiltradas[index].presente ? 'SIM' : 'NÃO'}\nÚltima atualização: ${_presencasFiltradas[index].ultimaAtualizacao.toLocal().toString().substring(0, 11)}\nObservação: ${_presencasFiltradas[index].observacao}'),
                      onTap: () {
                        _abrirFormulario(context, _presencasFiltradas[index])
                            .then((value) => _buscarPresencas());
                      },
                      trailing: SizedBox(
                        width: 100.0,
                        child: Row(
                          children: [
                            IconButton(
                                onPressed: () {
                                  Navigator.pushNamed(
                                      context, ProfessoresDisciplinasPage.rota,
                                      arguments: _presencasFiltradas[index]
                                          .idProfessor);
                                },
                                icon: const Icon(
                                    Icons.collections_bookmark_sharp)),
                            IconButton(
                                onPressed: () {
                                  Navigator.pushNamed(
                                      context, ProfessoresGradePage.rota,
                                      arguments: _presencasFiltradas[index]
                                          .idProfessor);
                                },
                                icon: const Icon(Icons.calendar_month)),
                          ],
                        ),
                      ),
                    ),
                  ),
      ),
    );
  }
}
