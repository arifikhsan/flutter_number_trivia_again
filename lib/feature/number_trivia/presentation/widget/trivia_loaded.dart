import 'package:flutter/material.dart';
import 'package:flutter_number_trivia_again/feature/number_trivia/domain/entity/number_trivia.dart';
import 'package:flutter_number_trivia_again/feature/number_trivia/presentation/widget/core/trivia_white_board.dart';

class TriviaLoaded extends StatelessWidget {
  final NumberTrivia numberTrivia;

  const TriviaLoaded({
    Key key,
    @required this.numberTrivia,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TriviaWhiteBoard(
      edgeColor: Colors.green.shade300,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            numberTrivia.number.toString(),
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 8),
          Text(
            numberTrivia.text,
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
