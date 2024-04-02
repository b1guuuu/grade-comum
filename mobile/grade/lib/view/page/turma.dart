import 'package:flutter/material.dart';
import 'package:grade/controller/aluno_controller.dart';
import 'package:grade/controller/turma_controller.dart';
import 'package:grade/model/turma.dart';
import 'package:grade/view/component/carregando.dart';
import 'package:grade/view/page/inicio.dart';
import 'package:grade/view/page/turma_inscricao.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
  List<Turma> _turmas = [];
  bool _carregando = true;

  @override
  void initState() {
    super.initState();
    buscarTurmasInscritas();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Turmas'),
        actions: [
          IconButton(
              onPressed: buscarTurmasInscritas,
              icon: const Icon(Icons.refresh)),
          IconButton(
              onPressed: () =>
                  Navigator.pushNamed(context, TurmaInscricaoPage.rota),
              icon: const Icon(Icons.add)),
        ],
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(child: Text('Header')),
            ListTile(
              title: Text('Inicio'),
              leading: Icon(Icons.home_filled),
              onTap: () =>
                  Navigator.pushReplacementNamed(context, InicioPage.rota),
            ),
            ListTile(
              title: Text('Perfil'),
              leading: Icon(Icons.person),
            ),
            ListTile(
              title: Text('Grade'),
              leading: Icon(Icons.access_time_filled),
            ),
            ListTile(
              title: Text('Turmas'),
              leading: Icon(Icons.people),
              onTap: () => Navigator.pop(context),
            ),
            ListTile(
              title: Text('Calendário'),
              leading: Icon(Icons.calendar_month),
            ),
            ListTile(
              title: Text('Faltas'),
              leading: Icon(Icons.hourglass_empty),
            ),
            ListTile(
              title: Text('Anotações'),
              leading: Icon(Icons.edit),
            ),
            ListTile(
              title: Text('Configurações'),
              leading: Icon(Icons.settings),
            ),
          ],
        ),
      ),
      body: _carregando
          ? const Carregando()
          : Container(
              color: const Color.fromARGB(255, 208, 208, 208),
              padding: const EdgeInsets.all(20.0),
              child: _turmas.isEmpty
                  ? const Center(
                      child: Text('Você não tem turmas cadastradas'),
                    )
                  : ListView.builder(
                      itemCount: _turmas.length,
                      prototypeItem: ListTile(
                        title: Text(
                            '${_turmas.first.disciplina.nome} - ${_turmas.first.numero}'),
                        subtitle: Text(
                            'Professor (a): ${_turmas.first.professor.nome}'),
                      ),
                      itemBuilder: (context, index) {
                        return ListTile(
                          title: Text(
                              '${_turmas[index].disciplina.nome} - ${_turmas[index].numero}'),
                          subtitle: Text(
                              'Professor (a): ${_turmas[index].professor.nome}'),
                        );
                      },
                    ),
            ),
    );
  }

  Future<void> buscarTurmasInscritas() async {
    setState(() {
      _carregando = true;
    });
    final SharedPreferences preferences = await SharedPreferences.getInstance();
    var idAluno = preferences.getInt('idAluno');
    var resposta = await _turmaController.buscaTurmasInscritas(idAluno!);
    print(resposta);
    setState(() {
      _turmas = resposta;
      _carregando = false;
    });
  }
}
