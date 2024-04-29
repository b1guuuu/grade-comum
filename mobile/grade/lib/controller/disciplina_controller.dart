import 'package:grade/controller/global_controller.dart';
import 'package:grade/model/disciplina.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class DisciplinaController {
  final String _urlBase = '${GlobalController.baseURL}/disciplina';

  Future<List<Disciplina>> listar() async {
    final resposta = await http.get(Uri.parse(_urlBase),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8'
        });

    if (resposta.statusCode == 200) {
      List<dynamic> listaJson = jsonDecode(resposta.body);
      return listaJson.map((json) => Disciplina.fromJson(json)).toList();
    } else {
      throw Exception(
          'Ocorreu um erro ao buscar as disciplinas: ${resposta.toString()}');
    }
  }

  Future<List<Disciplina>> listarDisciplinasAnotacoesAluno(int idAluno) async {
    final resposta = await http.get(
        Uri.parse('$_urlBase/aluno/anotacoes/?idAluno=$idAluno'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8'
        });

    if (resposta.statusCode == 200) {
      List<dynamic> listaJson = jsonDecode(resposta.body);
      return listaJson.map((json) => Disciplina.fromJson(json)).toList();
    } else {
      throw Exception(
          'Ocorreu um erro ao buscar as disciplinas: ${resposta.toString()}');
    }
  }

  Future<List<Disciplina>> listarDisciplinasAlunoInscrito(int idAluno) async {
    final resposta = await http.get(
        Uri.parse('$_urlBase/aluno/inscrito/?idAluno=$idAluno'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8'
        });

    if (resposta.statusCode == 200) {
      List<dynamic> listaJson = jsonDecode(resposta.body);
      return listaJson.map((json) => Disciplina.fromJson(json)).toList();
    } else {
      throw Exception(
          'Ocorreu um erro ao buscar as disciplinas: ${resposta.toString()}');
    }
  }

  Future<void> cadastrarDisciplina(Disciplina disciplina) async {
    final resposta = await http.post(Uri.parse(_urlBase),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8'
        },
        body: jsonEncode(disciplina.toMap()));

    if (resposta.statusCode != 201) {
      throw Exception(
          'Ocorreu um erro ao cadastrar a disciplina: ${jsonDecode(resposta.body).toString()}');
    }
  }
}
