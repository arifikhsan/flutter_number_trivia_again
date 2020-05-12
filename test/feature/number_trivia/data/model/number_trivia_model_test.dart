import 'dart:convert';

import 'package:flutter_number_trivia_again/feature/number_trivia/data/model/number_trivia_model.dart';
import 'package:flutter_number_trivia_again/feature/number_trivia/domain/entity/number_trivia.dart';
import 'package:flutter_number_trivia_again/helper/fixture_reader.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  final testNumberTrivia = NumberTriviaModel(text: 'test', number: 1);
  test(
    'should be a subclass of NumberTrivia entity',
    () async {
      // assert
      expect(testNumberTrivia, isA<NumberTrivia>());
    },
  );

  group('fromJson', () {
    group('number is integer', () {
      test(
        'should return a valid model',
        () async {
          // arrange
          final Map<String, dynamic> jsonMap =
              json.decode(fixture('trivia.json'));
          // act
          final result = NumberTriviaModel.fromJson(jsonMap);
          // assert
          expect(result, testNumberTrivia);
        },
      );
    });

    group('number is double', () {
      test(
        'should return a valid model',
        () async {
          // arrange
          final Map<String, dynamic> jsonMap =
              json.decode(fixture('trivia_double.json'));
          // act
          final result = NumberTriviaModel.fromJson(jsonMap);
          // assert
          expect(result, testNumberTrivia);
        },
      );
    });
  });

  group('toJson', () {
    test(
      'should return a JSON map containing the proper data',
      () async {
        // arrange
        final result = testNumberTrivia.toJson();
        // assert
        final expected = {
          'text': 'test',
          'number': 1,
        };
        expect(result, expected);
      },
    );
  });
}
