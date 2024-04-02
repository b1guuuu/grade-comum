import 'package:grade/model/disciplina.dart';
import 'package:grade/model/professor.dart';

class Turma {
  late int id;
  final int codigo;
  final int numero;
  final int idDisciplina;
  final int idProfessor;
  late Disciplina disciplina;
  late Professor professor;

  Turma(
      {required this.id,
      required this.codigo,
      required this.numero,
      required this.idDisciplina,
      required this.idProfessor});

  Turma.semId(
      {required this.codigo,
      required this.numero,
      required this.idDisciplina,
      required this.idProfessor});

  Turma.fromJson(dynamic json)
      : id = json['id'],
        codigo = json['codigo'],
        numero = json['numero'],
        idDisciplina = json['idDisciplina'],
        idProfessor = json['idProfessor'];

  Turma.fromJsonSemId(dynamic json)
      : codigo = json['codigo'],
        numero = json['numero'],
        idDisciplina = json['idDisciplina'],
        idProfessor = json['idProfessor'];

  Turma.fromJsonComDisciplinaProfessor(dynamic json)
      : id = json['id'],
        codigo = json['codigo'],
        numero = json['numero'],
        idDisciplina = json['idDisciplina'],
        idProfessor = json['idProfessor'],
        disciplina = Disciplina.fromJson(json['disciplina']),
        professor = Professor.fromJson(json['professor']);

  Map<String, dynamic> toMap() {
    return {
      "id": id,
      "codigo": codigo,
      "numero": numero,
      "idDisciplina": idDisciplina,
      "idProfessor": idProfessor
    };
  }

  Map<String, dynamic> toMapSemId() {
    return {
      "codigo": codigo,
      "numero": numero,
      "idDisciplina": idDisciplina,
      "idProfessor": idProfessor
    };
  }

  @override
  String toString() {
    return toMap().toString();
  }

  @override
  int get hashCode => id.hashCode;

  @override
  bool operator ==(Object other) => other is Turma ? other.id == id : false;
}
