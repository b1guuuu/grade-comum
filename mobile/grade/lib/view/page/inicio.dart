import 'package:flutter/material.dart';
import 'package:grade/controller/aluno_controller.dart';
import 'package:grade/model/aluno.dart';
import 'package:grade/view/page/turma.dart';
import 'package:shared_preferences/shared_preferences.dart';

class InicioPage extends StatefulWidget {
  static const rota = '/inicio';

  const InicioPage({super.key});

  @override
  State<InicioPage> createState() {
    return InicioPageState();
  }
}

class InicioPageState extends State<InicioPage> {
  final AlunoController _alunoController = AlunoController();
  final TextEditingController _nomeController = TextEditingController();
  final TextEditingController _matriculaController = TextEditingController();
  final TextEditingController _senhaController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Inicio'),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            const DrawerHeader(child: Text('Header')),
            ListTile(
              title: const Text('Inicio'),
              leading: const Icon(Icons.home_filled),
              onTap: () => Navigator.pop(context),
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
              title: const Text('Turmas'),
              leading: const Icon(Icons.people),
              onTap: () =>
                  Navigator.pushReplacementNamed(context, TurmaPage.rota),
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
      body: Container(
        color: const Color.fromARGB(255, 208, 208, 208),
        padding: const EdgeInsets.all(20.0),
        child: const Center(
          child: Text('Inicio'),
        ),
      ),
    );
  }
}
