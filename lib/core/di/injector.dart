import 'package:data_connection_checker/data_connection_checker.dart';
import 'package:flutter_number_trivia_again/core/network/network_info.dart';
import 'package:flutter_number_trivia_again/core/network/network_info_impl.dart';
import 'package:flutter_number_trivia_again/core/util/input_converter.dart';
import 'package:flutter_number_trivia_again/feature/number_trivia/data/datasource/number_trivia_local_data_source.dart';
import 'package:flutter_number_trivia_again/feature/number_trivia/data/datasource/number_trivia_remote_data_source.dart';
import 'package:flutter_number_trivia_again/feature/number_trivia/data/repository/number_trivia_repository_impl.dart';
import 'package:flutter_number_trivia_again/feature/number_trivia/domain/repository/number_trivia_repository.dart';
import 'package:flutter_number_trivia_again/feature/number_trivia/domain/usecase/get_concrete_number_trivia.dart';
import 'package:flutter_number_trivia_again/feature/number_trivia/domain/usecase/get_random_number_trivia.dart';
import 'package:flutter_number_trivia_again/feature/number_trivia/presentation/bloc/number_trivia_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';

GetIt locator = GetIt.instance;

Future<void> setupLocator() async {
  //* Features - Number Trivia
  locator.registerFactory(
    () => NumberTriviaBloc(
      getConcreteNumberTrivia: locator(),
      getRandomNumberTrivia: locator(),
      inputConverter: locator(),
    ),
  );

  //* Usecases
  locator.registerLazySingleton(() => GetConcreteNumberTrivia(repository: locator()));
  locator.registerLazySingleton(() => GetRandomNumberTrivia(repository: locator()));

  //* Repository
  locator.registerLazySingleton<NumberTriviaRepository>(
    () => NumberTriviaRepositoryImpl(
      remoteDataSource: locator(),
      localDataSource: locator(),
      networkInfo: locator(),
    ),
  );

  //* Data sources
  locator.registerLazySingleton<NumberTriviaRemoteDataSource>(
    () => NumbeTriviaRemoteDataSourceImpl(client: locator()),
  );
  locator.registerLazySingleton<NumberTriviaLocalDataSource>(
    () => NumberTriviaLocalDataSourceImpl(sharedPreferences: locator()),
  );

  //* Core
  locator.registerLazySingleton(() => InputConverter());
  locator.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(locator()));

  //* External
  final SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
  locator.registerLazySingleton(() => sharedPreferences);
  locator.registerLazySingleton(() => Client());
  locator.registerLazySingleton(() => DataConnectionChecker());
}
