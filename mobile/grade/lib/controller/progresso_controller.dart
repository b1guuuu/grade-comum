import 'package:grade/controller/global_controller.dart';
import 'package:grade/model/progresso.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ProgressoController {
  final String _urlBase = '${GlobalController.baseURL}/progresso';

  Future<List<Progresso>> listarPorAluno(int idAluno) async {
    final resposta = await http.get(Uri.parse('$_urlBase?idAluno=$idAluno'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8'
        });

    if (resposta.statusCode == 200) {
      List<dynamic> listaJson = jsonDecode(resposta.body);
      return listaJson.map((json) => Progresso.fromJson(json)).toList();
    } else {
      throw Exception(
          'Ocorreu um erro ao buscar os progressos: ${resposta.toString()}');
    }
  }

  Future<void> atualizar(int idDisciplina, int idAluno) async {
    final resposta = await http.put(Uri.parse('$_urlBase/concluir'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8'
        },
        body: jsonEncode({'idDisciplina': idDisciplina, 'idAluno': idAluno}));

    if (resposta.statusCode != 204) {
      throw Exception(
          'Ocorreu um erro ao atualizar o progresso: ${jsonDecode(resposta.body)}');
    }
  }
}
