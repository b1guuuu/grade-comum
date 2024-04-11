import 'package:flutter/material.dart';
import 'package:grade/view/component/navegacao.dart';

class AnotacaoPage extends StatefulWidget {
  static const rota = '/anotacao';
  const AnotacaoPage({super.key});

  @override
  State<AnotacaoPage> createState() {
    return AnotacaoPageState();
  }
}

class AnotacaoPageState extends State<AnotacaoPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Anotações'),
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
