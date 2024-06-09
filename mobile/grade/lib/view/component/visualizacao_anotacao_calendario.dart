import 'package:flutter/material.dart';
import 'package:grade/model/anotacao.dart';
import 'package:intl/intl.dart';

class VisualizacaoAnotacaoCalendario extends StatelessWidget {
  final Anotacao anotacao;

  const VisualizacaoAnotacaoCalendario({super.key, required this.anotacao});

  String _formataData() {
    var formataoOutput = DateFormat('dd/MM/yyyy');
    return formataoOutput.format(anotacao.dataCalendario!);
  }

  @override
  Widget build(BuildContext context) {
    var screenWidth = MediaQuery.of(context).size.width;
    var screenHeight = MediaQuery.of(context).size.height;
    return AlertDialog.adaptive(
      title: Text(anotacao.tituloCalendario!),
      content: SizedBox(
        width: screenWidth * 0.9,
        height: screenHeight * 0.3,
        child: ListView(
          children: [
            ListTile(
              title: Text('Disciplina: ${anotacao.disciplina!.nome!}'),
            ),
            const SizedBox(
              height: 10.0,
            ),
            ListTile(
              title: Text('Data: ${_formataData()}'),
            ),
            const SizedBox(
              height: 10.0,
            ),
            ListTile(
              title: Text(
                'Conteúdo: ${anotacao.conteudo!}',
                maxLines: 5,
              ),
            ),
          ],
        ),
      ),
      actions: [
        FilledButton(
            style: const ButtonStyle(
                backgroundColor: WidgetStatePropertyAll(Colors.redAccent)),
            onPressed: () => Navigator.pop(context),
            child: const Text('Fechar'))
      ],
    );
  }
}
