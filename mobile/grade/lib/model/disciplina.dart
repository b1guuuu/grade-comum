class Disciplina {
  int? id;
  String? nome;
  int? periodo;
  int? idCurso;
  List<Disciplina>? requisitos;

  Disciplina({required this.id, required this.nome});

  Disciplina.fromJson(dynamic json)
      : id = json['id'],
        nome = json['nome'],
        periodo = json['periodo'],
        idCurso = json['idCurso'];

  Disciplina.cadastro(
      {required this.nome,
      required this.periodo,
      required this.idCurso,
      required this.requisitos});

  Map<String, dynamic> toMap() {
    return {
      "id": id,
      "nome": nome,
      "periodo": periodo,
      "idCurso": idCurso,
      "requisitos": requisitos?.map((requisito) => requisito.toMap()).toList()
    };
  }

  void setRequisitos(dynamic json) {
    List<Disciplina> requisitos = [];
    for (var requisito in json['requisitos']) {
      requisitos.add(Disciplina.fromJson(requisito));
    }
    this.requisitos = requisitos;
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
