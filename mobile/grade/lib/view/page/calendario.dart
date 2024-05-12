import 'package:calendar_view/calendar_view.dart';
import 'package:flutter/material.dart';
import 'package:grade/controller/anotacao_controller.dart';
import 'package:grade/controller/global_controller.dart';
import 'package:grade/view/component/carregando.dart';
import 'package:grade/view/component/container_base.dart';
import 'package:grade/view/component/navegacao.dart';

class CalendarioPage extends StatefulWidget {
  static const rota = '/calendario';

  const CalendarioPage({super.key});

  @override
  State<CalendarioPage> createState() {
    return CalendarioPageState();
  }
}

class CalendarioPageState extends State<CalendarioPage> {
  final AnotacaoController _anotacaoController = AnotacaoController();
  late bool _carregando = true;

  @override
  void initState() {
    super.initState();
    _buscarAnotacoes();
  }

  Future<void> _buscarAnotacoes() async {
    setState(() {
      _carregando = true;
    });
    var anotacoes = await _anotacaoController
        .buscaTodosAlunoCalendario(GlobalController.instance.aluno!.id!);

    CalendarControllerProvider.of(context).controller.removeAll(
        CalendarControllerProvider.of(context).controller.allEvents.toList());
    for (var novaAnotacao in anotacoes) {
      CalendarControllerProvider.of(context).controller.add(CalendarEventData(
          title: novaAnotacao.tituloCalendario!,
          date: novaAnotacao.dataCalendario!,
          description: novaAnotacao.conteudo));
    }
    setState(() {
      _carregando = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Calendário'),
        actions: [
          IconButton(
              onPressed: () => _buscarAnotacoes(),
              icon: const Icon(Icons.update))
        ],
      ),
      drawer: const Drawer(
        child: Navegacao(),
      ),
      body: ContainerBase(
        child: _carregando ? const Carregando() : const MonthView(),
      ),
    );
  }
}
