import 'package:grade/model/turma.dart';

class Horario {
  late int id;
  final int diaSemana;
  final String inicio;
  final String fim;
  late String sala;
  late int ordem;
  final int idTurma;
  late Turma turma;

  Horario(
      {required this.id,
      required this.diaSemana,
      required this.inicio,
      required this.fim,
      required this.sala,
      required this.idTurma});

  Horario.semId(
      {required this.diaSemana,
      required this.inicio,
      required this.fim,
      required this.sala,
      required this.idTurma});

  Horario.fromJson(dynamic json)
      : id = json['id'],
        diaSemana = json['diaSemana'],
        inicio = json['inicio'],
        fim = json['fim'],
        sala = json['sala'],
        ordem = json['ordem'],
        idTurma = json['idTurma'];

  Horario.fromJsonSemId(dynamic json)
      : diaSemana = json['diaSemana'],
        inicio = json['inicio'],
        fim = json['fim'],
        sala = json['sala'],
        ordem = json['ordem'],
        idTurma = json['idTurma'];

  Horario.fromJsonComTurma(dynamic json)
      : id = json['id'],
        diaSemana = json['diaSemana'],
        inicio = json['inicio'],
        fim = json['fim'],
        sala = json['sala'],
        ordem = json['ordem'],
        idTurma = json['idTurma'],
        turma = Turma.fromJson(json['turma']);

  Map<String, dynamic> toMap() {
    return {
      "id": id,
      "diaSemana": diaSemana,
      "inicio": inicio,
      "fim": fim,
      "sala": sala,
      "ordem": ordem,
      "idTurma": idTurma
    };
  }

  Map<String, dynamic> toMapSemId() {
    return {
      "diaSemana": diaSemana,
      "inicio": inicio,
      "fim": fim,
      "sala": sala,
      "ordem": ordem,
      "idTurma": idTurma
    };
  }

  @override
  String toString() {
    return toMap().toString();
  }

  @override
  int get hashCode => id.hashCode;

  @override
  bool operator ==(Object other) => other is Horario ? other.id == id : false;
}
