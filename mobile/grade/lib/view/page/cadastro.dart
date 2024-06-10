import 'package:flutter/material.dart';
import 'package:grade/view/component/campos_aluno.dart';
import 'package:grade/view/component/container_base.dart';
import 'package:grade/view/component/my_container.dart';

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
    var screenWidth = MediaQuery.of(context).size.width;
    var screenHeight = MediaQuery.of(context).size.height;
    var mainContainerHeight =
        screenHeight * 0.6 < 600.0 ? screenHeight * 0.6 : 600.0;
    var mainContainerWidth =
        screenWidth * 0.8 > 400.0 ? 400.0 : screenWidth * 0.8;
    var contentContainerWidth = mainContainerWidth * 0.8;
    var contentContainerHeight = mainContainerHeight * 0.9;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Efetuar Cadastro'),
      ),
      body: ContainerBase(
        child: Center(
          child: MyContainer(
            mainContainerHeight: mainContainerHeight,
            mainContainerWidth: mainContainerWidth,
            contentContainerWidth: contentContainerWidth,
            contentContainerHeight: contentContainerHeight,
            child: const CamposAluno(
              aluno: null,
            ),
          ),
        ),
      ),
    );
  }
}
