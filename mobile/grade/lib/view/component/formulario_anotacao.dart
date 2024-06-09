import 'package:flutter/material.dart';
import 'package:grade/controller/anotacao_controller.dart';
import 'package:grade/controller/global_controller.dart';
import 'package:grade/model/anotacao.dart';
import 'package:intl/intl.dart';
import 'package:quickalert/models/quickalert_type.dart';
import 'package:quickalert/widgets/quickalert_dialog.dart';

class FormularioAnotacao extends StatefulWidget {
  final int idDisciplina;
  final Anotacao? anotacao;

  const FormularioAnotacao(
      {super.key, required this.idDisciplina, required this.anotacao});

  @override
  State<FormularioAnotacao> createState() {
    return FormularioAnotacaoState();
  }
}

class FormularioAnotacaoState extends State<FormularioAnotacao> {
  final TextEditingController _conteudoTxtController = TextEditingController();
  final TextEditingController _tituloCalendarioTxtController =
      TextEditingController();
  final TextEditingController _dataCalendarioTxtController =
      TextEditingController();
  final AnotacaoController _anotacaoController = AnotacaoController();

  bool _adicionarAoCalendario = false;
  DateTime? _dataCalendario;

  @override
  void initState() {
    super.initState();
    _inicializarCampos();
  }

  void _inicializarCampos() {
    if (widget.anotacao != null) {
      setState(() {
        _conteudoTxtController.text = widget.anotacao!.conteudo!;
        if (widget.anotacao!.dataCalendario != null &&
            widget.anotacao!.tituloCalendario != null) {
          _tituloCalendarioTxtController.text =
              widget.anotacao!.tituloCalendario!;
          var formatacaoInicial = DateFormat('yyyy-MM-dd HH:mm');
          var inputDate = formatacaoInicial
              .parse(widget.anotacao!.dataCalendario!.toLocal().toString());
          var formataoOutput = DateFormat('dd/MM/yyyy');

          _dataCalendario = widget.anotacao!.dataCalendario;
          _dataCalendarioTxtController.text = formataoOutput.format(inputDate);
          _adicionarAoCalendario = true;
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog.adaptive(
      title: const Text('Nova anotação'),
      content: SizedBox(
        height: _adicionarAoCalendario ? 330 : 130,
        child: Column(
          children: [
            TextField(
              decoration: const InputDecoration(
                  hintText: 'O que você gostaria de lembrar',
                  border: OutlineInputBorder(),
                  label: Text('Conteúdo')),
              controller: _conteudoTxtController,
            ),
            const SizedBox(
              height: 10.0,
            ),
            Row(
              children: [
                const Text('Adicionar ao calendário?'),
                const SizedBox(
                  width: 50,
                ),
                Switch(
                    value: _adicionarAoCalendario,
                    onChanged: (newValue) => {
                          setState(() {
                            _adicionarAoCalendario = newValue;
                            _dataCalendario = null;
                            _dataCalendarioTxtController.clear();
                          })
                        })
              ],
            ),
            _adicionarAoCalendario
                ? Column(
                    children: [
                      const SizedBox(
                        height: 10.0,
                      ),
                      TextField(
                        decoration: const InputDecoration(
                            hintText: 'Título no calendário',
                            border: OutlineInputBorder(),
                            label: Text('Título calendário')),
                        controller: _tituloCalendarioTxtController,
                        maxLength: 20,
                      ),
                    ],
                  )
                : const SizedBox(
                    height: 0,
                  ),
            _adicionarAoCalendario
                ? Column(
                    children: [
                      const SizedBox(
                        height: 10.0,
                      ),
                      Row(
                        children: [
                          SizedBox(
                            width: 230,
                            child: TextField(
                              decoration: const InputDecoration(
                                  border: OutlineInputBorder(),
                                  hintText:
                                      'Clique no botão ao lado para selecionar a data',
                                  label: Text('Data')),
                              controller: _dataCalendarioTxtController,
                              readOnly: true,
                            ),
                          ),
                          const SizedBox(
                            width: 5,
                          ),
                          IconButton.filled(
                              onPressed: () async =>
                                  {await _selecionarDataCalendario(context)},
                              icon: const Icon(Icons.calendar_today))
                        ],
                      ),
                    ],
                  )
                : const SizedBox(
                    height: 0,
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
              _salvarAnotacao().then((value) {
                Navigator.pop(context);
              }).catchError((error) {
                QuickAlert.show(
                    context: context,
                    type: QuickAlertType.error,
                    title: 'Erro ao salvar anotação',
                    confirmBtnText: 'Fechar',
                    text: error.toString());
              });
            },
            child: const Text('Salvar'))
      ],
    );
  }

  bool _validarAnotacao() {
    if (_conteudoTxtController.text.trim().isEmpty) return false;
    if (_adicionarAoCalendario) {
      if (_tituloCalendarioTxtController.text.trim().isEmpty ||
          (_dataCalendario == null)) return false;
    }
    return true;
  }

  Future<void> _salvarAnotacao() async {
    if (_validarAnotacao()) {
      Anotacao anotacao = Anotacao.calendario(
          conteudo: _conteudoTxtController.text.trim(),
          dataCalendario: _dataCalendario,
          tituloCalendario: _tituloCalendarioTxtController.text.trim(),
          idAluno: GlobalController.instance.aluno!.id!,
          idDisciplina: widget.idDisciplina);
      if (widget.anotacao != null) {
        anotacao.id = widget.anotacao!.id;
        return _anotacaoController.atualiza(anotacao);
      } else {
        return _anotacaoController.salvaAnotacao(anotacao);
      }
    } else {
      throw Exception('Dados inválidos');
    }
  }

  Future<void> _selecionarDataCalendario(BuildContext context) async {
    var hoje = DateTime.now();
    var primeiroDiaAno = DateTime(hoje.year);
    var ultimoDiaAno = DateTime(primeiroDiaAno.year, 12, 31);
    var dataSelecionada = await showDatePicker(
        context: context, firstDate: primeiroDiaAno, lastDate: ultimoDiaAno);
    if (dataSelecionada != null) {
      var formatacaoInicial = DateFormat('yyyy-MM-dd HH:mm');
      var inputDate =
          formatacaoInicial.parse(dataSelecionada.toLocal().toString());
      var formataoOutput = DateFormat('dd/MM/yyyy');
      setState(() {
        _dataCalendario = dataSelecionada;
        _dataCalendarioTxtController.text = formataoOutput.format(inputDate);
      });
    }
  }
}
