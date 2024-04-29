import 'package:grade/model/disciplina.dart';
import 'package:grade/model/professor.dart';

class Turma {
  int? id;
  int? codigo;
  int? numero;
  int? idDisciplina;
  int? idProfessor;
  Disciplina? disciplina;
  Professor? professor;

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
        idProfessor = json['idProfessor'],
        disciplina = json['disciplina'] == null
            ? null
            : Disciplina.fromJson(json['disciplina']),
        professor = json['professor'] == null
            ? null
            : Professor.fromJson(json['professor']);

  Map<String, dynamic> toMap() {
    return {
      "id": id,
      "codigo": codigo,
      "numero": numero,
      "idDisciplina": idDisciplina,
      "idProfessor": idProfessor,
      "disciplina": disciplina?.toString(),
      "professor": professor?.toString()
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
