import 'package:equatable/equatable.dart';
import 'package:news_flutter/domain/models/entites/article_model.dart';

class ArticlesWrapperModel extends Equatable {
  final String status;
  final int totalResults;
  final List<ArticleModel> articles;

  ArticlesWrapperModel({this.status, this.totalResults, this.articles})
      : super([status, totalResults, articles]);

  factory ArticlesWrapperModel.fromJson(Map<String, dynamic> json) {
    final articles = (json['articles'] as List).map((item) => ArticleModel.fromJson(item)).toList();
    return new ArticlesWrapperModel(
        status: json['status'] as String,
        totalResults: json['totalResults'] as int,
        articles: articles);
  }
}
