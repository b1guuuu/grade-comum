import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:grade/controller/aluno_controller.dart';
import 'package:grade/controller/global_controller.dart';
import 'package:grade/model/aluno.dart';
import 'package:grade/view/component/container_base.dart';
import 'package:grade/view/component/my_button.dart';
import 'package:grade/view/component/my_container.dart';
import 'package:grade/view/page/inicio.dart';
import 'package:grade/view/util/alertas_personalizados.dart';
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

  final _formLogin = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    var screenWidth = MediaQuery.of(context).size.width;
    var mainContainerWidth =
        screenWidth * 0.8 > 400.0 ? 400.0 : screenWidth * 0.8;
    var contentContainerWidth = mainContainerWidth * 0.75;
    var buttonWidth = contentContainerWidth - 100;
    return Scaffold(
        appBar: AppBar(
          title: const Text('Efetuar Login'),
        ),
        body: ContainerBase(
          child: Center(
            child: MyContainer(
              mainContainerHeight: mainContainerWidth,
              mainContainerWidth: mainContainerWidth,
              contentContainerHeight: contentContainerWidth + 30,
              contentContainerWidth: contentContainerWidth,
              child: ListView(
                children: [
                  const SizedBox(
                    height: 10,
                  ),
                  const Text(
                    'Preencha os dados abaixo para acessar a sua conta',
                    style: TextStyle(fontSize: 20),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Form(
                    key: _formLogin,
                    child: Column(
                      children: [
                        TextFormField(
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "Informe a matrícula";
                            }
                            return null;
                          },
                          decoration: const InputDecoration(
                              hintText: 'Matrícula',
                              border: OutlineInputBorder()),
                          controller: _matriculaController,
                        ),
                        const SizedBox(
                          height: 10.0,
                        ),
                        TextFormField(
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "Informe a senha";
                            }
                            return null;
                          },
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
                        MyButton(
                            minWidth: buttonWidth,
                            onPressed: () => {
                                  if (_formLogin.currentState!.validate())
                                    {efetuarLogin()}
                                },
                            child: const Text('Entrar'))
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ));
  }

  Future<void> efetuarLogin() async {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Processando')),
    );
    var aluno = Aluno.login(
        matricula: _matriculaController.text, senha: _senhaController.text);
    try {
      aluno = await _alunoController.login(aluno);
      final SharedPreferences preferences =
          await SharedPreferences.getInstance();
      preferences.setString('aluno', jsonEncode(aluno.toMap()));
      GlobalController.instance.setAluno(aluno);
      Navigator.of(context).pushReplacementNamed(InicioPage.rota);
    } on Exception catch (e) {
      AlertasPersonalizados.show(context, e);
    }
  }
}
