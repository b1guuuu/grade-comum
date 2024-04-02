import 'package:flutter/material.dart';
import 'package:grade/controller/turma_controller.dart';
import 'package:grade/model/turma.dart';
import 'package:grade/view/component/carregando.dart';
import 'package:grade/view/page/turma.dart';

class TurmaInscricaoPage extends StatefulWidget {
  static const rota = '${TurmaPage.rota}/inscricao';
  const TurmaInscricaoPage({super.key});

  @override
  State<TurmaInscricaoPage> createState() {
    return TurmaInscricaoPageState();
  }
}

class TurmaInscricaoPageState extends State<TurmaInscricaoPage> {
  final TurmaController _turmaController = TurmaController();
  List<Turma> _turmas = [];
  List<Turma> _turmasFiltradas = [];
  bool _carregando = true;

  @override
  void initState() {
    super.initState();
    buscarTurmas();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Turmas disponíveis'),
        ),
        body: Container(
          color: const Color.fromARGB(255, 208, 208, 208),
          padding: const EdgeInsets.all(20.0),
          child: _carregando
              ? const Carregando()
              : _turmasFiltradas.isEmpty
                  ? const Center(
                      child: Text('Não há turmas para os filtros definidos'),
                    )
                  : ListView.builder(
                      itemCount: _turmasFiltradas.length,
                      prototypeItem: ListTile(
                        title: Text(
                            '${_turmasFiltradas.first.disciplina.nome} - ${_turmasFiltradas.first.numero}'),
                        subtitle: Text(
                            'Professor (a): ${_turmasFiltradas.first.professor.nome}'),
                      ),
                      itemBuilder: (context, index) {
                        return ListTile(
                          title: Text(
                              '${_turmasFiltradas[index].disciplina.nome} - ${_turmasFiltradas[index].numero}'),
                          subtitle: Text(
                              'Professor (a): ${_turmasFiltradas[index].professor.nome}'),
                        );
                      },
                    ),
        ));
  }

  Future<void> buscarTurmas() async {
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
}
