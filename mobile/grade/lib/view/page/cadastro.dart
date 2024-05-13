import 'package:flutter/material.dart';
import 'package:grade/view/component/campos_aluno.dart';
import 'package:grade/view/component/container_base.dart';

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
      body: const ContainerBase(
        child: CamposAluno(
          aluno: null,
        ),
      ),
    );
  }
}
