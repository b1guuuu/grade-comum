import 'package:grade/controller/global_controller.dart';
import 'package:grade/model/horario.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class HorarioController {
  final String _urlBase = '${GlobalController.baseURL}/horario';

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

  Future<List<Horario>> buscaHorariosProfessor(int idProfessor) async {
    final resposta = await http.get(
        Uri.parse('$_urlBase/professor/?idProfessor=$idProfessor'),
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

  Future<List<Horario>> buscaHorariosPorTurma(int idTurma) async {
    final resposta = await http.get(
        Uri.parse('$_urlBase/turma?idTurma=$idTurma'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8'
        });

    if (resposta.statusCode == 200) {
      List<dynamic> listaJson = jsonDecode(resposta.body);
      return listaJson.map((json) => Horario.fromJson(json)).toList();
    } else {
      throw Exception(jsonDecode(resposta.body));
    }
  }

  Future<void> atualizaHorariosTurma(List<Horario> horarios) async {
    final resposta = await http.put(Uri.parse('$_urlBase/turma'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8'
        },
        body: jsonEncode(horarios.map((horario) => horario.toMap()).toList()));

    if (resposta.statusCode != 204) {
      throw Exception(jsonDecode(resposta.body));
    }
  }
}
