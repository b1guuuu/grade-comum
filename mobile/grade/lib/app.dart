import 'package:flutter/material.dart';
import 'package:grade/view/page/cadastro.dart';
import 'package:grade/view/page/inicio.dart';
import 'package:grade/view/page/login.dart';
import 'package:grade/view/page/saudacao.dart';
import 'package:grade/view/page/turma.dart';
import 'package:grade/view/page/turma_inscricao.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Grade Comum',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          colorScheme: const ColorScheme.light(
              primary: Colors.deepPurple, secondary: Colors.teal),
          cardTheme: CardTheme(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
          ),
          popupMenuTheme: PopupMenuThemeData(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30)))),
      home: const SaudacaoPage(),
      onGenerateRoute: (configuracoes) {
        if (configuracoes.name == LoginPage.rota) {
          return MaterialPageRoute(builder: (context) {
            return const LoginPage();
          });
        }

        if (configuracoes.name == CadastroPage.rota) {
          return MaterialPageRoute(builder: (context) {
            return const CadastroPage();
          });
        }

        if (configuracoes.name == InicioPage.rota) {
          return MaterialPageRoute(builder: (context) {
            return const InicioPage();
          });
        }

        if (configuracoes.name == TurmaPage.rota) {
          return MaterialPageRoute(builder: (context) {
            return const TurmaPage();
          });
        }

        if (configuracoes.name == TurmaInscricaoPage.rota) {
          return MaterialPageRoute(builder: (context) {
            return const TurmaInscricaoPage();
          });
        }

        return MaterialPageRoute(builder: (context) {
          return const SaudacaoPage();
        });
      },
    );
  }
}
