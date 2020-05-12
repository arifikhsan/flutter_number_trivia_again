import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_number_trivia_again/feature/number_trivia/presentation/bloc/number_trivia_bloc.dart';

class TriviaControl extends StatefulWidget {
  @override
  _TriviaControlState createState() => _TriviaControlState();
}

class _TriviaControlState extends State<TriviaControl> {
  final TextEditingController textEditingController = TextEditingController();
  void _dismissKeyboard() {
    FocusScope.of(context).unfocus();
  }

  void _dispatchRandom() {
    _dismissKeyboard();
    textEditingController.clear();
    BlocProvider.of<NumberTriviaBloc>(context).add(GetTriviaForRandomNumber());
  }

  void _dispatchConcrete() {
    _dismissKeyboard();
    BlocProvider.of<NumberTriviaBloc>(context)
        .add(GetTriviaForConcreteNumber(textEditingController.text));
    textEditingController.clear();
  }

  void _dispatchReset() {
    _dismissKeyboard();
    textEditingController.clear();
    BlocProvider.of<NumberTriviaBloc>(context).add(ResetTrivia());
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(8),
      child: Column(
        children: <Widget>[
          TextField(
            controller: textEditingController,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(hintText: 'Input a number'),
          ),
          SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              RaisedButton(
                onPressed: _dispatchConcrete,
                color: Colors.blue,
                child: Text(
                  'Get Concrete',
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
              ),
              RaisedButton(
                onPressed: _dispatchRandom,
                child: Text('Get Random'),
              ),
              FlatButton(
                onPressed: _dispatchReset,
                child: Text('Reset'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
