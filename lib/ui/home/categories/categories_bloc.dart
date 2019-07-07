import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:news_flutter/domain/dataProviders/global/global_data_provider.dart';
import 'package:news_flutter/domain/dataProviders/local/local_data_provider.dart';
import 'package:news_flutter/domain/repository/repository.dart';
import 'package:news_flutter/domain/useCases/select_counts_by_category_use_case.dart';

import './bloc.dart';

class CategoriesBloc extends Bloc<CategoriesEvent, CategoriesState> {

  SelectCountsByCategoryUseCase _selectCountsByCategoryUseCase;

  //TODO need dependency injection
  CategoriesBloc() {
    final global = GlobalDataProviderImpl();
    final local = LocalDataProviderImpl();
    final repository = RepositoryImpl(globalDataProvider: global, localDataProvider: local);

    _selectCountsByCategoryUseCase = SelectCountsByCategoryUseCase(repository);
  }

  @override
  CategoriesState get initialState => InitialCategoriesState();

  @override
  Stream<CategoriesState> mapEventToState(CategoriesEvent event,) async* {
    if (event is LoadCategories) {
      yield* mapLoadCategoriesToState();
    }
  }

  Stream<CategoriesState> mapLoadCategoriesToState() async* {
    final categories = await _selectCountsByCategoryUseCase.createRequest();
    yield DrawCategoriesState(categories);
  }
}
