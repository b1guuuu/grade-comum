import 'package:flutter/material.dart';
import 'package:grade/controller/professor_controller.dart';
import 'package:grade/model/professor.dart';
import 'package:quickalert/models/quickalert_type.dart';
import 'package:quickalert/widgets/quickalert_dialog.dart';

class AdminFormularioProfessor extends StatefulWidget {
  final Professor? professor;

  const AdminFormularioProfessor({super.key, this.professor});

  @override
  State<AdminFormularioProfessor> createState() {
    return AdminFormularioProfessorState();
  }
}

class AdminFormularioProfessorState extends State<AdminFormularioProfessor> {
  final _professorController = ProfessorController();
  final _nomeTxtController = TextEditingController();

  @override
  void initState() {
    super.initState();
    if (widget.professor != null) {
      setState(() {
        _nomeTxtController.text = widget.professor!.nome!;
      });
    }
  }

  Future<void> _salvar() async {
    if (_nomeTxtController.text.trim().isEmpty) {
      throw Exception('O nome não pode ser vazio');
    }
    return widget.professor == null ? _inserir() : _atualizar();
  }

  Future<void> _inserir() async {
    var professor = Professor(id: null, nome: _nomeTxtController.text.trim());
    return _professorController.inserir(professor);
  }

  Future<void> _atualizar() async {
    var professor = Professor(
        id: widget.professor!.id, nome: _nomeTxtController.text.trim());
    return _professorController.atualizar(professor);
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog.adaptive(
      title: const Text('Formulário professor'),
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
                    title: 'Erro ao salvar professor',
                    confirmBtnText: 'Fechar',
                    text: error.toString());
              });
            },
            child: const Text('Salvar'))
      ],
    );
  }
}
