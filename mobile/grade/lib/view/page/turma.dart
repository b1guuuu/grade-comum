import 'package:flutter/material.dart';
import 'package:grade/controller/global_controller.dart';
import 'package:grade/controller/inscricao_controller.dart';
import 'package:grade/controller/turma_controller.dart';
import 'package:grade/model/inscricao.dart';
import 'package:grade/model/turma.dart';
import 'package:grade/view/component/carregando.dart';
import 'package:grade/view/component/container_base.dart';
import 'package:grade/view/component/navegacao.dart';
import 'package:grade/view/component/turma_list_tile.dart';
import 'package:grade/view/page/turma_inscricao.dart';

class TurmaPage extends StatefulWidget {
  static const rota = '/turmas';

  const TurmaPage({super.key});

  @override
  State<TurmaPage> createState() {
    return TurmaPageState();
  }
}

class TurmaPageState extends State<TurmaPage> {
  final TurmaController _turmaController = TurmaController();
  final InscricaoController _inscricaoController = InscricaoController();
  List<Turma> _turmas = [];
  bool _carregando = true;

  @override
  void initState() {
    super.initState();
    _buscarTurmasInscritas();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Turmas'),
        actions: [
          IconButton(
              onPressed: _buscarTurmasInscritas,
              icon: const Icon(Icons.refresh)),
          IconButton(
              onPressed: () => Navigator.pushNamed(
                      context, TurmaInscricaoPage.rota,
                      arguments: _turmas)
                  .then((value) => _buscarTurmasInscritas()),
              icon: const Icon(Icons.add)),
        ],
      ),
      drawer: const Drawer(
        child: Navegacao(),
      ),
      body: _carregando
          ? const Carregando()
          : ContainerBase(
              child: _turmas.isEmpty
                  ? const Center(
                      child: Text('Você não tem turmas cadastradas'),
                    )
                  : ListView.builder(
                      itemCount: _turmas.length,
                      itemBuilder: (context, index) {
                        return TurmaListTile(
                          turma: _turmas[index],
                          iconButton: IconButton(
                              onPressed: () =>
                                  _deletarInscriacao(_turmas[index]),
                              icon: const Icon(Icons.delete)),
                        );
                      },
                    ),
            ),
    );
  }

  Future<void> _buscarTurmasInscritas() async {
    setState(() {
      _carregando = true;
    });
    var resposta = await _turmaController
        .buscaTurmasInscritas(GlobalController.instance.aluno!.id!);
    setState(() {
      _turmas = resposta;
      _carregando = false;
    });
  }

  Future<void> _deletarInscriacao(Turma turma) async {
    await _inscricaoController.deletarInscricao(Inscricao(
        idAluno: GlobalController.instance.aluno!.id!, idTurma: turma.id!));
    _buscarTurmasInscritas();
  }
}
