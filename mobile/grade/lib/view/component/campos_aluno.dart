import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:grade/controller/aluno_controller.dart';
import 'package:grade/controller/curso_controller.dart';
import 'package:grade/controller/global_controller.dart';
import 'package:grade/model/aluno.dart';
import 'package:grade/model/curso.dart';
import 'package:grade/view/page/inicio.dart';
import 'package:quickalert/quickalert.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CamposAluno extends StatefulWidget {
  final Aluno? aluno;

  const CamposAluno({super.key, this.aluno});

  @override
  State<CamposAluno> createState() {
    return CamposAlunoState();
  }
}

class CamposAlunoState extends State<CamposAluno> {
  final _formCamposAluno = GlobalKey<FormState>();
  final AlunoController _alunoController = AlunoController();
  final CursoController _cursoController = CursoController();
  final TextEditingController _nomeController = TextEditingController();
  final TextEditingController _matriculaController = TextEditingController();
  final TextEditingController _senhaController = TextEditingController();
  final TextEditingController _confirmaSenhaController =
      TextEditingController();

  List<Curso> _cursos = [];
  Curso? _cursoSelecionado;

  @override
  void initState() {
    super.initState();

    _carregaCursos().then((value) {
      if (widget.aluno != null) {
        setState(() {
          _nomeController.text = widget.aluno!.nome!;
          _matriculaController.text = widget.aluno!.matricula!;
          _cursoSelecionado = _cursos
              .firstWhere((curso) => curso.id! == widget.aluno!.idCurso!);
        });
      }
    });
  }

  Future<void> _carregaCursos() async {
    var temp = await _cursoController.listar();
    setState(() {
      _cursos = temp;
      _cursoSelecionado = temp.first;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Form(
        key: _formCamposAluno,
        child: Column(
          children: [
            TextFormField(
              validator: (value) {
                if (value == null || value.isEmpty) return "Informe o nome";
                return null;
              },
              decoration: const InputDecoration(
                  hintText: 'Nome',
                  border: OutlineInputBorder(),
                  label: Text('Nome')),
              controller: _nomeController,
              readOnly: widget.aluno != null,
            ),
            const SizedBox(
              height: 10.0,
            ),
            TextFormField(
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return "Informe a matrícula";
                }
                return null;
              },
              decoration: const InputDecoration(
                  hintText: 'Matrícula',
                  border: OutlineInputBorder(),
                  label: Text('Matrícula')),
              controller: _matriculaController,
              readOnly: widget.aluno != null,
            ),
            const SizedBox(
              height: 10.0,
            ),
            TextFormField(
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return "Informe uma senha";
                }
                return null;
              },
              decoration: const InputDecoration(
                  hintText: 'Senha',
                  border: OutlineInputBorder(),
                  label: Text('Senha')),
              controller: _senhaController,
              obscureText: true,
              enableSuggestions: false,
              autocorrect: false,
            ),
            const SizedBox(
              height: 10.0,
            ),
            TextFormField(
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return "Confirme a senha";
                }
                if (value != _senhaController.text) {
                  return "As senhas não são iguais";
                }
                return null;
              },
              decoration: const InputDecoration(
                  hintText: 'Confirmar senha',
                  border: OutlineInputBorder(),
                  label: Text('Confirmar senha')),
              controller: _confirmaSenhaController,
              obscureText: true,
              enableSuggestions: false,
              autocorrect: false,
            ),
            const SizedBox(
              height: 10.0,
            ),
            DropdownButtonFormField(
              items: _cursos
                  .map((curso) => DropdownMenuItem(
                        value: curso,
                        child: Text(curso.nome!),
                        enabled: widget.aluno != null,
                      ))
                  .toList(),
              onChanged: (value) => setState(() {
                _cursoSelecionado = value;
              }),
              value: _cursoSelecionado,
            ),
            const SizedBox(
              height: 10.0,
            ),
            widget.aluno == null
                ? FilledButton(
                    onPressed: () => _efetuarCadastro(),
                    child: const Text('Cadastrar'))
                : FilledButton(
                    onPressed: () => _atualizaDadosAluno(),
                    child: const Text('Atualizar'))
          ],
        ));
  }

  bool _validaDados() {
    return _nomeController.text.isNotEmpty &&
        _matriculaController.text.isNotEmpty &&
        _senhaController.text.isNotEmpty &&
        _confirmaSenhaController.text.isNotEmpty &&
        _senhaController.text == _confirmaSenhaController.text;
  }

  Future<void> _efetuarCadastro() async {
    if (_validaDados()) {
      var aluno = Aluno.cadastro(
          nome: _nomeController.text,
          matricula: _matriculaController.text,
          senha: _senhaController.text,
          idCurso: _cursoSelecionado!.id);
      try {
        aluno = await _alunoController.cadastro(aluno);
        final SharedPreferences preferences =
            await SharedPreferences.getInstance();
        preferences.setString('aluno', jsonEncode(aluno.toMap()));
        GlobalController.instance.setAluno(aluno);
        Navigator.of(context).pushReplacementNamed(InicioPage.rota);
      } catch (e) {
        QuickAlert.show(
            context: context,
            type: QuickAlertType.error,
            title: 'Erro de cadastro',
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

  Future<void> _atualizaDadosAluno() async {
    if (_validaDados()) {
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
