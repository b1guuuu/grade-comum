class Aluno {
  late int id;
  final String nome;
  final String matricula;
  late String senha;

  Aluno(this.matricula, {required this.id, required this.nome});

  Aluno.semId(this.nome, this.matricula);

  Aluno.fromJson(dynamic json)
      : id = json['id'],
        nome = json['nome'],
        matricula = json['matricula'];

  Aluno.fromJsonSemId(dynamic json)
      : nome = json['nome'],
        matricula = json['matricula'];

  Map<String, dynamic> toMap() {
    return {"id": id, "nome": nome, "matricula": matricula};
  }

  Map<String, dynamic> toMapSemId() {
    return {"nome": nome, "matricula": matricula};
  }

  set setSenha(String senha) {
    this.senha = senha;
  }

  @override
  String toString() {
    return toMap().toString();
  }

  @override
  int get hashCode => id.hashCode;

  @override
  bool operator ==(Object other) => other is Aluno ? other.id == id : false;
}
