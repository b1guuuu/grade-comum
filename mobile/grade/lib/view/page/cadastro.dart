import 'package:flutter/material.dart';
import 'package:grade/controller/aluno_controller.dart';
import 'package:grade/model/aluno.dart';
import 'package:grade/view/page/inicio.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CadastroPage extends StatefulWidget {
  static const rota = '/cadastro';

  const CadastroPage({super.key});

  @override
  State<CadastroPage> createState() {
    return CadastroPageState();
  }
}

class CadastroPageState extends State<CadastroPage> {
  final AlunoController _alunoController = AlunoController();
  final TextEditingController _nomeController = TextEditingController();
  final TextEditingController _matriculaController = TextEditingController();
  final TextEditingController _senhaController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Efetuar Cadastro'),
      ),
      body: Container(
        color: const Color.fromARGB(255, 208, 208, 208),
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            TextField(
              decoration: const InputDecoration(
                  hintText: 'Nome', border: OutlineInputBorder()),
              controller: _nomeController,
            ),
            const SizedBox(
              height: 10.0,
            ),
            TextField(
              decoration: const InputDecoration(
                  hintText: 'Matrícula', border: OutlineInputBorder()),
              controller: _matriculaController,
            ),
            const SizedBox(
              height: 10.0,
            ),
            TextField(
              decoration: const InputDecoration(
                  hintText: 'Senha', border: OutlineInputBorder()),
              controller: _senhaController,
              obscureText: true,
              enableSuggestions: false,
              autocorrect: false,
            ),
            const SizedBox(
              height: 10.0,
            ),
            FilledButton(
                onPressed: efetuarCadastro, child: const Text('Cadastrar'))
          ],
        ),
      ),
    );
  }

  Future<void> efetuarCadastro() async {
    var aluno = Aluno.cadastro(
        nome: _nomeController.text,
        matricula: _matriculaController.text,
        senha: _senhaController.text);
    aluno = await _alunoController.cadastro(aluno);
    print(aluno.toString());
    final SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setInt('idAluno', aluno.id);

    Navigator.of(context).pushReplacementNamed(InicioPage.rota);
  }
}
