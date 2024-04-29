import 'package:flutter/material.dart';
import 'package:quickalert/models/quickalert_type.dart';
import 'package:quickalert/widgets/quickalert_dialog.dart';

class AlertasPersonalizados {
  static void show(BuildContext context, Exception e) {
    determinarAlerta(e, context);
  }
}

void determinarAlerta(Exception e, BuildContext context) {
  if (e.toString().contains("No route to host") ||
      e.toString().contains("Connection timed out")) {
    QuickAlert.show(
        context: context,
        type: QuickAlertType.warning,
        title: "Sem conexão com o servidor",
        text: "Verifique as configurações e tente novamente");
    return;
  }

  QuickAlert.show(
      context: context,
      type: QuickAlertType.error,
      title: 'Não foi possível fazer login',
      text: 'Verifique os dados informados');
}
