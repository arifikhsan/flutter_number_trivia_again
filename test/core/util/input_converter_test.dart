import 'package:dartz/dartz.dart';
import 'package:flutter_number_trivia_again/core/error/failure/invalid_input_failure.dart';
import 'package:flutter_number_trivia_again/core/util/input_converter.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  InputConverter inputConverter;

  setUp(() {
    inputConverter = InputConverter();
  });

  group('string to unsigned int', () {
    group('pass test', () {
      test(
        'should return an integer when the string represents an unsighed integer',
        () async {
          // arrange
          final string = '123';
          // act
          final result = inputConverter.stringToUnsignedInteger(string);
          // assert
          expect(result, Right(123));
        },
      );
    });

    group('fail test', () {
      test(
        'should return a Failure when string is not an integer',
        () async {
          // arrange
          final string = 'abc';
          // act
          final result = inputConverter.stringToUnsignedInteger(string);
          // assert
          expect(result, Left(InvalidInputFailure()));
        },
      );

      test(
        'should return a Failure when the string is a negative integer',
        () async {
          // arrange
          final string = '-123';
          // act
          final result = inputConverter.stringToUnsignedInteger(string);
          // assert
          expect(result, Left(InvalidInputFailure()));
        },
      );
    });
  });
}
