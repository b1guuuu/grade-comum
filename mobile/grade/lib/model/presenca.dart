class Presenca {
  late int id;
  final bool presente;
  late String observacao;
  late int idProfessor;
  late DateTime ultimaAtualizacao;

  Presenca.semId(this.presente);

  Presenca.fromJson(dynamic json)
      : id = json['id'],
        presente = json['presente'],
        observacao = json['observacao'],
        idProfessor = json['idProfessor'],
        ultimaAtualizacao = json['ultimaAtualizacao'];

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
      "ultimaAtualizacao": ultimaAtualizacao
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

  @override
  String toString() {
    return toMap().toString();
  }

  @override
  int get hashCode => id.hashCode;

  @override
  bool operator ==(Object other) => other is Presenca ? other.id == id : false;
}
