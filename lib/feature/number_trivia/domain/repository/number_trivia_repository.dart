import 'package:dartz/dartz.dart';
import 'package:flutter_number_trivia_again/core/error/failure/failure.dart';
import 'package:flutter_number_trivia_again/feature/number_trivia/domain/entity/number_trivia.dart';

abstract class NumberTriviaRepository {
  Future<Either<Failure, NumberTrivia>> getConcreteNumberTrivia(int number);
  Future<Either<Failure, NumberTrivia>> getRandomNumberTrivia();
}
