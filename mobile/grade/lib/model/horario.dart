class Horario {
  late int id;
  final String diaSemana;
  final String inicio;
  final String fim;
  final String sala;
  final int idTurma;

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
        idTurma = json['idTurma'];

  Horario.fromJsonSemId(dynamic json)
      : diaSemana = json['diaSemana'],
        inicio = json['inicio'],
        fim = json['fim'],
        sala = json['sala'],
        idTurma = json['idTurma'];

  Map<String, dynamic> toMap() {
    return {
      "id": id,
      "diaSemana": diaSemana,
      "inicio": inicio,
      "fim": fim,
      "sala": sala,
      "idTurma": idTurma
    };
  }

  Map<String, dynamic> toMapSemId() {
    return {
      "diaSemana": diaSemana,
      "inicio": inicio,
      "fim": fim,
      "sala": sala,
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
