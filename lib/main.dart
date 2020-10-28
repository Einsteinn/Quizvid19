import 'package:flutter/material.dart';
import 'package:trabalho_final/view/quiz.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(CursoApp());
}

class CursoApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primaryColor: Colors.blue[300],
        accentColor: Colors.blue[300],
        buttonTheme: ButtonThemeData(
          buttonColor: Colors.blue[300],
          textTheme: ButtonTextTheme.primary,
        ),
      ),
      home: QuizPage(),
    );
  }
}
