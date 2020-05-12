import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_number_trivia_again/core/error/failure/cache_failure.dart';
import 'package:flutter_number_trivia_again/core/error/failure/failure.dart';
import 'package:flutter_number_trivia_again/core/error/failure/server_failure.dart';
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
          yield Error(message: INVALID_INPUT_FAILURE_MESSAGE);
        },
        (integer) async* {
          yield Loading();

          final failureOrTrivia =
              await getConcreteNumberTrivia(Params(number: integer));
          yield* _eitherLoadedOrErrorState(failureOrTrivia);
          // yield* failureOrTrivia.fold((failure) async* {
          //   yield Error(message: SERVER_FAILURE_MESSAGE);
          // }, (trivia) async* {
          //   yield Loaded(trivia: trivia);
          // });
        },
      );
    } else if (event is GetTriviaForRandomNumber) {
      yield Loading();
      final failureOrTrivia = await getRandomNumberTrivia(NoParams());
      yield* _eitherLoadedOrErrorState(failureOrTrivia);
      // yield* failureOrTrivia.fold(
      //   (failure) async* {
      //     yield Error(message: SERVER_FAILURE_MESSAGE);
      //   },
      //   (trivia) async* {
      //     yield Loaded(trivia: trivia);
      //   },
      // );
    } else if (event is ResetTrivia) {
      yield Empty();
    }
  }

  Stream<NumberTriviaState> _eitherLoadedOrErrorState(
    Either<Failure, NumberTrivia> failureOrTrivia,
  ) async* {
    yield failureOrTrivia.fold(
      (failure) => Error(message: _mapFailureToMessage(failure)),
      (trivia) => Loaded(trivia: trivia),
    );
  }

  String _mapFailureToMessage(Failure failure) {
    switch (failure.runtimeType) {
      case ServerFailure:
        return SERVER_FAILURE_MESSAGE;
        break;
      case CacheFailure:
        return CACHE_FAILURE_MESSAGE;
        break;
      default:
        return 'Unexpected error';
    }
  }
}
