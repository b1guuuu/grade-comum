class Aluno {
  int? id;
  String? nome;
  String? matricula;
  String? senha;
  int? idCurso;

  Aluno(
      {required this.id,
      required this.nome,
      required this.matricula,
      required this.senha});

  Aluno.login({required this.matricula, required this.senha});

  Aluno.cadastro(
      {required this.nome,
      required this.matricula,
      required this.senha,
      required this.idCurso});

  Aluno.fromJson(dynamic json)
      : id = json['id'],
        nome = json['nome'],
        matricula = json['matricula'],
        idCurso = json['idCurso'];

  Map<String, dynamic> toMap() {
    return {
      "id": id,
      "nome": nome,
      "matricula": matricula,
      "senha": senha,
      "idCurso": idCurso
    };
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
