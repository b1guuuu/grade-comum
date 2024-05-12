class Progresso {
  final int idDisciplina;
  final int idAluno;
  final int tentativas;
  final bool concluido;

  Progresso(
      {required this.idDisciplina,
      required this.idAluno,
      required this.tentativas,
      required this.concluido});

  Progresso.fromJson(dynamic json)
      : idDisciplina = json['idDisciplina'],
        idAluno = json['idAluno'],
        tentativas = json['tentativas'],
        concluido = json['concluido'];

  Map<String, dynamic> toMap() {
    return {
      "idDisciplina": idDisciplina,
      "idAluno": idAluno,
      "tentativas": tentativas,
      "concluido": concluido
    };
  }

  @override
  String toString() {
    return toMap().toString();
  }

  @override
  int get hashCode => (idAluno * idDisciplina).hashCode;

  @override
  bool operator ==(Object other) => other is Progresso
      ? (other.idDisciplina == idDisciplina && other.idAluno == idAluno)
      : false;
}
