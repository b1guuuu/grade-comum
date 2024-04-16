import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:grade/controller/aluno_controller.dart';
import 'package:grade/controller/global_controller.dart';
import 'package:grade/model/aluno.dart';
import 'package:grade/view/component/campos_aluno.dart';
import 'package:grade/view/page/inicio.dart';
import 'package:quickalert/quickalert.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CadastroPage extends StatefulWidget {
  static const rota = '/cadastro';

  const CadastroPage({super.key});

  @override
  State<CadastroPage> createState() {
    return CadastroPageState();
  }
}

class CadastroPageState extends State<CadastroPage> {
  final AlunoController _alunoController = AlunoController();
  final TextEditingController _nomeController = TextEditingController();
  final TextEditingController _matriculaController = TextEditingController();
  final TextEditingController _senhaController = TextEditingController();
  final TextEditingController _confirmaSenhaController =
      TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Efetuar Cadastro'),
      ),
      body: Container(
        color: const Color.fromARGB(255, 208, 208, 208),
        padding: const EdgeInsets.all(50.0),
        child: Column(
          children: [
            CamposAluno(
                nomeController: _nomeController,
                matriculaController: _matriculaController,
                senhaController: _senhaController,
                confirmaSenhaController: _confirmaSenhaController),
            FilledButton(
                onPressed: efetuarCadastro, child: const Text('Cadastrar'))
          ],
        ),
      ),
    );
  }

  Future<void> efetuarCadastro() async {
    if (_nomeController.text.isNotEmpty &&
        _matriculaController.text.isNotEmpty &&
        _senhaController.text.isNotEmpty &&
        _confirmaSenhaController.text.isNotEmpty &&
        _senhaController.text == _confirmaSenhaController.text) {
      var aluno = Aluno.cadastro(
          nome: _nomeController.text,
          matricula: _matriculaController.text,
          senha: _senhaController.text);
      aluno = await _alunoController.cadastro(aluno);
      final SharedPreferences preferences =
          await SharedPreferences.getInstance();
      preferences.setString('aluno', jsonEncode(aluno.toMapLeitura()));
      GlobalController.instance.setAluno(aluno);
      Navigator.of(context).pushReplacementNamed(InicioPage.rota);
    } else {
      QuickAlert.show(
          context: context,
          type: QuickAlertType.error,
          title: 'Campos inválido',
          text: 'Verifique as informações inseridas',
          confirmBtnText: "Fechar");
    }
  }
}
