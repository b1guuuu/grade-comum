import 'package:flutter/material.dart';
import 'package:grade/view/component/container_base.dart';
import 'package:grade/view/component/navegacao_admin.dart';

class AdminInicioPage extends StatefulWidget {
  static const rota = '/admin';

  const AdminInicioPage({super.key});

  @override
  State<AdminInicioPage> createState() {
    return InicioPageState();
  }
}

class InicioPageState extends State<AdminInicioPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Administrador'),
      ),
      drawer: const Drawer(
        child: NavegacaoAdmin(),
      ),
      body: const ContainerBase(
        child: Center(
          child:
              Text('Utilize a barra de navegação para escolher o que manter.'),
        ),
      ),
    );
  }
}
