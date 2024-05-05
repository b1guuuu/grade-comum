import 'package:flutter/material.dart';
import 'package:grade/controller/global_controller.dart';
import 'package:grade/view/component/campos_aluno.dart';
import 'package:grade/view/component/navegacao.dart';

class PerfilPage extends StatefulWidget {
  static const rota = '/perfil';

  const PerfilPage({super.key});

  @override
  State<PerfilPage> createState() {
    return PerfilPageState();
  }
}

class PerfilPageState extends State<PerfilPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Perfil'),
      ),
      drawer: const Drawer(
        child: Navegacao(),
      ),
      body: Container(
        color: const Color.fromARGB(255, 208, 208, 208),
        padding: const EdgeInsets.all(20.0),
        child: CamposAluno(
          aluno: GlobalController.instance.aluno!,
        ),
      ),
    );
  }
}
