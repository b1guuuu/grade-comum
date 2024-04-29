import 'package:flutter/material.dart';
import 'package:grade/controller/curso_controller.dart';
import 'package:grade/controller/disciplina_controller.dart';
import 'package:grade/model/curso.dart';
import 'package:grade/model/disciplina.dart';
import 'package:grade/view/component/carregando.dart';
import 'package:quickalert/models/quickalert_type.dart';
import 'package:quickalert/widgets/quickalert_dialog.dart';

class DisciplinaCadastro extends StatefulWidget {
  final List<Disciplina> disciplinas;

  const DisciplinaCadastro({super.key, required this.disciplinas});
  @override
  State<DisciplinaCadastro> createState() {
    return DisciplinaCadastroState();
  }
}

class DisciplinaCadastroState extends State<DisciplinaCadastro> {
  final CursoController _cursoController = CursoController();
  final TextEditingController _nomeTxtController = TextEditingController();
  final DisciplinaController _disciplinaController = DisciplinaController();
  final List<Disciplina> _requisitos = [];
  List<Curso> _cursos = [];
  int? _idCurso;
  bool _carregando = true;

  @override
  void initState() {
    super.initState();
    _buscaCursos();
  }

  void _buscaCursos() async {
    setState(() {
      _carregando = true;
    });
    var cursos = await _cursoController.listar();
    setState(() {
      _cursos = cursos;
      _idCurso = cursos.first.id;
      _carregando = false;
    });
  }

  void _itemChange(Disciplina itemValue, bool isSelected) {
    setState(() {
      if (isSelected) {
        _requisitos.add(itemValue);
      } else {
        _requisitos.remove(itemValue);
      }
    });
  }

  Future<void> _salvarDisciplina() async {
    var disciplina = Disciplina.cadastro(
        nome: _nomeTxtController.text,
        idCurso: _idCurso,
        requisitos: _requisitos);
    return _disciplinaController.cadastrarDisciplina(disciplina);
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog.adaptive(
      title: const Text('Manter Disciplina'),
      content: _carregando
          ? const Carregando()
          : SizedBox(
              height: MediaQuery.of(context).size.height - 100,
              child: InteractiveViewer(
                child: Column(
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
                    DropdownButtonFormField(
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
                      onChanged: (value) => setState(() {
                        _idCurso = value;
                      }),
                    ),
                    const SizedBox(
                      height: 10.0,
                    ),
                    ...widget.disciplinas
                        .map((disciplina) => CheckboxListTile.adaptive(
                              value: _requisitos.contains(disciplina),
                              title: Text(disciplina.nome!),
                              controlAffinity: ListTileControlAffinity.leading,
                              onChanged: (isChecked) =>
                                  _itemChange(disciplina, isChecked!),
                            ))
                        .toList()
                  ],
                ),
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
              _salvarDisciplina().then((value) {
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
      ],
    );
  }
}
