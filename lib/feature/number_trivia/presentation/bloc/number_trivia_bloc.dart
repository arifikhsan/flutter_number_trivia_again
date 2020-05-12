import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_number_trivia_again/core/global/constant.dart';
import 'package:flutter_number_trivia_again/core/usecase/no_params.dart';
import 'package:flutter_number_trivia_again/core/usecase/params.dart';
import 'package:flutter_number_trivia_again/core/util/input_converter.dart';
import 'package:flutter_number_trivia_again/feature/number_trivia/domain/entity/number_trivia.dart';
import 'package:flutter_number_trivia_again/feature/number_trivia/domain/usecase/get_concrete_number_trivia.dart';
import 'package:flutter_number_trivia_again/feature/number_trivia/domain/usecase/get_random_number_trivia.dart';

part 'number_trivia_event.dart';
part 'number_trivia_state.dart';

class NumberTriviaBloc extends Bloc<NumberTriviaEvent, NumberTriviaState> {
  final GetConcreteNumberTrivia getConcreteNumberTrivia;
  final GetRandomNumberTrivia getRandomNumberTrivia;
  final InputConverter inputConverter;

  NumberTriviaBloc({
    @required this.getConcreteNumberTrivia,
    @required this.getRandomNumberTrivia,
    @required this.inputConverter,
  })  : assert(getConcreteNumberTrivia != null),
        assert(getRandomNumberTrivia != null),
        assert(inputConverter != null);

  @override
  NumberTriviaState get initialState => Empty();

  @override
  Stream<NumberTriviaState> mapEventToState(
    NumberTriviaEvent event,
  ) async* {
    if (event is GetTriviaForConcreteNumber) {
      final inputEither =
          inputConverter.stringToUnsignedInteger(event.numberString);
      yield* inputEither.fold(
        (failure) async* {
          yield Error(message: Constant.INVALID_INPUT_FAILURE_MESSAGE);
        },
        (integer) async* {
          yield Loading();
          final failureOrTrivia =
              await getConcreteNumberTrivia(Params(number: integer));
          yield* failureOrTrivia.fold((failure) async* {
            yield Error(message: Constant.SERVER_FAILURE_MESSAGE);
          }, (trivia) async* {
            yield Loaded(trivia: trivia);
          });
        },
      );
    } else if (event is GetTriviaForRandomNumber) {
      yield Loading();
      final failureOrTrivia = await getRandomNumberTrivia(NoParams());
      yield* failureOrTrivia.fold(
        (failure) async* {
          yield Error(message: Constant.SERVER_FAILURE_MESSAGE);
        },
        (trivia) async* {
          yield Loaded(trivia: trivia);
        },
      );
    } else if (event is ResetTrivia) {
      yield Empty();
    }
  }
}
