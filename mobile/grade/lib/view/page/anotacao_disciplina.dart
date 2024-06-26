import 'package:flutter/material.dart';
import 'package:grade/controller/anotacao_controller.dart';
import 'package:grade/controller/global_controller.dart';
import 'package:grade/model/anotacao.dart';
import 'package:grade/model/disciplina.dart';
import 'package:grade/view/component/carregando.dart';
import 'package:grade/view/component/container_base.dart';
import 'package:grade/view/component/formulario_anotacao.dart';
import 'package:grade/view/component/my_simple_tile.dart';
import 'package:grade/view/page/anotacao.dart';
import 'package:quickalert/models/quickalert_type.dart';
import 'package:quickalert/widgets/quickalert_dialog.dart';

class AnotacaoDisciplinaPage extends StatefulWidget {
  static const rota = '${AnotacaoPage.rota}/disciplina';
  final Disciplina disciplina;

  const AnotacaoDisciplinaPage({super.key, required this.disciplina});

  @override
  State<AnotacaoDisciplinaPage> createState() {
    return AnotacaoDisciplinaPageState();
  }
}

class AnotacaoDisciplinaPageState extends State<AnotacaoDisciplinaPage> {
  final AnotacaoController _anotacaoController = AnotacaoController();
  late List<Anotacao> _anotacoes = [];
  late bool _carregando = true;

  @override
  void initState() {
    super.initState();
    _listarAnotacoes();
  }

  Future<void> _listarAnotacoes() async {
    setState(() {
      _carregando = true;
    });
    var temp = await _anotacaoController.buscaTodosAlunoDisciplina(
        GlobalController.instance.aluno!.id!, widget.disciplina.id!);
    setState(() {
      _anotacoes = temp;
      _carregando = false;
    });
  }

  Future<void> _apresentarModalNovaAnotacao(
      BuildContext context, Anotacao? anotacao) async {
    return showDialog(
      context: context,
      builder: (context) {
        return FormularioAnotacao(
          idDisciplina: widget.disciplina.id!,
          anotacao: anotacao,
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.disciplina.nome!),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _apresentarModalNovaAnotacao(context, null)
              .then((value) => _listarAnotacoes());
        },
        enableFeedback: true,
        child: const Icon(Icons.add_circle),
      ),
      body: ContainerBase(
        child: _carregando
            ? const Carregando()
            : _anotacoes.isEmpty
                ? const Center(
                    child: Text('Você não tem anotações cadastradas'),
                  )
                : ListView.separated(
                    separatorBuilder: (context, index) => const SizedBox(
                      height: 5.0,
                    ),
                    itemCount: _anotacoes.length,
                    itemBuilder: (context, index) => MySimpleTile(
                      leading: const Icon(Icons.chevron_right),
                      title: Text(_anotacoes[index].conteudo!),
                      trailing: SizedBox(
                        width: 100,
                        child: Row(
                          children: [
                            IconButton(
                                onPressed: () =>
                                    _solicitaConfirmacaoDeletarAnotacao(
                                        _anotacoes[index], context),
                                icon: const Icon(Icons.delete)),
                            IconButton(
                                onPressed: () {
                                  _apresentarModalNovaAnotacao(
                                          context, _anotacoes[index])
                                      .then((value) => _listarAnotacoes());
                                },
                                icon: const Icon(Icons.edit_outlined)),
                          ],
                        ),
                      ),
                    ),
                  ),
      ),
    );
  }

  Future<void> _solicitaConfirmacaoDeletarAnotacao(
      Anotacao anotacao, BuildContext context) async {
    await QuickAlert.show(
      context: context,
      type: QuickAlertType.confirm,
      cancelBtnText: 'Voltar',
      confirmBtnText: 'Deletar',
      confirmBtnColor: Color(Colors.red.value),
      onCancelBtnTap: () => Navigator.pop(context),
      onConfirmBtnTap: () =>
          _deletarAnotacao(anotacao).then((value) => Navigator.pop(context)),
      text: 'Deseja deletar a anotação "${anotacao.conteudo}"?',
      title: 'Confirmação',
    );
    _listarAnotacoes();
  }

  Future<void> _deletarAnotacao(Anotacao anotacao) async {
    return _anotacaoController.deletar(anotacao);
  }
}
