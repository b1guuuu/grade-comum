import 'package:grade/controller/global_controller.dart';
import 'package:grade/model/anotacao.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class AnotacaoController {
  final String _urlBase = '${GlobalController.baseURL}/anotacao';

  Future<List<Anotacao>> buscaTodos() async {
    final resposta = await http.get(Uri.parse(_urlBase),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8'
        });

    if (resposta.statusCode == 200) {
      List<dynamic> listaJson = jsonDecode(resposta.body);
      return listaJson.map((json) => Anotacao.fromJson(json)).toList();
    } else {
      throw Exception(
          'Ocorreu um erro ao buscar as anotações: ${resposta.toString()}');
    }
  }

  Future<List<Anotacao>> buscaTodosAlunoDisciplina(
      int idAluno, int idDisciplina) async {
    final resposta = await http.get(
        Uri.parse(
            '$_urlBase/aluno?idAluno=$idAluno&idDisciplina=$idDisciplina'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8'
        });

    if (resposta.statusCode == 200) {
      List<dynamic> listaJson = jsonDecode(resposta.body);
      return listaJson.map((json) => Anotacao.fromJson(json)).toList();
    } else {
      throw Exception(
          'Ocorreu um erro ao buscar os horários: ${resposta.toString()}');
    }
  }

  Future<List<Anotacao>> buscaTodosAlunoCalendario(int idAluno) async {
    final resposta = await http.get(
        Uri.parse('$_urlBase/calendario/aluno/?idAluno=$idAluno'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8'
        });

    if (resposta.statusCode == 200) {
      List<dynamic> listaJson = jsonDecode(resposta.body);
      return listaJson.map((json) => Anotacao.fromJson(json)).toList();
    } else {
      throw Exception(
          'Ocorreu um erro ao buscar os horários: ${resposta.toString()}');
    }
  }

  Future<void> salvaAnotacao(Anotacao anotacao) async {
    final resposta = await http.post(Uri.parse(_urlBase),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8'
        },
        body: jsonEncode(anotacao.tituloCalendario == null
            ? anotacao.toMapSimples()
            : anotacao.toMapCalendario()));

    if (resposta.statusCode != 201) {
      throw Exception(
          'Ocorreu um erro ao inserir anotação: ${resposta.toString()}');
    }
  }
}
