import 'package:grade/controller/global_controller.dart';
import 'package:grade/model/professor.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ProfessorController {
  final String _urlBase = '${GlobalController.baseURL}/professor';
  Future<List<Professor>> listar() async {
    final resposta = await http.get(Uri.parse(_urlBase),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8'
        });

    if (resposta.statusCode == 200) {
      var listaJson = jsonDecode(resposta.body);
      List<Professor> professores = [];
      for (var json in listaJson) {
        professores.add(Professor.fromJson(json));
      }
      return professores;
    } else {
      throw Exception(
          'Ocorreu um erro ao buscar os professores: ${resposta.toString()}');
    }
  }

  Future<void> inserir(Professor professor) async {
    final resposta = await http.post(Uri.parse(_urlBase),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8'
        },
        body: jsonEncode(professor.toMap()));

    if (resposta.statusCode != 201) {
      throw Exception(
          'Ocorreu um erro ao inserir o professor: ${jsonDecode(resposta.body)}');
    }
  }

  Future<void> atualizar(Professor professor) async {
    final resposta = await http.put(Uri.parse(_urlBase),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8'
        },
        body: jsonEncode(professor.toMap()));

    if (resposta.statusCode != 204) {
      throw Exception(
          'Ocorreu um erro ao atualizar o professor: ${jsonDecode(resposta.body)}');
    }
  }

  Future<void> deletar(Professor professor) async {
    final resposta = await http.delete(Uri.parse(_urlBase),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8'
        },
        body: jsonEncode(professor.toMap()));

    if (resposta.statusCode != 204) {
      print(resposta.body);
      throw Exception(jsonDecode(resposta.body)['message']);
    }
  }
}
