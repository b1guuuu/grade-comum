import 'package:flutter/material.dart';
import 'package:grade/view/component/navegacao_admin.dart';

class InicioAdminPage extends StatefulWidget {
  static const rota = '/admin';

  const InicioAdminPage({super.key});

  @override
  State<InicioAdminPage> createState() {
    return InicioPageState();
  }
}

class InicioPageState extends State<InicioAdminPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Administrador'),
      ),
      drawer: const Drawer(
        child: NavegacaoAdmin(),
      ),
      body: Container(
        color: const Color.fromARGB(255, 208, 208, 208),
        padding: const EdgeInsets.all(5.0),
        child: const Center(
          child:
              Text('Utilize a barra de navegação para escolher o que manter.'),
        ),
      ),
    );
  }
}
