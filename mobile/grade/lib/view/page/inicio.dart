import 'package:flutter/material.dart';
import 'package:grade/view/component/container_base.dart';
import 'package:grade/view/component/listagem_presenca_professores.dart';
import 'package:grade/view/component/my_container.dart';
import 'package:grade/view/component/navegacao.dart';
import 'package:grade/view/component/tabela_grade.dart';

class InicioPage extends StatefulWidget {
  static const rota = '/inicio';

  const InicioPage({super.key});

  @override
  State<InicioPage> createState() {
    return InicioPageState();
  }
}

class InicioPageState extends State<InicioPage> {
  @override
  Widget build(BuildContext context) {
    var screenWidth = MediaQuery.of(context).size.width;
    var screenHeight = MediaQuery.of(context).size.height;
    var mainContainerWidth = screenWidth > 1050 ? 1050.0 : screenWidth * 0.9;
    var mainContainerHeight =
        mainContainerWidth == 1050.0 ? 320.0 : screenHeight * 0.9;

    var contentContainerWidth = mainContainerWidth * 0.9;
    var contentContainerHeight = mainContainerHeight * 0.9;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Inicio'),
      ),
      drawer: const Drawer(
        child: Navegacao(),
      ),
      body: ContainerBase(
          child: Center(
        child: MyContainer(
            mainContainerWidth: mainContainerWidth,
            mainContainerHeight: mainContainerHeight,
            contentContainerWidth: contentContainerWidth,
            contentContainerHeight: contentContainerHeight,
            child: mainContainerWidth == 1050.0
                ? Row(
                    children: [
                      SizedBox(
                        width: contentContainerWidth * 0.49,
                        child: const TabelaGrade(visualizacaoSemanal: false),
                      ),
                      const SizedBox(
                        width: 10.0,
                      ),
                      SizedBox(
                        width: contentContainerWidth * 0.49,
                        child: const ListagemPresencaProfessores(),
                      ),
                    ],
                  )
                : Column(children: [
                    SizedBox(
                      height: contentContainerHeight * 0.49,
                      width: contentContainerWidth - 10,
                      child: const TabelaGrade(visualizacaoSemanal: false),
                    ),
                    const SizedBox(
                      height: 10.0,
                    ),
                    SizedBox(
                      height: contentContainerHeight * 0.49,
                      width: contentContainerWidth - 10,
                      child: const ListagemPresencaProfessores(),
                    ),
                  ])),
      )),
    );
  }
}
