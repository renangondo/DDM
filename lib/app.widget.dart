import 'package:flutter/material.dart';
import 'package:projeto_ddm/app_controller.dart';
import 'package:projeto_ddm/pages/cadastro.dart';
import 'package:projeto_ddm/pages/home_page.dart';
import 'package:projeto_ddm/pages/listarAlunos.dart';
import 'package:projeto_ddm/pages/login.dart';
import 'package:projeto_ddm/repositorios/alunoRepository.dart';

class AppWidget extends StatelessWidget {
  final String title;

  const AppWidget({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: AppController.instance,
      builder: (context, child){ 
      return MaterialApp(
        title: title,
        theme: ThemeData(
          primarySwatch: Colors.blue,
          brightness: Brightness.light,
        ),
        darkTheme: ThemeData(
          primarySwatch: Colors.blue,
          brightness: Brightness.dark,
        ),
        themeMode: ThemeMode.system,
        initialRoute: '/listarAlunos',
        routes: {
          '/': (context) => LoginPage(),
          '/home': (context) => HomePage(),
          '/cadastro': (context) => Cadastro(repository: AlunoRepository(),),
          '/listarAlunos': (context) => ListaAlunosScreen(repository: AlunoRepository()),
        },
      ); 
    });
  }
}