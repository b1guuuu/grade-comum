import 'package:flutter/material.dart';
import 'package:grade/controller/global_controller.dart';
import 'package:grade/controller/inscricao_controller.dart';
import 'package:grade/controller/turma_controller.dart';
import 'package:grade/model/inscricao.dart';
import 'package:grade/model/turma.dart';
import 'package:grade/view/component/carregando.dart';
import 'package:grade/view/component/turma_list_tile.dart';
import 'package:grade/view/page/turma.dart';
import 'package:quickalert/quickalert.dart';

class TurmaInscricaoPage extends StatefulWidget {
  static const rota = '${TurmaPage.rota}/inscricao';
  final List<Turma> turmasInscritas;

  const TurmaInscricaoPage({super.key, required this.turmasInscritas});

  @override
  State<TurmaInscricaoPage> createState() {
    return TurmaInscricaoPageState();
  }
}

class TurmaInscricaoPageState extends State<TurmaInscricaoPage> {
  final TurmaController _turmaController = TurmaController();
  final InscricaoController _inscricaoController = InscricaoController();
  List<Turma> _turmas = [];
  List<Turma> _turmasFiltradas = [];
  bool _carregando = true;

  @override
  void initState() {
    super.initState();
    _buscarTurmas();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Turmas disponíveis'),
        ),
        body: Container(
          color: const Color.fromARGB(255, 208, 208, 208),
          padding: const EdgeInsets.all(5.0),
          child: _carregando
              ? const Carregando()
              : _turmasFiltradas.isEmpty
                  ? const Center(
                      child: Text('Não há turmas para os filtros definidos'),
                    )
                  : ListView.builder(
                      itemCount: _turmasFiltradas.length,
                      itemBuilder: (context, index) {
                        return TurmaListTile(
                            turma: _turmasFiltradas[index],
                            iconButton: IconButton(
                              onPressed: widget.turmasInscritas
                                      .contains(_turmasFiltradas[index])
                                  ? null
                                  : () {
                                      var turmaComMesmoNumero =
                                          widget.turmasInscritas.where(
                                        (element) =>
                                            element.numero ==
                                            _turmasFiltradas[index].numero,
                                      );
                                      if (turmaComMesmoNumero.isEmpty) {
                                        setState(() {
                                          widget.turmasInscritas
                                              .add(_turmasFiltradas[index]);
                                        });
                                        _inscreverTurma(
                                            _turmasFiltradas[index]);
                                      } else {
                                        QuickAlert.show(
                                            context: context,
                                            type: QuickAlertType.warning,
                                            title: 'Ação inválida',
                                            text:
                                                'Você já tem uma disciplina no mesmo horário',
                                            confirmBtnText: 'Fechar');
                                      }
                                    },
                              icon: const Icon(Icons.add_circle),
                            ));
                      },
                    ),
        ));
  }

  Future<void> _buscarTurmas() async {
    setState(() {
      _carregando = true;
    });
    var resposta = await _turmaController.buscaTodas();
    setState(() {
      _turmas = resposta;
      _turmasFiltradas = resposta;
      _carregando = false;
    });
  }

  Future<void> _inscreverTurma(Turma turma) async {
    await _inscricaoController.inscreverEmTurma(Inscricao(
        idAluno: GlobalController.instance.aluno.id, idTurma: turma.id));
  }
}
