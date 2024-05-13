import 'package:grade/model/professor.dart';
import 'package:intl/intl.dart';

class Presenca {
  late int id;
  late bool presente;
  late String observacao;
  late DateTime ultimaAtualizacao;
  late int idProfessor;
  Professor? professor;

  Presenca.semId(this.presente);

  Presenca.fromJson(dynamic json)
      : id = json['id'],
        presente = json['presente'],
        observacao = json['observacao'],
        idProfessor = json['idProfessor'],
        ultimaAtualizacao = Presenca.formatarData(json['ultimaAtualizacao']),
        professor = json['professor'] == null
            ? null
            : Professor.fromJson(json['professor']);

  Presenca.fromJsonSemId(dynamic json)
      : presente = json['presente'],
        observacao = json['observacao'],
        idProfessor = json['idProfessor'],
        ultimaAtualizacao = json['ultimaAtualizacao'];

  Map<String, dynamic> toMap() {
    return {
      "id": id,
      "presente": presente,
      "observacao": observacao,
      "idProfessor": idProfessor,
      "ultimaAtualizacao": ultimaAtualizacao.toString()
    };
  }

  Map<String, dynamic> toMapSemId() {
    return {
      "presente": presente,
      "observacao": observacao,
      "idProfessor": idProfessor,
      "ultimaAtualizacao": ultimaAtualizacao
    };
  }

  set setObservacao(String observacao) {
    this.observacao = observacao;
  }

  set setUltimaAtualizacao(DateTime ultimaAtualizacao) {
    this.ultimaAtualizacao = ultimaAtualizacao;
  }

  static DateTime formatarData(dynamic data) {
    var inputFormat = DateFormat('yyyy-MM-dd');
    return inputFormat.parse(data);
  }

  @override
  String toString() {
    return toMap().toString();
  }

  @override
  int get hashCode => id.hashCode;

  @override
  bool operator ==(Object other) => other is Presenca ? other.id == id : false;
}
