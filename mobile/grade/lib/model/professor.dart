class Professor {
  late int? id;
  final String nome;

  Professor({required this.id, required this.nome});

  Professor.semId(this.nome);

  Professor.fromJson(dynamic json)
      : id = json['id'],
        nome = json['nome'];

  Professor.fromJsonSemId(dynamic json) : nome = json['nome'];

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
  bool operator ==(Object other) => other is Professor ? other.id == id : false;
}
