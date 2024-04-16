import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:grade/controller/aluno_controller.dart';
import 'package:grade/controller/global_controller.dart';
import 'package:grade/model/aluno.dart';
import 'package:grade/view/component/campos_aluno.dart';
import 'package:grade/view/component/carregando.dart';
import 'package:grade/view/component/navegacao.dart';
import 'package:quickalert/models/quickalert_type.dart';
import 'package:quickalert/widgets/quickalert_dialog.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PerfilPage extends StatefulWidget {
  static const rota = '/perfil';

  const PerfilPage({super.key});

  @override
  State<PerfilPage> createState() {
    return PerfilPageState();
  }
}

class PerfilPageState extends State<PerfilPage> {
  final AlunoController _alunoController = AlunoController();
  late TextEditingController _nomeController;
  late TextEditingController _matriculaController;
  final TextEditingController _senhaController = TextEditingController();
  final TextEditingController _confirmaSenhaController =
      TextEditingController();

  bool _carregando = true;

  @override
  void initState() {
    super.initState();
    _carregaDadosAluno();
  }

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
        child: _carregando
            ? const Carregando()
            : Column(
                children: [
                  CamposAluno(
                      nomeController: _nomeController,
                      matriculaController: _matriculaController,
                      senhaController: _senhaController,
                      confirmaSenhaController: _confirmaSenhaController),
                  FilledButton(
                      onPressed: _atualizaDadosAluno,
                      child: const Text('Atualizar'))
                ],
              ),
      ),
    );
  }

  Future<void> _carregaDadosAluno() async {
    setState(() {
      _carregando = true;
    });
    setState(() {
      _nomeController = TextEditingController.fromValue(
          TextEditingValue(text: GlobalController.instance.aluno!.nome!));
      _matriculaController = TextEditingController.fromValue(
          TextEditingValue(text: GlobalController.instance.aluno!.matricula!));
      _carregando = false;
    });
  }

  Future<void> _atualizaDadosAluno() async {
    if (_nomeController.text.isNotEmpty &&
        _matriculaController.text.isNotEmpty &&
        _senhaController.text.isNotEmpty &&
        _confirmaSenhaController.text.isNotEmpty &&
        _senhaController.text == _confirmaSenhaController.text) {
      try {
        var aluno = Aluno(
            id: GlobalController.instance.aluno!.id,
            nome: _nomeController.text,
            matricula: _matriculaController.text,
            senha: _senhaController.text);
        await _alunoController.atualiza(aluno);
        final SharedPreferences preferences =
            await SharedPreferences.getInstance();
        aluno.senha = '';
        preferences.setString('aluno', jsonEncode(aluno.toMap()));
        GlobalController.instance.setAluno(aluno);
        setState(() {
          _senhaController.clear();
          _confirmaSenhaController.clear();
        });
        QuickAlert.show(
            context: context,
            type: QuickAlertType.success,
            title: 'Atualização feita com sucesso',
            confirmBtnText: "Fechar");
      } catch (e) {
        QuickAlert.show(
            context: context,
            type: QuickAlertType.error,
            title: 'Erro ao atualizar dados',
            text: e.toString(),
            confirmBtnText: "Fechar");
      }
    } else {
      QuickAlert.show(
          context: context,
          type: QuickAlertType.error,
          title: 'Campos inválido',
          text: 'Verifique as informações inseridas',
          confirmBtnText: "Fechar");
    }
  }
}
