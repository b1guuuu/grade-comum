import 'package:flutter/material.dart';
import 'package:grade/view/page/grade.dart';
import 'package:grade/view/page/inicio.dart';
import 'package:grade/view/page/perfil.dart';
import 'package:grade/view/page/turma.dart';

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
          title: const Text('Turmas'),
          leading: const Icon(Icons.people),
          onTap: () => Navigator.pushReplacementNamed(context, TurmaPage.rota),
        ),
        ListTile(
          title: const Text('Calendário'),
          leading: const Icon(Icons.calendar_month),
          onTap: () => Navigator.pushReplacementNamed(context, InicioPage.rota),
        ),
        ListTile(
          title: const Text('Faltas'),
          leading: const Icon(Icons.hourglass_empty),
          onTap: () => Navigator.pushReplacementNamed(context, InicioPage.rota),
        ),
        ListTile(
          title: const Text('Anotações'),
          leading: const Icon(Icons.edit),
          onTap: () => Navigator.pushReplacementNamed(context, InicioPage.rota),
        ),
        ListTile(
          title: const Text('Configurações'),
          leading: const Icon(Icons.settings),
          onTap: () => Navigator.pushReplacementNamed(context, InicioPage.rota),
        ),
      ],
    );
  }
}