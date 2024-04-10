import 'package:flutter/material.dart';
import 'package:grade/model/horario.dart';

class TabelaGrade extends StatefulWidget {
  final List<List<String>> grade;
  final List<String> dias;

  const TabelaGrade({super.key, required this.grade, required this.dias});

  @override
  State<TabelaGrade> createState() {
    return TabelaGradeState();
  }
}

class TabelaGradeState extends State<TabelaGrade> {
  @override
  Widget build(BuildContext context) {
    return InteractiveViewer(
      constrained: false,
      child: DataTable(
          columns: ['Horário', ...widget.dias]
              .map((tituloColuna) => DataColumn(label: Text(tituloColuna)))
              .toList(),
          rows: widget.grade
              .map((linha) => DataRow(
                  cells:
                      linha.map((celula) => DataCell(Text(celula))).toList()))
              .toList()),
    );
  }
}
