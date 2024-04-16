import 'package:calendar_view/calendar_view.dart';
import 'package:flutter/material.dart';
import 'package:grade/controller/anotacao_controller.dart';
import 'package:grade/controller/global_controller.dart';
import 'package:grade/view/component/carregando.dart';
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

    var eventosCalendario =
        CalendarControllerProvider.of(context).controller.allEvents;

    if (anotacoes.length > eventosCalendario.length) {
      var anotacoesNaoInseridas = anotacoes
          .where((anotacao) =>
              eventosCalendario.indexWhere(
                  (evento) => evento.title == anotacao.tituloCalendario!) ==
              -1)
          .toList();
      for (var novaAnotacao in anotacoesNaoInseridas) {
        CalendarControllerProvider.of(context).controller.add(CalendarEventData(
            title: novaAnotacao.tituloCalendario!,
            date: novaAnotacao.dataCalendario!,
            description: novaAnotacao.conteudo));
      }
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
      ),
      drawer: const Drawer(
        child: Navegacao(),
      ),
      body: Container(
        color: const Color.fromARGB(255, 208, 208, 208),
        padding: const EdgeInsets.all(5.0),
        child: _carregando ? const Carregando() : const MonthView(),
      ),
    );
  }
}
