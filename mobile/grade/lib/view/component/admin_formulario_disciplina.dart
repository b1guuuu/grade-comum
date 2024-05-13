import 'package:flutter/material.dart';
import 'package:grade/controller/curso_controller.dart';
import 'package:grade/controller/disciplina_controller.dart';
import 'package:grade/model/curso.dart';
import 'package:grade/model/disciplina.dart';
import 'package:grade/view/component/carregando.dart';
import 'package:quickalert/models/quickalert_type.dart';
import 'package:quickalert/widgets/quickalert_dialog.dart';

class AdminFormularioDisciplina extends StatefulWidget {
  const AdminFormularioDisciplina({super.key});
  @override
  State<StatefulWidget> createState() {
    return AdminFormularioDisciplinaState();
  }
}

class AdminFormularioDisciplinaState extends State<AdminFormularioDisciplina> {
  final _cursoController = CursoController();
  final _disciplinaController = DisciplinaController();
  final _nomeTxtController = TextEditingController();
  final _periodoTxtController = TextEditingController();
  final List<Disciplina> _requisitos = [];
  List<Curso> _cursos = [];
  List<Disciplina> _disciplinas = [];
  bool _carregandoCursos = true;
  bool _carregandoDisciplinas = false;
  int? _idCurso;

  @override
  void initState() {
    super.initState();
    _buscaCursos();
  }

  Future<void> _buscaCursos() async {
    setState(() {
      _carregandoCursos = true;
    });
    var cursos = await _cursoController.listar();
    setState(() {
      _cursos = cursos;
      _carregandoCursos = false;
    });
  }

  Future<void> _buscaDisciplinas() async {
    setState(() {
      _carregandoDisciplinas = true;
    });
    var disciplinas = await _disciplinaController.listarPorCurso(_idCurso!);
    setState(() {
      _disciplinas = disciplinas;
      _carregandoDisciplinas = false;
    });
  }

  void _selecionaCurso(int? id) {
    setState(() {
      _idCurso = id;
    });
    _buscaDisciplinas();
  }

  void _atualizaRequisitos(Disciplina disciplina, bool? isChecked) {
    setState(() {
      if (isChecked!) {
        _requisitos.add(disciplina);
      } else {
        _requisitos.remove(disciplina);
      }
    });
  }

  Future<void> _salvar() async {
    if (_nomeTxtController.text.isEmpty) {
      throw Exception('Nome é um campo obrigatório');
    }
    if (_periodoTxtController.text.isEmpty) {
      throw Exception('Período é um campo obrigatório');
    }
    if (_idCurso == null) {
      throw Exception('Seleciona um curso');
    }
    try {
      int.parse(_periodoTxtController.text);
    } catch (e) {
      throw Exception('Período está com um valor inválido');
    }
    var disciplina = Disciplina.cadastro(
        nome: _nomeTxtController.text,
        periodo: int.parse(_periodoTxtController.text),
        idCurso: _idCurso,
        requisitos: _requisitos);
    return _disciplinaController.inserir(disciplina);
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog.adaptive(
        title: const Text('Formulário disciplina'),
        content: SizedBox(
          height: MediaQuery.of(context).size.height - 100,
          width: MediaQuery.of(context).size.width - 100,
          child: ListView(
            children: [
              TextField(
                decoration: const InputDecoration(
                  label: Text('Nome'),
                  border: OutlineInputBorder(),
                ),
                controller: _nomeTxtController,
              ),
              const SizedBox(
                height: 10.0,
              ),
              TextField(
                decoration: const InputDecoration(
                  label: Text('Período'),
                  border: OutlineInputBorder(),
                ),
                controller: _periodoTxtController,
                keyboardType: TextInputType.number,
              ),
              const SizedBox(
                height: 10.0,
              ),
              _carregandoCursos
                  ? const Carregando()
                  : DropdownButtonFormField(
                      value: _idCurso,
                      decoration: const InputDecoration(
                        label: Text('Curso'),
                        border: OutlineInputBorder(),
                      ),
                      items: _cursos
                          .map((curso) => DropdownMenuItem(
                                value: curso.id,
                                child: Text(curso.nome!),
                              ))
                          .toList(),
                      onChanged: (value) => _selecionaCurso(value),
                    ),
              const SizedBox(
                height: 10.0,
              ),
              const Text('Requisitos:'),
              _carregandoDisciplinas
                  ? const Carregando()
                  : SizedBox(
                      height: MediaQuery.of(context).size.height - 500,
                      width: double.maxFinite,
                      child: ListView.builder(
                        itemExtent: 50,
                        itemCount: _disciplinas.length,
                        itemBuilder: (context, index) =>
                            CheckboxListTile.adaptive(
                          value: _requisitos.contains(_disciplinas[index]),
                          title: Text(_disciplinas[index].nome!),
                          controlAffinity: ListTileControlAffinity.leading,
                          onChanged: (isChecked) => _atualizaRequisitos(
                              _disciplinas[index], isChecked),
                        ),
                      ),
                    )
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
                      title: 'Erro ao salvar disciplina',
                      confirmBtnText: 'Fechar',
                      text: error.toString());
                });
              },
              child: const Text('Salvar'))
        ]);
  }
}
