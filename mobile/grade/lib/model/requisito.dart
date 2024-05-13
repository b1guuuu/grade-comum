class Requisito {
  final int idDisciplina;
  final int idDisciplinaRequisito;

  Requisito({required this.idDisciplina, required this.idDisciplinaRequisito});

  Requisito.fromJson(dynamic json)
      : idDisciplina = json['idDisciplina'],
        idDisciplinaRequisito = json['idDisciplinaRequisito'];

  Map<String, dynamic> toMap() {
    return {
      'idDisciplina': idDisciplina,
      'idDisciplinaRequisito': idDisciplinaRequisito
    };
  }

  @override
  String toString() {
    return toMap().toString();
  }

  @override
  int get hashCode => (idDisciplina * idDisciplinaRequisito).hashCode;

  @override
  bool operator ==(Object other) => other is Requisito
      ? other.idDisciplina == idDisciplina &&
          other.idDisciplinaRequisito == idDisciplinaRequisito
      : false;
}
