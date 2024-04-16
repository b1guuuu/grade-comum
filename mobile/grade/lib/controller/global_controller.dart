import 'package:flutter/material.dart';
import 'package:grade/model/aluno.dart';

class GlobalController extends ChangeNotifier {
  static GlobalController instance = GlobalController();
  Aluno? aluno = null;
  static const String baseURL = 'http://192.168.0.10:3000';

  setAluno(Aluno? aluno) {
    this.aluno = aluno;
    notifyListeners();
  }
}
