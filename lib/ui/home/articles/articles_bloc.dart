import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:news_flutter/domain/dataProviders/global/global_data_provider.dart';
import 'package:news_flutter/domain/dataProviders/local/local_data_provider.dart';
import 'package:news_flutter/domain/repository/repository.dart';
import 'package:news_flutter/domain/useCases/select_articles_by_category_use_case.dart';

import './bloc.dart';

class ArticlesBloc extends Bloc<ArticlesEvent, ArticlesState> {

  SelectArticlesByCategoryUseCase _selectArticlesByCategoryUseCase;

  //TODO need dependency injection
  ArticlesBloc() {
    final global = GlobalDataProviderImpl();
    final local = LocalDataProviderImpl();
    final repository = RepositoryImpl(globalDataProvider: global, localDataProvider: local);

    _selectArticlesByCategoryUseCase = SelectArticlesByCategoryUseCase(repository);
  }

  @override
  ArticlesState get initialState => InitialArticlesState();

  @override
  Stream<ArticlesState> mapEventToState(ArticlesEvent event) async* {
    if (event is LoadArticles) {
      yield* mapLoadArticlesToState(event);
    }
  }

  Stream<ArticlesState> mapLoadArticlesToState(LoadArticles event) async* {
    //yield DrawLoaderState();
    final articles = await _selectArticlesByCategoryUseCase.createRequest(event.category).first;
    yield DrawArticlesState(articles);
  }
}
