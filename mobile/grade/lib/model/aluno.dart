class Aluno {
  int? id;
  String? nome;
  String? matricula;
  String? senha;

  Aluno(
      {required this.id,
      required this.nome,
      required this.matricula,
      required this.senha});

  Aluno.login({required this.matricula, required this.senha});

  Aluno.cadastro(
      {required this.nome, required this.matricula, required this.senha});
/* 
  Aluno.fromJson(dynamic json)
      : id = json['id'],
        nome = json['nome'],
        matricula = json['matricula'];

  Aluno.fromJsonSemId(dynamic json)
      : nome = json['nome'],
        matricula = json['matricula'];

  Map<String, dynamic> toMap() {
    return {"id": id, "nome": nome, "matricula": matricula, "senha": senha};
  }

  Map<String, dynamic> toMapSemId() {
    return {"nome": nome, "matricula": matricula, "senha": senha};
  }

  Map<String, dynamic> toMapLogin() {
    return {"matricula": matricula, "senha": senha};
  }

  Map<String, dynamic> toMapLeitura() {
    return {"id": id, "nome": nome, "matricula": matricula};
  }
 */
  Aluno.fromJson(dynamic json)
      : id = json['id'],
        nome = json['nome'],
        matricula = json['matricula'];

  Map<String, dynamic> toMap() {
    return {"id": id, "nome": nome, "matricula": matricula, "senha": senha};
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
