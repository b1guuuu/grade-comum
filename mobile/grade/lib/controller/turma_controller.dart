import 'package:grade/model/turma.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class TurmaController {
  final String _urlBase = 'http://192.168.0.10:3000/turma';

  Future<List<Turma>> buscaTodas() async {
    final resposta = await http.get(Uri.parse(_urlBase),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8'
        });

    if (resposta.statusCode == 200) {
      List<dynamic> listaJson = jsonDecode(resposta.body);
      return listaJson
          .map((json) => Turma.fromJsonComDisciplinaProfessor(json))
          .toList();
    } else {
      throw Exception(
          'Ocorreu um erro ao buscar as turmas: ${resposta.toString()}');
    }
  }

  Future<List<Turma>> buscaTurmasInscritas(int idAluno) async {
    final resposta = await http.get(
        Uri.parse('$_urlBase/aluno/?idAluno=$idAluno'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8'
        });

    if (resposta.statusCode == 200) {
      List<dynamic> listaJson = jsonDecode(resposta.body);
      return listaJson
          .map((json) => Turma.fromJsonComDisciplinaProfessor(json))
          .toList();
    } else {
      throw Exception(
          'Ocorreu um erro ao buscar as turmas: ${resposta.toString()}');
    }
  }
}
