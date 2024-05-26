import 'package:calendar_view/calendar_view.dart';
import 'package:flutter/material.dart';
import 'package:grade/model/disciplina.dart';
import 'package:grade/model/turma.dart';
import 'package:grade/view/admin/admin_cursos.dart';
import 'package:grade/view/admin/admin_disciplinas.dart';
import 'package:grade/view/admin/admin_inicio.dart';
import 'package:grade/view/admin/admin_professores.dart';
import 'package:grade/view/admin/admin_turmas.dart';
import 'package:grade/view/page/anotacao.dart';
import 'package:grade/view/page/anotacao_disciplina.dart';
import 'package:grade/view/page/cadastro.dart';
import 'package:grade/view/page/calendario.dart';
import 'package:grade/view/page/grade.dart';
import 'package:grade/view/page/inicio.dart';
import 'package:grade/view/page/login.dart';
import 'package:grade/view/page/perfil.dart';
import 'package:grade/view/page/ppc.dart';
import 'package:grade/view/page/professores.dart';
import 'package:grade/view/page/professores_grade.dart';
import 'package:grade/view/page/saudacao.dart';
import 'package:grade/view/page/turma.dart';
import 'package:grade/view/page/turma_inscricao.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return CalendarControllerProvider(
      controller: EventController(),
      child: MaterialApp(
        title: 'Grade Comum',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
            colorScheme: const ColorScheme.light(
                primary: Colors.deepPurple, secondary: Colors.teal),
            cardTheme: CardTheme(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15)),
            ),
            popupMenuTheme: PopupMenuThemeData(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30)))),
        home: const SaudacaoPage(),
        routes: {
          LoginPage.rota: (context) => const LoginPage(),
          CadastroPage.rota: (context) => const CadastroPage(),
          InicioPage.rota: (context) => const InicioPage(),
          TurmaPage.rota: (context) => const TurmaPage(),
          PerfilPage.rota: (context) => const PerfilPage(),
          GradePage.rota: (context) => const GradePage(),
          AnotacaoPage.rota: (context) => const AnotacaoPage(),
          CalendarioPage.rota: (context) => const CalendarioPage(),
          AdminDisciplinasPage.rota: (context) => const AdminDisciplinasPage(),
          AdminInicioPage.rota: (context) => const AdminInicioPage(),
          PPCPage.rota: (context) => const PPCPage(),
          AdminCursosPage.rota: (context) => const AdminCursosPage(),
          AdminProfessoresPage.rota: (context) => const AdminProfessoresPage(),
          AdminTurmasPage.rota: (context) => const AdminTurmasPage(),
          ProfessoresPage.rota: (context) => const ProfessoresPage()
        },
        onGenerateRoute: (configuracoes) {
          if (configuracoes.name == TurmaInscricaoPage.rota) {
            var turmasInscritas = configuracoes.arguments as List<Turma>;
            return MaterialPageRoute(builder: (context) {
              return TurmaInscricaoPage(turmasInscritas: turmasInscritas);
            });
          }

          if (configuracoes.name == AnotacaoDisciplinaPage.rota) {
            var disciplina = configuracoes.arguments as Disciplina;
            return MaterialPageRoute(builder: (context) {
              return AnotacaoDisciplinaPage(disciplina: disciplina);
            });
          }
          if (configuracoes.name == ProfessoresGradePage.rota) {
            var idProfessor = configuracoes.arguments as int;
            return MaterialPageRoute(builder: (context) {
              return ProfessoresGradePage(
                idProfessor: idProfessor,
              );
            });
          }

          return MaterialPageRoute(builder: (context) {
            return const SaudacaoPage();
          });
        },
      ),
    );
  }
}
