import 'package:grade/controller/global_controller.dart';
import 'package:grade/model/turma.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class TurmaController {
  final String _urlBase = '${GlobalController.baseURL}/turma';

  Future<List<Turma>> buscaTodas() async {
    final resposta = await http.get(Uri.parse(_urlBase),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8'
        });

    if (resposta.statusCode == 200) {
      List<dynamic> listaJson = jsonDecode(resposta.body);
      return listaJson.map((json) => Turma.fromJson(json)).toList();
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
      return listaJson.map((json) => Turma.fromJson(json)).toList();
    } else {
      throw Exception(
          'Ocorreu um erro ao buscar as turmas: ${resposta.toString()}');
    }
  }

  Future<List<Turma>> buscaTurmasValidas(int idAluno) async {
    final resposta = await http.get(
        Uri.parse('$_urlBase/aluno/disponiveis?idAluno=$idAluno'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8'
        });

    if (resposta.statusCode == 200) {
      List<dynamic> listaJson = jsonDecode(resposta.body);
      return listaJson.map((json) => Turma.fromJson(json)).toList();
    } else {
      throw Exception(
          'Ocorreu um erro ao buscar as turmas: ${resposta.toString()}');
    }
  }
}
