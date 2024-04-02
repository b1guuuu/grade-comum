class Inscricao {
  final int idTurma;
  final int idAluno;

  Inscricao({required this.idAluno, required this.idTurma});

  Inscricao.fromJson(dynamic json)
      : idAluno = json['idAluno'],
        idTurma = json['idTurma'];

  Map<String, dynamic> toMap() {
    return {'idTurma': idTurma, 'idAluno': idAluno};
  }

  @override
  String toString() {
    return toMap().toString();
  }

  @override
  int get hashCode => idTurma.hashCode;

  @override
  bool operator ==(Object other) => other is Inscricao
      ? other.idAluno == idAluno && other.idTurma == idTurma
      : false;
}
