import 'dart:async';
import 'package:bloc/bloc.dart';
import './bloc.dart';
import 'package:news_flutter/domain/dataProviders/global/global_data_provider.dart';
import 'package:news_flutter/domain/dataProviders/local/local_data_provider.dart';
import 'package:news_flutter/domain/repository/repository.dart';
import 'package:news_flutter/domain/useCases/get_all_articles_use_case.dart';

class SplashBloc extends Bloc<SplashEvent, SplashState> {
  @override
  SplashState get initialState => InitialState();

  GetAllArticlesUseCase _getAllArticlesUseCase;

  //TODO need dependency injection
  SplashBloc() {
    final global = GlobalDataProviderImpl();
    final local = LocalDataProviderImpl();
    final repository = RepositoryImpl(globalDataProvider: global, localDataProvider: local);

    _getAllArticlesUseCase = GetAllArticlesUseCase(repository);
  }

  @override
  Stream<SplashState> mapEventToState(
    SplashEvent event,
  ) async* {
    if (event is FetchArticles) {
      yield* mapFetchArticlesToState();
    }
  }

  Stream<SplashState> mapFetchArticlesToState() async* {
    try {
      await Future.delayed(Duration(seconds: 2));
      await _getAllArticlesUseCase.createRequest();
      yield DrawMainScreenState();
    } on Exception catch (e) {
      yield DrawErrorState(e);
    }
  }
}
