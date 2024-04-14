import 'package:intl/intl.dart';

class Anotacao {
  late int id;
  late String conteudo;
  late DateTime? dataCalendario;
  late String? tituloCalendario;
  late int idAluno;
  late int idDisciplina;

  Anotacao.simples(
      {required this.conteudo,
      required this.idAluno,
      required this.idDisciplina})
      : dataCalendario = null,
        tituloCalendario = null;

  Anotacao.calendario(
      {required this.conteudo,
      required this.dataCalendario,
      required this.tituloCalendario,
      required this.idAluno,
      required this.idDisciplina});

  Anotacao.fromJson(dynamic json)
      : id = json['id'],
        conteudo = json['conteudo'],
        dataCalendario = Anotacao.formatarData(json['dataCalendario']),
        tituloCalendario = json['tituloCalendario'],
        idAluno = json['idAluno'],
        idDisciplina = json['idDisciplina'];

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'conteudo': conteudo,
      'dataCalendario': dataCalendario,
      'tituloCalendario': tituloCalendario,
      'idAluno': idAluno,
      'idDisciplina': idDisciplina
    };
  }

  Map<String, dynamic> toMapSemId() {
    return {
      'conteudo': conteudo,
      'dataCalendario': dataCalendario,
      'tituloCalendario': tituloCalendario,
      'idAluno': idAluno,
      'idDisciplina': idDisciplina
    };
  }

  Map<String, dynamic> toMapSimples() {
    return {
      'conteudo': conteudo,
      'idAluno': idAluno,
      'idDisciplina': idDisciplina
    };
  }

  Map<String, dynamic> toMapCalendario() {
    return {
      'conteudo': conteudo,
      'dataCalendario': dataCalendario?.toLocal().toString(),
      'tituloCalendario': tituloCalendario,
      'idAluno': idAluno,
      'idDisciplina': idDisciplina
    };
  }

  static DateTime? formatarData(dynamic data) {
    if (data == null || data.toString() == 'null') return null;
    var inputFormat = DateFormat('yyyy-MM-dd');
    return inputFormat.parse(data);
  }

  @override
  String toString() {
    return toMap().toString();
  }

  @override
  int get hashCode => id.hashCode;

  @override
  bool operator ==(Object other) => other is Anotacao ? other.id == id : false;
}
