import 'package:flutter/material.dart';

class TriviaWhiteBoard extends StatelessWidget {
  final Color edgeColor;
  final Widget child;

  const TriviaWhiteBoard({
    Key key,
    @required this.edgeColor,
    @required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      width: double.infinity,
      padding: EdgeInsets.all(8),
      child: child,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            blurRadius: 8,
            color: edgeColor,
          ),
        ],
      ),
    );
  }
}
