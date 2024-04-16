import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:grade/controller/aluno_controller.dart';
import 'package:grade/controller/global_controller.dart';
import 'package:grade/model/aluno.dart';
import 'package:grade/view/page/inicio.dart';
import 'package:quickalert/quickalert.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginPage extends StatefulWidget {
  static const rota = '/login';

  const LoginPage({super.key});

  @override
  State<LoginPage> createState() {
    return LoginPageState();
  }
}

class LoginPageState extends State<LoginPage> {
  final AlunoController _alunoController = AlunoController();
  final TextEditingController _matriculaController = TextEditingController();
  final TextEditingController _senhaController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Efetuar Login'),
      ),
      body: Container(
        color: const Color.fromARGB(255, 208, 208, 208),
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            TextField(
              decoration: const InputDecoration(
                  hintText: 'Matrícula', border: OutlineInputBorder()),
              controller: _matriculaController,
            ),
            const SizedBox(
              height: 10.0,
            ),
            TextField(
              decoration: const InputDecoration(
                  hintText: 'Senha', border: OutlineInputBorder()),
              controller: _senhaController,
              obscureText: true,
              enableSuggestions: false,
              autocorrect: false,
            ),
            const SizedBox(
              height: 10.0,
            ),
            FilledButton(onPressed: efetuarLogin, child: const Text('Entrar'))
          ],
        ),
      ),
    );
  }

  Future<void> efetuarLogin() async {
    var aluno = Aluno.login(
        matricula: _matriculaController.text, senha: _senhaController.text);
    try {
      aluno = await _alunoController.login(aluno);
      final SharedPreferences preferences =
          await SharedPreferences.getInstance();
      preferences.setString('aluno', jsonEncode(aluno.toMapLeitura()));
      GlobalController.instance.setAluno(aluno);
      Navigator.of(context).pushReplacementNamed(InicioPage.rota);
    } catch (e) {
      QuickAlert.show(
          context: context,
          type: QuickAlertType.error,
          title: 'Não foi possível fazer login',
          text: 'Verifique os dados informados');
    }
  }
}
