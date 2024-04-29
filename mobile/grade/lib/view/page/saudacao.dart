import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:grade/controller/global_controller.dart';
import 'package:grade/model/aluno.dart';
import 'package:grade/view/admin/inicio.dart';
import 'package:grade/view/page/cadastro.dart';
import 'package:grade/view/page/inicio.dart';
import 'package:grade/view/page/login.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SaudacaoPage extends StatelessWidget {
  static const rota = '/';

  const SaudacaoPage({super.key});

  @override
  Widget build(BuildContext context) {
    verificaAlunoLogado(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Bem-vindo!'),
      ),
      body: Container(
        color: const Color.fromARGB(255, 208, 208, 208),
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            const Text(
                'Selecione se deseja entrar ou realizar cadastro na plataforma'),
            const SizedBox(
              height: 10.0,
            ),
            FilledButton(
                onPressed: () =>
                    Navigator.of(context).pushNamed(LoginPage.rota),
                child: const Text('Entrar')),
            const SizedBox(
              height: 10.0,
            ),
            FilledButton(
                onPressed: () =>
                    Navigator.of(context).pushNamed(CadastroPage.rota),
                child: const Text('Cadastrar')),
            const SizedBox(
              height: 10.0,
            ),
            FilledButton(
                onPressed: () =>
                    Navigator.of(context).pushNamed(InicioAdminPage.rota),
                child: const Text('Admin'))
          ],
        ),
      ),
    );
  }

  Future<void> verificaAlunoLogado(context) async {
    final SharedPreferences preferences = await SharedPreferences.getInstance();
    var alunoStr = preferences.getString('aluno');

    if (alunoStr != null) {
      GlobalController.instance.setAluno(Aluno.fromJson(jsonDecode(alunoStr)));
      Navigator.of(context).pushReplacementNamed(InicioPage.rota);
    }
  }
}
