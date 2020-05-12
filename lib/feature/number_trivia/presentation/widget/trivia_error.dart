import 'package:flutter/material.dart';
import 'package:flutter_number_trivia_again/feature/number_trivia/presentation/widget/core/trivia_white_board.dart';

class TriviaError extends StatelessWidget {
  final String message;

  const TriviaError({
    Key key,
    @required this.message,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TriviaWhiteBoard(
      edgeColor: Colors.red.shade300,
      child: Center(
        child: Text(
          message,
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
