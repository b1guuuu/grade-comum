import 'package:flutter/material.dart';
import 'package:grade/controller/global_controller.dart';
import 'package:grade/controller/progresso_controller.dart';
import 'package:grade/model/disciplina.dart';
import 'package:grade/model/progresso.dart';
import 'package:grade/view/component/carregando.dart';
import 'package:multiselect/multiselect.dart';
import 'package:quickalert/models/quickalert_type.dart';
import 'package:quickalert/widgets/quickalert_dialog.dart';

class FormularioDisciplinasCursadas extends StatefulWidget {
  final List<Disciplina> disciplinas;
  final List<Progresso> progressos;

  const FormularioDisciplinasCursadas(
      {super.key, required this.disciplinas, required this.progressos});

  @override
  State<FormularioDisciplinasCursadas> createState() {
    return FormularioDisciplinasCursadasState();
  }
}

class FormularioDisciplinasCursadasState
    extends State<FormularioDisciplinasCursadas> {
  final _progressoController = ProgressoController();
  List<Disciplina> _disciplinasSelecionadasOriginal = [];
  List<Disciplina> _disciplinasSelecionadas = [];
  bool _carregando = true;

  @override
  void initState() {
    super.initState();

    _defineDisciplinas();
  }

  void _defineDisciplinas() {
    var disciplinasAtualmenteCompletas = widget.disciplinas
        .where((disciplina) => widget.progressos.any((progresso) =>
            progresso.concluido && progresso.idDisciplina == disciplina.id))
        .toList();
    setState(() {
      _disciplinasSelecionadas = [...disciplinasAtualmenteCompletas];
      _disciplinasSelecionadasOriginal = [...disciplinasAtualmenteCompletas];
      _carregando = false;
    });
  }

  Future<dynamic> _solicitarConfirmacao() async {
    List<Disciplina> disciplinasParaInserir = _disciplinasSelecionadas
        .where((disciplinaSelecionada) =>
            !_disciplinasSelecionadasOriginal.contains(disciplinaSelecionada))
        .toList();

    var disciplinasParaInserirStr = disciplinasParaInserir.fold(
        '', (anterior, element) => '$anterior,${element.nome}');

    List<Disciplina> disciplinasParaExcluir = _disciplinasSelecionadasOriginal
        .where((disciplina) => !_disciplinasSelecionadas.contains(disciplina))
        .toList();

    var disciplinasParaExcluirStr = disciplinasParaExcluir.fold(
        '', (anterior, element) => '$anterior,${element.nome}');
    if (disciplinasParaExcluirStr.trim().isNotEmpty) {
      disciplinasParaExcluirStr = disciplinasParaExcluirStr.substring(1);
    }
    if (disciplinasParaInserirStr.trim().isNotEmpty) {
      disciplinasParaInserirStr = disciplinasParaInserirStr.substring(1);
    }
    return QuickAlert.show(
      context: context,
      type: QuickAlertType.confirm,
      cancelBtnText: 'Voltar',
      confirmBtnColor: Colors.greenAccent,
      confirmBtnText: 'Confirmar',
      onCancelBtnTap: () => Navigator.of(context).pop(false),
      onConfirmBtnTap: () =>
          _salvarProgressos(disciplinasParaInserir, disciplinasParaExcluir),
      title: 'Confirmação de Atualização de Disciplinas',
      text:
          'Disciplinas Para Excluir: $disciplinasParaExcluirStr\n\nDisciplinas Para Inserir: $disciplinasParaInserirStr',
    );
  }

  Future<void> _salvarProgressos(List<Disciplina> disciplinasParaInserir,
      List<Disciplina> disciplinasParaExcluir) async {
    List<Map<String, dynamic>> atualizacoes = [];
    for (var disciplina in disciplinasParaInserir) {
      var atualizacao = {"acao": "inserir", "idDisciplina": disciplina.id};
      atualizacoes.add(atualizacao);
    }

    for (var disciplina in disciplinasParaExcluir) {
      var atualizacao = {"acao": "excluir", "idDisciplina": disciplina.id};
      atualizacoes.add(atualizacao);
    }

    await _progressoController.atualizarHistorico(
        atualizacoes, GlobalController.instance.aluno!.id!);

    Navigator.of(context).pop(true);
  }

  @override
  Widget build(BuildContext context) {
    var screenWidth = MediaQuery.of(context).size.width;
    var screenHeight = MediaQuery.of(context).size.height;
    var optionContainerWidth = (screenWidth * 0.9) - 100;
    var optionTextWidth = optionContainerWidth - 100;

    return AlertDialog.adaptive(
      title: const Text('Atualização de Disciplinas'),
      content: SizedBox(
        height: screenHeight * 0.8,
        width: screenWidth * 0.9,
        child: _carregando
            ? const Carregando()
            : InteractiveViewer(
                child: DropDownMultiSelect(
                options: widget.disciplinas,
                selectedValues: _disciplinasSelecionadas,
                menuItembuilder: (option) => SizedBox(
                    width: optionContainerWidth,
                    child: Row(
                      children: [
                        Checkbox.adaptive(
                            value: _disciplinasSelecionadas.contains(option),
                            onChanged: null),
                        SizedBox(
                            width: optionTextWidth,
                            child: Text(
                                '${option.periodo}° período - ${option.nome!}')),
                      ],
                    )),
                childBuilder: (selectedValues) => Text(
                    ' ${_disciplinasSelecionadas.length} disciplinas selecionadas'),
                onChanged: (p0) => setState(() {
                  _disciplinasSelecionadas = p0;
                }),
              )),
      ),
      actions: [
        FilledButton(
            style: const ButtonStyle(
                backgroundColor: WidgetStatePropertyAll(Colors.red)),
            onPressed: () => Navigator.pop(context),
            child: const Text('Voltar')),
        FilledButton(
            style: const ButtonStyle(
                backgroundColor: WidgetStatePropertyAll(Colors.green)),
            onPressed: () async {
              var alteracoesSalvas = await _solicitarConfirmacao();
              if (alteracoesSalvas) {
                Navigator.of(context).pop();
              }
            },
            child: const Text('Salvar'))
      ],
    );
  }
}
