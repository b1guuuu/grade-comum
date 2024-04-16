import 'package:flutter/material.dart';
import 'package:grade/controller/disciplina_controller.dart';
import 'package:grade/controller/global_controller.dart';
import 'package:grade/model/disciplina.dart';
import 'package:grade/view/component/carregando.dart';
import 'package:grade/view/component/navegacao.dart';
import 'package:grade/view/page/anotacao_disciplina.dart';

class AnotacaoPage extends StatefulWidget {
  static const rota = '/anotacao';
  const AnotacaoPage({super.key});

  @override
  State<AnotacaoPage> createState() {
    return AnotacaoPageState();
  }
}

class AnotacaoPageState extends State<AnotacaoPage> {
  final DisciplinaController _controller = DisciplinaController();
  late List<Disciplina> _disciplinas = [];
  bool _carregando = true;

  @override
  void initState() {
    super.initState();
    _listarDisciplinasComAnotacoes();
  }

  Future<void> _listarDisciplinasComAnotacoes() async {
    setState(() {
      _carregando = true;
    });
    var disciplinasAnotacoes = await _controller
        .listarDisciplinasAnotacoesAluno(GlobalController.instance.aluno!.id);
    var disciplinasInscritas = await _controller
        .listarDisciplinasAlunoInscrito(GlobalController.instance.aluno!.id);

    disciplinasAnotacoes.addAll(disciplinasInscritas);
    setState(() {
      _disciplinas = disciplinasAnotacoes.toSet().toList();
      _carregando = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Anotações'),
      ),
      drawer: const Drawer(
        child: Navegacao(),
      ),
      body: Container(
        color: const Color.fromARGB(255, 208, 208, 208),
        padding: const EdgeInsets.all(5.0),
        child: _carregando
            ? const Carregando()
            : _disciplinas.isEmpty
                ? const Center(
                    child: Text(
                        'Você não tem turmas cadastradas nem anotações de turmas antigas'),
                  )
                : ListView.builder(
                    itemCount: _disciplinas.length,
                    itemBuilder: (context, index) => ListTile(
                      title: Text(_disciplinas[index].nome),
                      onTap: () => Navigator.pushNamed(
                          context, AnotacaoDisciplinaPage.rota,
                          arguments: _disciplinas[index]),
                    ),
                  ),
      ),
    );
  }
}
