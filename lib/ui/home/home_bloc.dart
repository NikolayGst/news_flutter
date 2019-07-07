import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:news_flutter/domain/dataProviders/global/global_data_provider.dart';
import 'package:news_flutter/domain/dataProviders/local/local_data_provider.dart';
import 'package:news_flutter/domain/repository/repository.dart';
import './bloc.dart';
import 'package:news_flutter/domain/useCases/select_articles_by_category_use_case.dart';
import 'package:news_flutter/domain/useCases/select_counts_by_category_use_case.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {

  SelectArticlesByCategoryUseCase _selectArticlesByCategoryUseCase;
  SelectCountsByCategoryUseCase _selectCountsByCategoryUseCase;

  //TODO need dependency injection
  HomeBloc() {
    final global = GlobalDataProviderImpl();
    final local = LocalDataProviderImpl();
    final repository = RepositoryImpl(globalDataProvider: global, localDataProvider: local);

   _selectArticlesByCategoryUseCase = SelectArticlesByCategoryUseCase(repository);
    _selectCountsByCategoryUseCase = SelectCountsByCategoryUseCase(repository);
  }

  @override
  HomeState get initialState => InitialState();

  @override
  Stream<HomeState> mapEventToState(HomeEvent event,) async* {
    if (event is LoadCategories) {
      yield* mapLoadCategoriesToState();
    } else if (event is LoadArticles) {
      yield* mapLoadArticlesToState(event);
    }
  }

  Stream<HomeState> mapLoadArticlesToState(LoadArticles event) async* {
    yield DrawLoaderState();
    final articles = await _selectArticlesByCategoryUseCase.createRequest(event.category).first;
    yield DrawArticlesState(articles);
  }

  Stream<HomeState> mapLoadCategoriesToState() async* {
    final categories = await _selectCountsByCategoryUseCase.createRequest();
    yield DrawCategoriesState(categories);
  }
}
