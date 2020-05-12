import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter_number_trivia_again/core/error/exception/server_exception.dart';
import 'package:flutter_number_trivia_again/feature/number_trivia/data/model/number_trivia_model.dart';
import 'package:http/http.dart';

abstract class NumberTriviaRemoteDataSource {
  Future<NumberTriviaModel> getConcreteNumberTrivia(int number);
  Future<NumberTriviaModel> getRandomNumberTrivia();
}

class NumbeTriviaRemoteDataSourceImpl implements NumberTriviaRemoteDataSource {
  final Client client;

  NumbeTriviaRemoteDataSourceImpl({
    @required this.client,
  });

  @override
  Future<NumberTriviaModel> getConcreteNumberTrivia(int number) =>
      _getTriviaFromUrl('http://numbersapi.com/$number');

  @override
  Future<NumberTriviaModel> getRandomNumberTrivia() =>
      _getTriviaFromUrl('http://numbersapi.com/random');

  Future<NumberTriviaModel> _getTriviaFromUrl(String url) async {
    final response = await client.get(
      url,
      headers: {
        'Content-Type': 'application/json',
      },
    );
    if (response.statusCode == 200) {
      return NumberTriviaModel.fromJson(json.decode(response.body));
    } else {
      throw ServerException();
    }
  }
}
