import 'package:flutter/material.dart';
import 'package:grade/model/turma.dart';
import 'package:grade/view/component/my_simple_tile.dart';

class TurmaListTile extends StatelessWidget {
  final Turma turma;
  final Widget? trailing;
  final int? tentativas;

  const TurmaListTile(
      {super.key, required this.turma, this.trailing, this.tentativas});

  String _montaSubtitulo() {
    if (tentativas == null) {
      return '${turma.professor!.nome}\nDisciplina: ${turma.numero}\nCódigo: ${turma.codigo}\nPeríodo: ${turma.disciplina!.periodo}';
    } else {
      return '${turma.professor!.nome}\nDisciplina: ${turma.numero}\nCódigo: ${turma.codigo}\nVezes inscrito(a) na disciplina: $tentativas';
    }
  }

  @override
  Widget build(BuildContext context) {
    return MySimpleTile(
      title: Text(
        turma.disciplina!.nome!,
      ),
      subtitle: Text(_montaSubtitulo()),
      trailing: trailing,
    );
  }
}
