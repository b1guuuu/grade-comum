import 'package:flutter/material.dart';
import 'package:grade/model/aluno.dart';

class GlobalController extends ChangeNotifier {
  static GlobalController instance = GlobalController();
  late Aluno aluno;

  setAluno(Aluno aluno) {
    this.aluno = aluno;
    notifyListeners();
  }
}
