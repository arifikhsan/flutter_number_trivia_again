import 'package:flutter/material.dart';
import 'package:flutter_number_trivia_again/core/di/injector.dart';
import 'package:flutter_number_trivia_again/core/ui/middleware.dart';
import 'package:flutter_number_trivia_again/feature/number_trivia/presentation/screen/number_trivia_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await setupLocator();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Number Trivia',
      home: Middleware(
        child: NumberTriviaScreen(),
      ),
    );
  }
}
