import 'package:flutter/material.dart';
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
      body: Container(
        color: const Color.fromARGB(255, 208, 208, 208),
        padding: const EdgeInsets.all(20.0),
        child: const Center(
          child: Text('Inicio'),
        ),
      ),
    );
  }
}
