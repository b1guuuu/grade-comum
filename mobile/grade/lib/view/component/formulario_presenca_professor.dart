import 'package:flutter/material.dart';
import 'package:grade/controller/presenca_controller.dart';
import 'package:grade/controller/professor_controller.dart';
import 'package:grade/model/presenca.dart';
import 'package:grade/model/professor.dart';
import 'package:quickalert/models/quickalert_type.dart';
import 'package:quickalert/widgets/quickalert_dialog.dart';

class FormularioPresencaProfessor extends StatefulWidget {
  final Presenca presenca;

  const FormularioPresencaProfessor({super.key, required this.presenca});

  @override
  State<FormularioPresencaProfessor> createState() {
    return FormularioPresencaProfessorState();
  }
}

class FormularioPresencaProfessorState
    extends State<FormularioPresencaProfessor> {
  final _presencaController = PresencaController();
  final _observacaoTxtController = TextEditingController();
  bool? _presente = true;

  @override
  void initState() {
    super.initState();
    setState(() {
      _presente = widget.presenca.presente;
      _observacaoTxtController.text = widget.presenca.observacao;
    });
  }

  Future<void> _salvar() async {
    var presenca = widget.presenca;
    presenca.presente = _presente!;
    presenca.observacao = _observacaoTxtController.text;
    presenca.ultimaAtualizacao = DateTime.now();
    return _presencaController.atualizar(presenca);
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog.adaptive(
      title: const Text('Formulário presença'),
      content: SizedBox(
        width: MediaQuery.of(context).size.width * 0.9,
        height: MediaQuery.of(context).size.height * 0.35,
        child: ListView(
          children: [
            TextField(
              decoration: const InputDecoration(
                label: Text('Nome'),
                border: OutlineInputBorder(),
              ),
              readOnly: true,
              controller: TextEditingController.fromValue(
                  TextEditingValue(text: widget.presenca.professor!.nome)),
            ),
            const SizedBox(
              height: 10.0,
            ),
            TextField(
              decoration: const InputDecoration(
                label: Text('Observação'),
                border: OutlineInputBorder(),
              ),
              controller: _observacaoTxtController,
              maxLines: 3,
            ),
            const SizedBox(
              height: 10.0,
            ),
            CheckboxListTile.adaptive(
              value: _presente,
              title: const Text('Presente'),
              controlAffinity: ListTileControlAffinity.leading,
              onChanged: (isChecked) {
                setState(() {
                  _presente = isChecked;
                });
              },
            ),
          ],
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
                    title: 'Erro ao salvar presença',
                    confirmBtnText: 'Fechar',
                    text: error.toString());
              });
            },
            child: const Text('Salvar'))
      ],
    );
  }
}
