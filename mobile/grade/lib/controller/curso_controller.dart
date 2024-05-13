import 'package:grade/controller/global_controller.dart';
import 'package:grade/model/curso.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class CursoController {
  final String _urlBase = '${GlobalController.baseURL}/curso';

  Future<List<Curso>> listar() async {
    final resposta = await http.get(Uri.parse(_urlBase),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8'
        });

    if (resposta.statusCode == 200) {
      List<dynamic> listaJson = jsonDecode(resposta.body);
      return listaJson.map((json) => Curso.fromJson(json)).toList();
    } else {
      throw Exception(
          'Ocorreu um erro ao buscar os cursos: ${resposta.toString()}');
    }
  }

  Future<void> inserir(Curso curso) async {
    final resposta = await http.post(Uri.parse(_urlBase),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8'
        },
        body: jsonEncode(curso.toMap()));

    if (resposta.statusCode != 201) {
      throw Exception(
          'Ocorreu um erro ao inserir o curso: ${jsonDecode(resposta.body)}');
    }
  }

  Future<void> atualizar(Curso curso) async {
    final resposta = await http.put(Uri.parse(_urlBase),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8'
        },
        body: jsonEncode(curso.toMap()));

    if (resposta.statusCode != 204) {
      throw Exception(
          'Ocorreu um erro ao inserir o curso: ${jsonDecode(resposta.body)}');
    }
  }
}
