import 'package:flutter/material.dart';
import 'package:grade/model/anotacao.dart';
import 'package:intl/intl.dart';

class VisualizacaoAnotacaoCalendario extends StatefulWidget {
  final List<Anotacao> anotacoes;

  const VisualizacaoAnotacaoCalendario({super.key, required this.anotacoes});

  @override
  State<StatefulWidget> createState() {
    return VisualizacaoAnotacaoCalendarioState();
  }
}

class VisualizacaoAnotacaoCalendarioState
    extends State<VisualizacaoAnotacaoCalendario> {
  int _indexAtual = 0;

  String _formataData() {
    var formataoOutput = DateFormat('dd/MM/yyyy');
    return formataoOutput.format(widget.anotacoes[_indexAtual].dataCalendario!);
  }

  @override
  Widget build(BuildContext context) {
    var screenWidth = MediaQuery.of(context).size.width;
    var screenHeight = MediaQuery.of(context).size.height;
    return AlertDialog.adaptive(
      title: Text(widget.anotacoes[_indexAtual].tituloCalendario!),
      content: SizedBox(
        width: screenWidth * 0.9,
        height: screenHeight * 0.3,
        child: ListView(
          children: [
            ListTile(
              title: Text(
                  'Disciplina: ${widget.anotacoes[_indexAtual].disciplina!.nome!}'),
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
                'Conteúdo: ${widget.anotacoes[_indexAtual].conteudo!}',
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
            child: const Text('Fechar')),
        FilledButton(
            style: const ButtonStyle(
                backgroundColor: WidgetStatePropertyAll(Colors.amber)),
            onPressed: _indexAtual == 0
                ? null
                : () {
                    setState(() {
                      _indexAtual--;
                    });
                  },
            child: const Text('Anterior')),
        FilledButton(
            style: const ButtonStyle(
                backgroundColor: WidgetStatePropertyAll(Colors.blue)),
            onPressed: _indexAtual + 1 == widget.anotacoes.length
                ? null
                : () {
                    setState(() {
                      _indexAtual++;
                    });
                  },
            child: const Text('Próximo')),
      ],
    );
  }
}
