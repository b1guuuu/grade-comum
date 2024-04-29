import 'package:flutter/material.dart';
import 'package:grade/view/admin/disciplinas.dart';
import 'package:grade/view/admin/inicio.dart';
import 'package:grade/view/page/saudacao.dart';

class NavegacaoAdmin extends StatelessWidget {
  const NavegacaoAdmin({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: EdgeInsets.zero,
      children: [
        const DrawerHeader(child: Text('')),
        ListTile(
          title: const Text('Inicio'),
          leading: const Icon(Icons.home_filled),
          onTap: () =>
              Navigator.pushReplacementNamed(context, InicioAdminPage.rota),
        ),
        ListTile(
          title: const Text('Cursos'),
          leading: const Icon(Icons.cases_sharp),
          onTap: () =>
              Navigator.pushReplacementNamed(context, InicioAdminPage.rota),
        ),
        ListTile(
          title: const Text('Disciplinas'),
          leading: const Icon(Icons.book),
          onTap: () =>
              Navigator.pushReplacementNamed(context, DisciplinasPage.rota),
        ),
        ListTile(
          title: const Text('Professores'),
          leading: const Icon(Icons.person),
          onTap: () =>
              Navigator.pushReplacementNamed(context, InicioAdminPage.rota),
        ),
        ListTile(
          title: const Text('Turmas'),
          leading: const Icon(Icons.people_alt_sharp),
          onTap: () =>
              Navigator.pushReplacementNamed(context, InicioAdminPage.rota),
        ),
        ListTile(
            title: const Text('Sair'),
            leading: const Icon(Icons.logout_rounded),
            onTap: () => {
                  Navigator.pushReplacementNamed(context, SaudacaoPage.rota),
                }),
      ],
    );
  }
}
