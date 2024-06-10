import 'package:flutter/material.dart';
import 'package:grade/controller/global_controller.dart';
import 'package:grade/view/component/campos_aluno.dart';
import 'package:grade/view/component/container_base.dart';
import 'package:grade/view/component/my_container.dart';
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
        title: const Text('Perfil'),
      ),
      drawer: const Drawer(
        child: Navegacao(),
      ),
      body: ContainerBase(
        child: Center(
          child: MyContainer(
            mainContainerHeight: mainContainerHeight,
            mainContainerWidth: mainContainerWidth,
            contentContainerWidth: contentContainerWidth,
            contentContainerHeight: contentContainerHeight,
            child: CamposAluno(
              aluno: GlobalController.instance.aluno!,
            ),
          ),
        ),
      ),
    );
  }
}
