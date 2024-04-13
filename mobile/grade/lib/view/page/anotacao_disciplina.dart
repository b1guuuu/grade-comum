import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:grade/controller/anotacao_controller.dart';
import 'package:grade/controller/global_controller.dart';
import 'package:grade/model/anotacao.dart';
import 'package:grade/model/disciplina.dart';
import 'package:grade/view/component/carregando.dart';
import 'package:grade/view/component/formulario_anotacao.dart';
import 'package:grade/view/page/anotacao.dart';

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
        GlobalController.instance.aluno.id, widget.disciplina.id);
    setState(() {
      _anotacoes = temp;
      _carregando = false;
    });
  }

  Future<void> _apresentarModalNovaAnotacao(BuildContext context) async {
    return showDialog(
      context: context,
      builder: (context) {
        return FormularioAnotacao(idDisciplina: widget.disciplina.id);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.disciplina.nome),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _apresentarModalNovaAnotacao(context)
              .then((value) => _listarAnotacoes());
        },
        enableFeedback: true,
        child: const Icon(Icons.add_circle),
      ),
      body: Container(
        color: const Color.fromARGB(255, 208, 208, 208),
        padding: const EdgeInsets.all(5.0),
        child: _carregando
            ? const Carregando()
            : _anotacoes.isEmpty
                ? const Center(
                    child: Text('Você não tem anotações cadastradas'),
                  )
                : ListView.builder(
                    itemCount: _anotacoes.length,
                    itemBuilder: (context, index) => SizedBox(
                      width: 400,
                      child: Row(
                        children: [
                          const Icon(Icons.chevron_right),
                          Expanded(child: Text(_anotacoes[index].conteudo)),
                          Row(
                            children: [
                              IconButton(
                                  onPressed: () => print('delete'),
                                  icon: Icon(Icons.delete)),
                              IconButton(
                                  onPressed: () => print('edit'),
                                  icon: Icon(Icons.edit_outlined)),
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
      ),
    );
  }
}
