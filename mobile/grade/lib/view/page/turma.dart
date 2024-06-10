import 'package:flutter/material.dart';
import 'package:grade/controller/global_controller.dart';
import 'package:grade/controller/inscricao_controller.dart';
import 'package:grade/controller/progresso_controller.dart';
import 'package:grade/controller/turma_controller.dart';
import 'package:grade/model/inscricao.dart';
import 'package:grade/model/turma.dart';
import 'package:grade/view/component/carregando.dart';
import 'package:grade/view/component/container_base.dart';
import 'package:grade/view/component/formulario_atualizacao_horarios.dart';
import 'package:grade/view/component/navegacao.dart';
import 'package:grade/view/component/turma_list_tile.dart';
import 'package:grade/view/page/turma_inscricao.dart';
import 'package:quickalert/models/quickalert_type.dart';
import 'package:quickalert/widgets/quickalert_dialog.dart';

class TurmaPage extends StatefulWidget {
  static const rota = '/turmas';

  const TurmaPage({super.key});

  @override
  State<TurmaPage> createState() {
    return TurmaPageState();
  }
}

class TurmaPageState extends State<TurmaPage> {
  final _turmaController = TurmaController();
  final _inscricaoController = InscricaoController();
  final _progressoController = ProgressoController();
  List<Turma> _turmas = [];
  bool _carregando = true;

  @override
  void initState() {
    super.initState();
    _buscarTurmasInscritas();
  }

  Future<void> _abrirFormulario(BuildContext context, Turma turma) async {
    return showDialog(
        context: context,
        builder: (context) => FormularioAtualizacaoHorarios(turma: turma));
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
                  : ListView.separated(
                    separatorBuilder: (context, index) => const SizedBox(height: 5,),
                      itemCount: _turmas.length,
                      itemBuilder: (context, index) {
                        return TurmaListTile(
                          turma: _turmas[index],
                          trailing: SizedBox(
                            width: 150,
                            child: Row(
                              children: [
                                IconButton(
                                    onPressed: () => _abrirFormulario(
                                        context, _turmas[index]),
                                    icon: const Icon(Icons.edit)),
                                IconButton(
                                    onPressed: () =>
                                        _confirmarConclusao(_turmas[index]),
                                    icon: const Icon(Icons.check_box)),
                                IconButton(
                                    onPressed: () =>
                                        _confirmarExclusao(_turmas[index]),
                                    icon: const Icon(Icons.delete)),
                              ],
                            ),
                          ),
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

  Future<void> _confirmarExclusao(Turma turma) async {
    return QuickAlert.show(
      context: context,
      type: QuickAlertType.confirm,
      cancelBtnText: 'Voltar',
      confirmBtnText: 'Deletar',
      confirmBtnColor: Color(Colors.red.value),
      onCancelBtnTap: () => Navigator.pop(context),
      onConfirmBtnTap: () => _deletar(turma),
      text: 'Deseja deletar a inscrição na turma "${turma.codigo}"?',
      title: 'Confirmação',
    );
  }

  Future<void> _confirmarConclusao(Turma turma) async {
    return QuickAlert.show(
      context: context,
      type: QuickAlertType.confirm,
      cancelBtnText: 'Voltar',
      confirmBtnText: 'Confirmar',
      confirmBtnColor: Color(Colors.green.value),
      onCancelBtnTap: () => Navigator.pop(context),
      onConfirmBtnTap: () => _concluirDisciplina(turma),
      text:
          'Deseja confirmar a aprovação na disciplina "${turma.disciplina!.nome}"?',
      title: 'Confirmação',
    );
  }

  Future<void> _deletar(Turma turma) async {
    try {
      Navigator.pop(context);
      return _inscricaoController.deletarInscricao(Inscricao(
          idAluno: GlobalController.instance.aluno!.id!, idTurma: turma.id!));
    } catch (e) {
      QuickAlert.show(
        context: context,
        type: QuickAlertType.error,
        confirmBtnText: 'Fechar',
        text: e.toString(),
        title: 'Erro ao deletar turma',
      );
    } finally {
      _buscarTurmasInscritas();
    }
  }

  Future<void> _concluirDisciplina(Turma turma) async {
    try {
      Navigator.pop(context);
      await _progressoController.atualizar(
          turma.disciplina!.id!, GlobalController.instance.aluno!.id!);
      return _inscricaoController.deletarInscricao(Inscricao(
          idAluno: GlobalController.instance.aluno!.id!, idTurma: turma.id!));
    } catch (e) {
      QuickAlert.show(
        context: context,
        type: QuickAlertType.error,
        confirmBtnText: 'Fechar',
        text: e.toString(),
        title: 'Erro ao concluir disciplina',
      );
    } finally {
      _buscarTurmasInscritas();
    }
  }
}
