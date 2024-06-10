import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:grade/controller/global_controller.dart';
import 'package:grade/model/aluno.dart';
import 'package:grade/view/admin/admin_inicio.dart';
import 'package:grade/view/component/container_base.dart';
import 'package:grade/view/component/my_button.dart';
import 'package:grade/view/component/my_container.dart';
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
    var screenWidth = MediaQuery.of(context).size.width;
    var mainContainerWidth =
        screenWidth * 0.8 > 400.0 ? 400.0 : screenWidth * 0.8;
    var contentContainerWidth = mainContainerWidth * 0.75;
    var buttonWidth = contentContainerWidth - 100;
    return Scaffold(
      appBar: AppBar(
        title: const Center(child: Text('Bem-vindo!')),
      ),
      body: ContainerBase(
        child: Center(
          child: MyContainer(
            mainContainerWidth: mainContainerWidth,
            mainContainerHeight: mainContainerWidth,
            contentContainerHeight: contentContainerWidth,
            contentContainerWidth: contentContainerWidth,
            child: Column(
              children: [
                const Text(
                  'Selecione se deseja entrar ou realizar cadastro na plataforma',
                  style: TextStyle(fontSize: 20),
                ),
                const SizedBox(
                  height: 10.0,
                ),
                MyButton(
                    onPressed: () =>
                        Navigator.of(context).pushNamed(LoginPage.rota),
                    minWidth: buttonWidth,
                    child: const Text('Entrar')),
                MyButton(
                    onPressed: () =>
                        Navigator.of(context).pushNamed(CadastroPage.rota),
                    minWidth: buttonWidth,
                    child: const Text('Cadastrar')),
                MyButton(
                    onPressed: () =>
                        Navigator.of(context).pushNamed(AdminInicioPage.rota),
                    minWidth: buttonWidth,
                    child: const Text('Admin')),
              ],
            ),
          ),
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
