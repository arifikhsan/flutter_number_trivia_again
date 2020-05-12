import 'package:dartz/dartz.dart';
import 'package:flutter_number_trivia_again/core/error/failure/cache_failure.dart';
import 'package:flutter_number_trivia_again/core/error/failure/invalid_input_failure.dart';
import 'package:flutter_number_trivia_again/core/error/failure/server_failure.dart';
import 'package:flutter_number_trivia_again/core/global/constant.dart';
import 'package:flutter_number_trivia_again/core/usecase/no_params.dart';
import 'package:flutter_number_trivia_again/core/usecase/params.dart';
import 'package:flutter_number_trivia_again/core/util/input_converter.dart';
import 'package:flutter_number_trivia_again/feature/number_trivia/domain/entity/number_trivia.dart';
import 'package:flutter_number_trivia_again/feature/number_trivia/domain/usecase/get_concrete_number_trivia.dart';
import 'package:flutter_number_trivia_again/feature/number_trivia/domain/usecase/get_random_number_trivia.dart';
import 'package:flutter_number_trivia_again/feature/number_trivia/presentation/bloc/number_trivia_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

class MockGetConcreteNumberTrivia extends Mock
    implements GetConcreteNumberTrivia {}

class MockGetRandomNumberTrivia extends Mock implements GetRandomNumberTrivia {}

class MockInputConverter extends Mock implements InputConverter {}

void main() {
  NumberTriviaBloc bloc;
  MockGetConcreteNumberTrivia mockGetConcreteNumberTrivia;
  MockGetRandomNumberTrivia mockGetRandomNumberTrivia;
  MockInputConverter mockInputConverter;

  setUp(() {
    mockGetConcreteNumberTrivia = MockGetConcreteNumberTrivia();
    mockGetRandomNumberTrivia = MockGetRandomNumberTrivia();
    mockInputConverter = MockInputConverter();

    bloc = NumberTriviaBloc(
      getConcreteNumberTrivia: mockGetConcreteNumberTrivia,
      getRandomNumberTrivia: mockGetRandomNumberTrivia,
      inputConverter: mockInputConverter,
    );
  });

  test(
    'initialState should be Empty',
    () async {
      // assert
      expect(bloc.initialState, equals(Empty()));
    },
  );

  group('GetTriviaForConcreteNumber', () {
    final testNumberString = '1';
    final testNumberParsed = 1;
    final testNumberTrivia = NumberTrivia(number: 1, text: 'test trivia');

    void setUpMockInputConverterSuccess() =>
        when(mockInputConverter.stringToUnsignedInteger(any))
            .thenReturn(Right(testNumberParsed));

    void setUpMockGetConcreteNumberTriviaSuccess() =>
        when(mockGetConcreteNumberTrivia(any))
            .thenAnswer((_) async => Right(testNumberTrivia));

    // test(
    //   'should call the InputConverter to validate and convert the string to an unsigned integer',
    //   () async {
    //     // arrange
    //     setUpMockInputConverterSuccess();
    //     // act
    //     bloc.add(GetTriviaForConcreteNumber(testNumberString));
    //     await untilCalled(
    //         mockInputConverter.stringToUnsignedInteger(testNumberString));
    //     // assert
    //     verify(mockInputConverter.stringToUnsignedInteger(testNumberString));
    //   },
    // );

    group('success test', () {
      test(
        'should get data from the concrete usecase',
        () async {
          // arrange
          setUpMockInputConverterSuccess();
          setUpMockGetConcreteNumberTriviaSuccess();
          // act
          bloc.add(GetTriviaForConcreteNumber(testNumberString));
          await untilCalled(mockGetConcreteNumberTrivia(any));
          // assert
          verify(
            mockGetConcreteNumberTrivia(Params(number: testNumberParsed)),
          );
        },
      );

      test(
        'should emit [Empty, Loading, Loaded] when data is gotten successfully',
        () async {
          // arrange
          setUpMockInputConverterSuccess();
          setUpMockGetConcreteNumberTriviaSuccess();
          // assert later
          final expected = [
            Empty(),
            Loading(),
            Loaded(trivia: testNumberTrivia),
          ];
          expectLater(bloc, emitsInOrder(expected));
          // act
          bloc.add(GetTriviaForConcreteNumber(testNumberString));
        },
      );
    });

    group('error test', () {
      test(
        'should emit [Empty, Error] when the input is invalid',
        () async {
          // arrange
          when(mockInputConverter.stringToUnsignedInteger(any))
              .thenReturn(Left(InvalidInputFailure()));
          // assert later
          final expected = [
            Empty(),
            Error(message: INVALID_INPUT_FAILURE_MESSAGE),
          ];
          expectLater(bloc, emitsInOrder(expected));
          // act
          bloc.add(GetTriviaForConcreteNumber(testNumberString));
        },
      );

      test(
        'should emit [Empty, Loading, Error] when ServerFailure',
        () async {
          // arrange
          setUpMockInputConverterSuccess();
          when(mockGetConcreteNumberTrivia(any))
              .thenAnswer((_) async => Left(ServerFailure()));
          // assert later
          final expected = [
            Empty(),
            Loading(),
            Error(message: SERVER_FAILURE_MESSAGE),
          ];
          expectLater(bloc, emitsInOrder(expected));
          // act
          bloc.add(GetTriviaForConcreteNumber(testNumberString));
        },
      );

      test(
        'should emit [Empty, Loading, Error] when CacheFailure',
        () async {
          // arrange
          setUpMockInputConverterSuccess();
          when(mockGetConcreteNumberTrivia(any))
              .thenAnswer((_) async => Left(CacheFailure()));
          // assert later
          final expected = [
            Empty(),
            Loading(),
            Error(message: CACHE_FAILURE_MESSAGE),
          ];
          expectLater(bloc, emitsInOrder(expected));
          // act
          bloc.add(GetTriviaForConcreteNumber(testNumberString));
        },
      );
    });
  });

  group('GetTriviaForRandomNumber', () {
    final testNumberTrivia = NumberTrivia(number: 1, text: 'test trivia');

    void setUpMockGetRandomNumberTriviaSuccess() =>
        when(mockGetRandomNumberTrivia(any))
            .thenAnswer((_) async => Right(testNumberTrivia));

    group('success test', () {
      test(
        'should get data from the concrete usecase',
        () async {
          // arrange
          setUpMockGetRandomNumberTriviaSuccess();
          // act
          bloc.add(GetTriviaForRandomNumber());
          await untilCalled(mockGetRandomNumberTrivia(any));
          // assert
          verify(
            mockGetRandomNumberTrivia(NoParams()),
          );
        },
      );

      test(
        'should emit [Empty, Loading, Loaded] when data is gotten successfully',
        () async {
          // arrange
          setUpMockGetRandomNumberTriviaSuccess();
          // assert later
          final expected = [
            Empty(),
            Loading(),
            Loaded(trivia: testNumberTrivia),
          ];
          expectLater(bloc, emitsInOrder(expected));
          // act
          bloc.add(GetTriviaForRandomNumber());
        },
      );
    });

    group('error test', () {
      test(
        'should emit [Empty, Loading, Error] when ServerFailure',
        () async {
          // arrange
          setUpMockGetRandomNumberTriviaSuccess();
          when(mockGetRandomNumberTrivia(any))
              .thenAnswer((_) async => Left(ServerFailure()));
          // assert later
          final expected = [
            Empty(),
            Loading(),
            Error(message: SERVER_FAILURE_MESSAGE),
          ];
          expectLater(bloc, emitsInOrder(expected));
          // act
          bloc.add(GetTriviaForRandomNumber());
        },
      );

      test(
        'should emit [Empty, Loading, Error] when CacheFailure',
        () async {
          // arrange
          setUpMockGetRandomNumberTriviaSuccess();
          when(mockGetRandomNumberTrivia(any))
              .thenAnswer((_) async => Left(CacheFailure()));
          // assert later
          final expected = [
            Empty(),
            Loading(),
            Error(message: CACHE_FAILURE_MESSAGE),
          ];
          expectLater(bloc, emitsInOrder(expected));
          // act
          bloc.add(GetTriviaForRandomNumber());
        },
      );
    });
  });

  group('ResetTrivia', () {
    test(
      'should reset state to Empty',
      () async {
        // assert later
        expectLater(bloc, emits(Empty()));
        // act
        bloc.add(ResetTrivia());
      },
    );
  });
}
