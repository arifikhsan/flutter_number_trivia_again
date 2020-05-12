import 'package:flutter/material.dart';
import 'package:flutter_number_trivia_again/feature/number_trivia/presentation/widget/core/trivia_white_board.dart';

class TriviaLoading extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return TriviaWhiteBoard(
      edgeColor: Colors.blue.shade300,
      child: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
