import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_number_trivia_again/core/di/injector.dart';
import 'package:flutter_number_trivia_again/feature/number_trivia/presentation/bloc/number_trivia_bloc.dart';
import 'package:flutter_number_trivia_again/feature/number_trivia/presentation/widget/trivia_control.dart';
import 'package:flutter_number_trivia_again/feature/number_trivia/presentation/widget/trivia_display.dart';

class NumberTriviaScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Number Trivia'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: BlocProvider<NumberTriviaBloc>(
          create: (context) => locator<NumberTriviaBloc>(),
          child: Padding(
            padding: EdgeInsets.all(8),
            child: Column(
              children: <Widget>[
                TriviaDisplay(),
                TriviaControl(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
