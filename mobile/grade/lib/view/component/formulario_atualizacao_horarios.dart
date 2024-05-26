import 'package:flutter/material.dart';
import 'package:grade/controller/horario_controller.dart';
import 'package:grade/model/horario.dart';
import 'package:grade/model/turma.dart';
import 'package:grade/view/component/carregando.dart';
import 'package:quickalert/models/quickalert_type.dart';
import 'package:quickalert/widgets/quickalert_dialog.dart';

class FormularioAtualizacaoHorarios extends StatefulWidget {
  final Turma turma;

  const FormularioAtualizacaoHorarios({super.key, required this.turma});

  @override
  State<FormularioAtualizacaoHorarios> createState() {
    return FormularioAtualizacaoHorariosState();
  }
}

class FormularioAtualizacaoHorariosState
    extends State<FormularioAtualizacaoHorarios> {
  final _horarioController = HorarioController();
  final _dia1TxtController = TextEditingController();
  final _dia2TxtController = TextEditingController();
  final _diasSemana = [
    'Segunda-feira',
    'Terça-feira',
    'Quarta-feira',
    'Quinta-feira',
    'Sexta-feira'
  ];

  String _dia1 = '';
  String _dia2 = '';
  List<Horario> _horarios = [];
  bool _carregando = true;

  @override
  void initState() {
    super.initState();
    _buscaHorarios();
  }

  Future<void> _buscaHorarios() async {
    setState(() {
      _carregando = true;
    });
    var temp = await _horarioController.buscaHorariosPorTurma(widget.turma.id!);
    setState(() {
      _horarios = temp;
    });
    _defineDias();
  }

  void _defineDias() {
    setState(() {
      _dia1TxtController.text = _horarios[0].sala;
      _dia2TxtController.text = _horarios[_horarios.length - 1].sala;
      _dia1 = _diasSemana[_horarios[0].diaSemana];
      _dia2 = _diasSemana[_horarios[_horarios.length - 1].diaSemana];
      _carregando = false;
    });
  }

  Future<void> _atualizarHorarios() async {
    try {
      List<Horario> horariosAtualizados = [];
      for (var horario in _horarios) {
        if (horario.diaSemana == _horarios[0].diaSemana) {
          horario.sala = _dia1TxtController.value.text;
        } else {
          horario.sala = _dia2TxtController.value.text;
        }
        horariosAtualizados.add(horario);
      }
      await _horarioController.atualizaHorariosTurma(horariosAtualizados);
      Navigator.of(context).pop();
    } catch (e) {
      QuickAlert.show(
          context: context,
          type: QuickAlertType.error,
          title: 'Erro ao atualizar salas',
          confirmBtnText: 'Fechar',
          text: e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog.adaptive(
      title: const Text('Formulário salas'),
      content: SizedBox(
        width: MediaQuery.of(context).size.width * 0.9,
        height: MediaQuery.of(context).size.width * 0.8,
        child: _carregando
            ? const Carregando()
            : ListView(
                children: [
                  TextField(
                    decoration: InputDecoration(
                        label: Text(_dia1),
                        border: const OutlineInputBorder(),
                        hintText: '303A'),
                    controller: _dia1TxtController,
                  ),
                  const SizedBox(
                    height: 10.0,
                  ),
                  TextField(
                    decoration: InputDecoration(
                        label: Text(_dia2),
                        border: const OutlineInputBorder(),
                        hintText: '303B'),
                    controller: _dia2TxtController,
                  ),
                ],
              ),
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
            onPressed: () {
              _atualizarHorarios();
            },
            child: const Text('Salvar'))
      ],
    );
  }
}
