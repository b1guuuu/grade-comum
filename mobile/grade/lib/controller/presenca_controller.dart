import 'package:grade/controller/global_controller.dart';
import 'package:grade/model/presenca.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class PresencaController {
  final String _urlBase = '${GlobalController.baseURL}/presenca';
  Future<List<Presenca>> listar() async {
    final resposta = await http.get(Uri.parse(_urlBase),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8'
        });

    if (resposta.statusCode == 200) {
      var listaJson = jsonDecode(resposta.body);
      List<Presenca> presencas = [];
      for (var json in listaJson) {
        presencas.add(Presenca.fromJson(json));
      }
      return presencas;
    } else {
      throw Exception(
          'Ocorreu um erro ao buscar os presenças: ${resposta.toString()}');
    }
  }

  Future<List<Presenca>> listarAluno(int idAluno) async {
    final resposta = await http.get(
        Uri.parse('$_urlBase/aluno?idAluno=$idAluno'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8'
        });

    if (resposta.statusCode == 200) {
      var listaJson = jsonDecode(resposta.body);
      List<Presenca> presencas = [];
      for (var json in listaJson) {
        presencas.add(Presenca.fromJson(json));
      }
      return presencas;
    } else {
      throw Exception(
          'Ocorreu um erro ao buscar os presenças: ${resposta.toString()}');
    }
  }

  Future<Presenca> listarPorProfessor(int idProfessor) async {
    final resposta = await http.get(
        Uri.parse('$_urlBase/professor?idProfessor=$idProfessor'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8'
        });

    if (resposta.statusCode == 200) {
      return Presenca.fromJson(jsonDecode(resposta.body));
    } else {
      throw Exception(
          'Ocorreu um erro ao buscar os presenças: ${resposta.toString()}');
    }
  }

  Future<void> atualizar(Presenca presenca) async {
    final resposta = await http.put(Uri.parse(_urlBase),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8'
        },
        body: jsonEncode(presenca.toMap()));

    if (resposta.statusCode != 204) {
      throw Exception(
          'Ocorreu um erro ao atualizar o presenca: ${jsonDecode(resposta.body)}');
    }
  }
}
