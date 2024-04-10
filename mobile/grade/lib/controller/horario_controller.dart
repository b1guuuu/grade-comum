import 'package:grade/model/horario.dart';
import 'package:grade/model/turma.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class HorarioController {
  final String _urlBase = 'http://192.168.0.10:3000/horario';

  Future<List<Horario>> buscaTodos() async {
    final resposta = await http.get(Uri.parse(_urlBase),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8'
        });

    if (resposta.statusCode == 200) {
      List<dynamic> listaJson = jsonDecode(resposta.body);
      return listaJson.map((json) => Horario.fromJson(json)).toList();
    } else {
      throw Exception(
          'Ocorreu um erro ao buscar os horários: ${resposta.toString()}');
    }
  }

  Future<List<Horario>> buscaHorariosInscritos(int idAluno) async {
    final resposta = await http.get(
        Uri.parse('$_urlBase/aluno/?idAluno=$idAluno'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8'
        });

    if (resposta.statusCode == 200) {
      List<dynamic> listaJson = jsonDecode(resposta.body);
      return listaJson.map((json) => Horario.fromJsonComTurma(json)).toList();
    } else {
      throw Exception(
          'Ocorreu um erro ao buscar os horários: ${resposta.toString()}');
    }
  }
}
