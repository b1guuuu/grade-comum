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
}
