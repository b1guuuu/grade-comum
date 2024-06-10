import 'package:flutter/material.dart';
import 'package:grade/controller/global_controller.dart';
import 'package:grade/controller/presenca_controller.dart';
import 'package:grade/model/presenca.dart';
import 'package:grade/view/component/carregando.dart';
import 'package:grade/view/component/my_simple_tile.dart';

class ListagemPresencaProfessores extends StatefulWidget {
  const ListagemPresencaProfessores({super.key});

  @override
  State<ListagemPresencaProfessores> createState() {
    return ListagemPresencaProfessoresState();
  }
}

class ListagemPresencaProfessoresState
    extends State<ListagemPresencaProfessores> {
  final _presencaController = PresencaController();
  List<Presenca> _presencas = [];
  bool _carregando = true;

  @override
  void initState() {
    super.initState();
    _listarApenasProfessoresDeTurmasInscritas();
  }

  Future<void> _listarApenasProfessoresDeTurmasInscritas() async {
    setState(() {
      _carregando = true;
    });
    var presencas = await _presencaController
        .listarAluno(GlobalController.instance.aluno!.id!);
    setState(() {
      _presencas = presencas;

      _carregando = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return _carregando
        ? const Carregando()
        : ListView.separated(
            itemBuilder: (context, index) => MySimpleTile(
                  title: Text(_presencas[index].professor!.nome),
                  subtitle: Text(
                      'Presente: ${_presencas[index].presente ? 'SIM' : 'NÃO'}\nÚltima atualização: ${_presencas[index].ultimaAtualizacao.toLocal().toString().substring(0, 11)}\nObservação: ${_presencas[index].observacao}'),
                ),
            separatorBuilder: (context, index) => const SizedBox(
                  height: 5.0,
                ),
            itemCount: _presencas.length);
  }
}
