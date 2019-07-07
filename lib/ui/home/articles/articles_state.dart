import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:news_flutter/domain/models/entites/article_model.dart';

@immutable
abstract class ArticlesState extends Equatable {
  ArticlesState([List props = const []]) : super(props);
}

class InitialArticlesState extends ArticlesState {}

class DrawArticlesState extends ArticlesState {
  final List<ArticleModel> articles;

  DrawArticlesState(this.articles) : super([articles]);

  @override
  String toString() {
    return 'DrawArticlesState{articles: ${articles.length}}';
  }
}
