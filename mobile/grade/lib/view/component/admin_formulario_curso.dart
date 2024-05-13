import 'package:flutter/material.dart';
import 'package:grade/controller/curso_controller.dart';
import 'package:grade/model/curso.dart';
import 'package:quickalert/models/quickalert_type.dart';
import 'package:quickalert/widgets/quickalert_dialog.dart';

class AdminFormularioCurso extends StatefulWidget {
  final Curso? curso;

  const AdminFormularioCurso({super.key, this.curso});

  @override
  State<AdminFormularioCurso> createState() {
    return AdminFormularioCursoState();
  }
}

class AdminFormularioCursoState extends State<AdminFormularioCurso> {
  final _cursoController = CursoController();
  final _nomeTxtController = TextEditingController();

  @override
  void initState() {
    super.initState();
    if (widget.curso != null) {
      setState(() {
        _nomeTxtController.text = widget.curso!.nome!;
      });
    }
  }

  Future<void> _salvar() async {
    if (_nomeTxtController.text.trim().isEmpty) {
      throw Exception('O nome não pode ser vazio');
    }
    return widget.curso == null ? _inserir() : _atualizar();
  }

  Future<void> _inserir() async {
    var curso = Curso(id: null, nome: _nomeTxtController.text.trim());
    return _cursoController.inserir(curso);
  }

  Future<void> _atualizar() async {
    var curso =
        Curso(id: widget.curso!.id, nome: _nomeTxtController.text.trim());
    return _cursoController.atualizar(curso);
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog.adaptive(
      title: const Text('Formulário curso'),
      content: SizedBox(
        width: 300,
        height: 50,
        child: TextField(
          decoration: const InputDecoration(
            label: Text('Nome'),
            border: OutlineInputBorder(),
          ),
          controller: _nomeTxtController,
        ),
      ),
      actions: [
        FilledButton(
            style: ButtonStyle(
                backgroundColor:
                    MaterialStatePropertyAll(Color(Colors.red.value))),
            onPressed: () => Navigator.pop(context),
            child: const Text('Voltar')),
        FilledButton(
            style: ButtonStyle(
                backgroundColor:
                    MaterialStatePropertyAll(Color(Colors.green.value))),
            onPressed: () {
              _salvar().then((value) {
                Navigator.pop(context);
              }).catchError((error) {
                QuickAlert.show(
                    context: context,
                    type: QuickAlertType.error,
                    title: 'Erro ao salvar curso',
                    confirmBtnText: 'Fechar',
                    text: error.toString());
              });
            },
            child: const Text('Salvar'))
      ],
    );
  }
}
