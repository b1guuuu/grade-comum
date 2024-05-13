import 'package:flutter/material.dart';
import 'package:grade/view/component/container_base.dart';
import 'package:grade/view/component/navegacao.dart';

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
    return Scaffold(
      appBar: AppBar(
        title: const Text('Inicio'),
      ),
      drawer: const Drawer(
        child: Navegacao(),
      ),
      body: const ContainerBase(
        child: Center(
          child: Text('Inicio'),
        ),
      ),
    );
  }
}
