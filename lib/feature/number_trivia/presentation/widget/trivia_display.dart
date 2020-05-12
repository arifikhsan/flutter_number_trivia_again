import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_number_trivia_again/feature/number_trivia/presentation/bloc/number_trivia_bloc.dart';
import 'package:flutter_number_trivia_again/feature/number_trivia/presentation/widget/trivia_error.dart';
import 'package:flutter_number_trivia_again/feature/number_trivia/presentation/widget/trivia_loaded.dart';
import 'package:flutter_number_trivia_again/feature/number_trivia/presentation/widget/trivia_loading.dart';
import 'package:flutter_number_trivia_again/feature/number_trivia/presentation/widget/trivia_message.dart';

class TriviaDisplay extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NumberTriviaBloc, NumberTriviaState>(
      builder: (BuildContext context, NumberTriviaState state) {
        if (state is Empty) {
          return TriviaMessage(message: 'Start Searching!');
        } else if (state is Loading) {
          return TriviaLoading();
        } else if (state is Loaded) {
          return TriviaLoaded(numberTrivia: state.trivia);
        } else if (state is Error) {
          return TriviaError(message: state.message);
        } else {
          return TriviaMessage(message: 'What\'s happen?!');
        }
      },
    );
  }
}
