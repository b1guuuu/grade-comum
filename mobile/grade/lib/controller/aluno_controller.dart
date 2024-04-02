import 'package:grade/model/aluno.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class AlunoController {
  final String _urlBase = 'http://localhost:3000/aluno';

  Future<Aluno> login(Aluno aluno) async {
    final resposta = await http.post(Uri.parse('$_urlBase/login'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8'
        },
        body: jsonEncode(aluno.toMap()));

    if (resposta.statusCode == 200) {
      return Aluno.fromJson(jsonDecode(resposta.body));
    } else {
      throw Exception(
          'Ocorreu um erro ao tentar fazer login: ${resposta.toString()}');
    }
  }

  Future<Aluno> cadastro(Aluno aluno) async {
    final resposta = await http.post(Uri.parse('$_urlBase/cadastro'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8'
        },
        body: jsonEncode(aluno.toMap()));

    if (resposta.statusCode == 201) {
      return Aluno.fromJson(jsonDecode(resposta.body));
    } else {
      throw Exception(
          'Ocorreu um erro ao tentar realizar o cadastro: ${resposta.toString()}');
    }
  }
}