import 'package:dartz/dartz.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_number_trivia_again/core/error/failure/failure.dart';
import 'package:flutter_number_trivia_again/core/usecase/params.dart';
import 'package:flutter_number_trivia_again/core/usecase/usecase.dart';
import 'package:flutter_number_trivia_again/feature/number_trivia/domain/entity/number_trivia.dart';
import 'package:flutter_number_trivia_again/feature/number_trivia/domain/repository/number_trivia_repository.dart';

class GetConcreteNumberTrivia implements Usecase<NumberTrivia, Params> {
  final NumberTriviaRepository repository;

  GetConcreteNumberTrivia({
    @required this.repository,
  });

  @override
  Future<Either<Failure, NumberTrivia>> call(Params params) async {
    return await repository.getConcreteNumberTrivia(params.number);
  }
}
