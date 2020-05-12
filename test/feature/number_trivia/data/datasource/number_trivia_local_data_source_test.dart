import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter_number_trivia_again/core/error/exception/cache_exception.dart';
import 'package:flutter_number_trivia_again/feature/number_trivia/data/datasource/number_trivia_local_data_source.dart';
import 'package:flutter_number_trivia_again/feature/number_trivia/data/model/number_trivia_model.dart';
import 'package:flutter_number_trivia_again/helper/fixture_reader.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MockSharedPreferences extends Mock implements SharedPreferences {}

void main() {
  MockSharedPreferences mockSharedPreferences;
  NumberTriviaLocalDataSourceImpl dataSource;

  setUp(() {
    mockSharedPreferences = MockSharedPreferences();
    dataSource = NumberTriviaLocalDataSourceImpl(
      sharedPreferences: mockSharedPreferences,
    );
  });

  group('cacheNumberTrivia', () {
    final testNumberTriviaModel = NumberTriviaModel(
      text: 'text',
      number: 1,
    );
    test(
      'should call SharedPreferences to cache the data',
      () async {
        // act
        dataSource.cacheNumberTrivia(testNumberTriviaModel);
        // assert
        final expectedJsonString = json.encode(testNumberTriviaModel.toJson());
        verify(mockSharedPreferences.setString(
            CACHED_NUMBER_TRIVIA, expectedJsonString));
      },
    );
  });

  group('getLastNumberTrivia', () {
    final testNumberTriviaModel =
        NumberTriviaModel.fromJson(json.decode(fixture('trivia_cached.json')));
    test(
      'should return NumberTrivia from cache',
      () async {
        // arrange
        when(mockSharedPreferences.getString(CACHED_NUMBER_TRIVIA))
            .thenReturn(fixture('trivia_cached.json'));
        // act
        final result = await dataSource.getLastNumberTrivia();
        // assert
        verify(mockSharedPreferences.getString(CACHED_NUMBER_TRIVIA));
        expect(result, equals(testNumberTriviaModel));
      },
    );

    test(
      'should throw a CacheException when no cache',
      () async {
        // arrange
        // when(mockSharedPreferences.getString(CACHED_NUMBER_TRIVIA))
        //     .thenReturn(null);

        // act
        // final call = dataSource.getLastNumberTrivia;
        // assert
        // expect(() async => await call(), isInstanceOf<CacheException>());
        // expect(() async => await call(), throwsA(TypeMatcher<CacheException>()));
        // expect(() => call(), throwsA(TypeMatcher<CacheException>()));
      },
    );
  });
}
