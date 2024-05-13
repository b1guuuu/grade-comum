import 'package:flutter/material.dart';
import 'package:grade/controller/global_controller.dart';
import 'package:grade/view/page/anotacao.dart';
import 'package:grade/view/page/calendario.dart';
import 'package:grade/view/page/ppc.dart';
import 'package:grade/view/page/grade.dart';
import 'package:grade/view/page/inicio.dart';
import 'package:grade/view/page/perfil.dart';
import 'package:grade/view/page/professores.dart';
import 'package:grade/view/page/saudacao.dart';
import 'package:grade/view/page/turma.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Navegacao extends StatelessWidget {
  const Navegacao({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: EdgeInsets.zero,
      children: [
        const DrawerHeader(child: Text('')),
        ListTile(
          title: const Text('Inicio'),
          leading: const Icon(Icons.home_filled),
          onTap: () => Navigator.pushReplacementNamed(context, InicioPage.rota),
        ),
        ListTile(
          title: const Text('Perfil'),
          leading: const Icon(Icons.person),
          onTap: () => Navigator.pushReplacementNamed(context, PerfilPage.rota),
        ),
        ListTile(
          title: const Text('Grade'),
          leading: const Icon(Icons.access_time_filled),
          onTap: () => Navigator.pushReplacementNamed(context, GradePage.rota),
        ),
        ListTile(
          title: const Text('Disciplinas curso (PPC)'),
          leading: const Icon(Icons.library_books_outlined),
          onTap: () => Navigator.pushReplacementNamed(context, PPCPage.rota),
        ),
        ListTile(
          title: const Text('Turmas'),
          leading: const Icon(Icons.people),
          onTap: () => Navigator.pushReplacementNamed(context, TurmaPage.rota),
        ),
        ListTile(
          title: const Text('Calendário'),
          leading: const Icon(Icons.calendar_month),
          onTap: () =>
              Navigator.pushReplacementNamed(context, CalendarioPage.rota),
        ),
        ListTile(
          title: const Text('Professores'),
          leading: const Icon(Icons.people),
          onTap: () =>
              Navigator.pushReplacementNamed(context, ProfessoresPage.rota),
        ),
        ListTile(
          title: const Text('Anotações'),
          leading: const Icon(Icons.edit),
          onTap: () =>
              Navigator.pushReplacementNamed(context, AnotacaoPage.rota),
        ),
        ListTile(
          title: const Text('Configurações'),
          leading: const Icon(Icons.settings),
          onTap: () => Navigator.pushReplacementNamed(context, InicioPage.rota),
        ),
        ListTile(
            title: const Text('Sair'),
            leading: const Icon(Icons.logout_rounded),
            onTap: () => {
                  GlobalController.instance.setAluno(null),
                  SharedPreferences.getInstance()
                      .then((preferences) => preferences.clear()),
                  Navigator.pushReplacementNamed(context, SaudacaoPage.rota),
                }),
      ],
    );
  }
}
