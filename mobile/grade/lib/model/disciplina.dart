class Disciplina {
  late int id;
  final String nome;

  Disciplina({required this.id, required this.nome});

  Disciplina.semId(this.nome);

  Disciplina.fromJson(dynamic json)
      : id = json['id'],
        nome = json['nome'];

  Disciplina.fromJsonSemId(dynamic json) : nome = json['nome'];

  Map<String, dynamic> toMap() {
    return {"id": id, "nome": nome};
  }

  Map<String, dynamic> toMapSemId() {
    return {"nome": nome};
  }

  @override
  String toString() {
    return toMap().toString();
  }

  @override
  int get hashCode => id.hashCode;

  @override
  bool operator ==(Object other) =>
      other is Disciplina ? other.id == id : false;
}
