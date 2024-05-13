import 'package:flutter/material.dart';
import 'package:grade/controller/curso_controller.dart';
import 'package:grade/controller/disciplina_controller.dart';
import 'package:grade/controller/professor_controller.dart';
import 'package:grade/controller/turma_controller.dart';
import 'package:grade/model/curso.dart';
import 'package:grade/model/disciplina.dart';
import 'package:grade/model/professor.dart';
import 'package:grade/model/turma.dart';
import 'package:grade/view/component/carregando.dart';
import 'package:quickalert/models/quickalert_type.dart';
import 'package:quickalert/widgets/quickalert_dialog.dart';

class AdminFormularioTurma extends StatefulWidget {
  const AdminFormularioTurma({super.key});

  @override
  State<AdminFormularioTurma> createState() {
    return AdminFormularioTurmaState();
  }
}

class AdminFormularioTurmaState extends State<AdminFormularioTurma> {
  final _disciplinaController = DisciplinaController();
  final _professorController = ProfessorController();
  final _cursoController = CursoController();
  final _turmaController = TurmaController();
  final _codigoTxtController = TextEditingController();
  final _numeroTxtController = TextEditingController();
  List<Professor> _professores = [];
  List<Curso> _cursos = [];
  List<Disciplina> _disciplinas = [];
  bool _carregandoCursos = true;
  bool _carregandoDisciplinas = false;
  bool _carregandoProfessores = false;
  int? _idCurso;
  int? _idDisciplina;
  int? _idProfessor;

  @override
  void initState() {
    super.initState();
    _buscaCursos();
    _buscaProfessores();
  }

  Future<void> _buscaProfessores() async {
    setState(() {
      _carregandoProfessores = true;
    });
    var professores = await _professorController.listar();
    setState(() {
      _professores = professores;
      _carregandoProfessores = false;
    });
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
      _idDisciplina = null;
    });
    _buscaDisciplinas();
  }

  void _selecionaDisciplina(int? id) {
    setState(() {
      _idDisciplina = id;
    });
  }

  void _selecionaProfessor(int? id) {
    setState(() {
      _idProfessor = id;
    });
  }

  Future<void> _salvar() async {
    if (_codigoTxtController.text.trim().isEmpty) {
      throw Exception('O código não pode ser vazio');
    }
    try {
      int.parse(_codigoTxtController.text);
    } catch (e) {
      throw Exception('O código não possui um valor válido');
    }
    if (_numeroTxtController.text.trim().isEmpty) {
      throw Exception('O número não pode ser vazio');
    }
    try {
      int.parse(_numeroTxtController.text);
    } catch (e) {
      throw Exception('O número não possui um valor válido');
    }
    if (int.parse(_numeroTxtController.text) < 1 ||
        int.parse(_numeroTxtController.text) > 6) {
      throw Exception(
          'O número da disciplina deve ser no mínimo 1 e no máximo 6');
    }
    if (_idProfessor == null) {
      throw Exception('Seleciona um(a) professor(a)');
    }
    if (_idDisciplina == null) {
      throw Exception('Seleciona uma disciplina');
    }

    var turma = Turma(
        id: null,
        codigo: int.parse(_codigoTxtController.text),
        numero: int.parse(_numeroTxtController.text),
        idDisciplina: _idDisciplina,
        idProfessor: _idProfessor);
    return _turmaController.inserir(turma);
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog.adaptive(
      title: const Text('Formulário turma'),
      content: SizedBox(
        height: MediaQuery.of(context).size.height * 0.45,
        width: MediaQuery.of(context).size.width * 0.9,
        child: ListView(children: [
          TextField(
            decoration: const InputDecoration(
              label: Text('Codigo'),
              border: OutlineInputBorder(),
            ),
            controller: _codigoTxtController,
            keyboardType: TextInputType.number,
          ),
          const SizedBox(
            height: 10.0,
          ),
          TextField(
            decoration: const InputDecoration(
              label: Text('Número'),
              border: OutlineInputBorder(),
            ),
            controller: _numeroTxtController,
            keyboardType: TextInputType.number,
          ),
          const SizedBox(
            height: 10.0,
          ),
          _carregandoProfessores
              ? const Carregando()
              : DropdownButtonFormField(
                  value: _idProfessor,
                  decoration: const InputDecoration(
                    label: Text('Professor(a)'),
                    border: OutlineInputBorder(),
                  ),
                  items: _professores
                      .map((professor) => DropdownMenuItem(
                            value: professor.id,
                            child: Text(
                              professor.nome,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ))
                      .toList(),
                  onChanged: (value) => _selecionaProfessor(value),
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
                            child: Text(
                              curso.nome!,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ))
                      .toList(),
                  onChanged: (value) => _selecionaCurso(value),
                ),
          const SizedBox(
            height: 10.0,
          ),
          _carregandoDisciplinas
              ? const Carregando()
              : DropdownButtonFormField(
                  value: _idDisciplina,
                  decoration: const InputDecoration(
                    label: Text('Disciplina'),
                    border: OutlineInputBorder(),
                  ),
                  items: _disciplinas
                      .map((disciplina) => DropdownMenuItem(
                            value: disciplina.id,
                            child: Text(
                              disciplina.nome!,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ))
                      .toList(),
                  onChanged: (value) => _selecionaDisciplina(value),
                ),
          const SizedBox(
            height: 10.0,
          ),
        ]),
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
                    title: 'Erro ao salvar turma',
                    confirmBtnText: 'Fechar',
                    text: error.toString());
              });
            },
            child: const Text('Salvar'))
      ],
    );
  }
}
