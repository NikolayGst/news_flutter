import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:news_flutter/domain/models/entites/article_model.dart';

@immutable
abstract class HomeState extends Equatable {
  HomeState([List props = const []]) : super(props);
}

class InitialState extends HomeState {}

class DrawLoaderState extends HomeState {
  @override
  String toString() {
    return 'DrawLoaderState';
  }
}

class DrawCategoriesState extends HomeState {
  final Map<String, int> categoriesWithCount;

  DrawCategoriesState(this.categoriesWithCount) : super([categoriesWithCount]);

  @override
  String toString() {
    return 'DrawCategoriesState{categoriesWithCount: ${categoriesWithCount.length}}';
  }
}

class DrawArticlesState extends HomeState {
  final List<ArticleModel> articles;

  DrawArticlesState(this.articles) : super([articles]);

  @override
  String toString() {
    return 'DrawArticlesState{articles: ${articles.length}}';
  }
}
