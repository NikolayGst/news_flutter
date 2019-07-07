import 'package:news_flutter/domain/repository/repository.dart';

abstract class BaseUseCase<Argument, Result> {
  final Repository repository;
  BaseUseCase(this.repository);

  Future<Result> createRequest([Argument arg]);
}

abstract class BaseUseCaseAsStream<Argument, Result> {
  final Repository repository;
  BaseUseCaseAsStream(this.repository);

  Stream<Result> createRequest([Argument arg]);
}
