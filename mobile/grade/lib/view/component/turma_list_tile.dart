import 'package:flutter/material.dart';
import 'package:grade/model/turma.dart';

class TurmaListTile extends StatelessWidget {
  final Turma turma;
  final IconButton? iconButton;

  const TurmaListTile(
      {super.key, required this.turma, required this.iconButton});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(
        turma.disciplina!.nome!,
      ),
      subtitle: Text(
        '${turma.professor!.nome}\nDisciplina ${turma.numero}\nPeríodo ${turma.disciplina!.periodo}',
      ),
      trailing: iconButton,
    );
  }
}
