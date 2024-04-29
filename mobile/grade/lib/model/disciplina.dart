class Disciplina {
  int? id;
  String? nome;
  int? idCurso;
  List<Disciplina>? requisitos;

  Disciplina({required this.id, required this.nome});

  Disciplina.semId(this.nome);

  Disciplina.fromJson(dynamic json)
      : id = json['id'],
        nome = json['nome'],
        idCurso = json['idCurso'],
        requisitos = json['requisitos']
            ?.map((requisito) => Disciplina.fromJson(requisito));

  Disciplina.cadastro(
      {required this.nome, required this.idCurso, required this.requisitos});

  Map<String, dynamic> toMap() {
    return {
      "id": id,
      "nome": nome,
      "idCurso": idCurso,
      "requisitos": requisitos?.map((requisito) => requisito.toMap()).toList()
    };
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
