import 'package:flutter/material.dart';
import 'package:grade/view/component/campos_aluno.dart';

class CadastroPage extends StatefulWidget {
  static const rota = '/cadastro';

  const CadastroPage({super.key});

  @override
  State<CadastroPage> createState() {
    return CadastroPageState();
  }
}

class CadastroPageState extends State<CadastroPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Efetuar Cadastro'),
      ),
      body: Container(
        color: const Color.fromARGB(255, 208, 208, 208),
        padding: const EdgeInsets.all(20.0),
        child: const CamposAluno(
          aluno: null,
        ),
      ),
    );
  }
}
