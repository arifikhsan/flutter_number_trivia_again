import 'package:dartz/dartz.dart';
import 'package:flutter_number_trivia_again/core/usecase/no_params.dart';
import 'package:flutter_number_trivia_again/feature/number_trivia/domain/entity/number_trivia.dart';
import 'package:flutter_number_trivia_again/feature/number_trivia/domain/repository/number_trivia_repository.dart';
import 'package:flutter_number_trivia_again/feature/number_trivia/domain/usecase/get_random_number_trivia.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

class MockNumberTriviaRepository extends Mock
    implements NumberTriviaRepository {}

void main() {
  GetRandomNumberTrivia usecase;
  MockNumberTriviaRepository mockNumberTriviaRepository;

  setUp(() {
    mockNumberTriviaRepository = MockNumberTriviaRepository();
    usecase = GetRandomNumberTrivia(repository: mockNumberTriviaRepository);
  });

  final testNumberTrivia = NumberTrivia(text: 'test', number: 1);

  test(
    'should get random from repository',
    () async {
      // arrange
      when(mockNumberTriviaRepository.getRandomNumberTrivia())
          .thenAnswer((_) async => Right(testNumberTrivia));
      // act
      final result = await usecase(NoParams());
      // assert
      expect(result, Right(testNumberTrivia));
      verify(mockNumberTriviaRepository.getRandomNumberTrivia());
      verifyNoMoreInteractions(mockNumberTriviaRepository);
    },
  );
}
