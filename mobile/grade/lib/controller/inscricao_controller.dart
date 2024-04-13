import 'package:grade/controller/global_controller.dart';
import 'package:grade/model/inscricao.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class InscricaoController {
  final String _urlBase = '${GlobalController.baseURL}/inscricao';

  Future<void> inscreverEmTurma(Inscricao inscricao) async {
    final resposta = await http.post(Uri.parse(_urlBase),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8'
        },
        body: jsonEncode(inscricao.toMap()));

    if (resposta.statusCode != 201) {
      throw Exception(
          'Ocorreu um erro ao buscar as turmas: ${resposta.toString()}');
    }
  }

  Future<void> deletarInscricao(Inscricao inscricao) async {
    final resposta = await http.delete(Uri.parse(_urlBase),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8'
        },
        body: jsonEncode(inscricao.toMap()));

    if (resposta.statusCode != 204) {
      throw Exception(
          'Ocorreu um erro ao buscar as turmas: ${resposta.toString()}');
    }
  }
}
