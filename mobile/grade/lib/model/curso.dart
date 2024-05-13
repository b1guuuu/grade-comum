class Curso {
  int? id;
  String? nome;

  Curso({required this.id, required this.nome});

  Curso.fromJson(dynamic json)
      : id = json['id'],
        nome = json['nome'];

  Map<String, dynamic> toMap() {
    return {"id": id, "nome": nome};
  }

  @override
  String toString() {
    return toMap().toString();
  }

  @override
  int get hashCode => id.hashCode;

  @override
  bool operator ==(Object other) => other is Curso ? other.id == id : false;
}
