import 'package:flutter/material.dart';
import 'package:news_flutter/domain/dataProviders/global/global_data_provider.dart';
import 'package:news_flutter/domain/dataProviders/local/local_data_provider.dart';
import 'package:news_flutter/domain/models/dataModels/get_articles_data_model.dart';
import 'package:news_flutter/domain/models/entites/article_model.dart';

abstract class Repository {
  Future<List<ArticleModel>> getArticles(GetArticlesDataModel model);

  Future<void> insertArticles(List<ArticleModel> articles);

  Future<void> deleteArticles();

  Stream<List<ArticleModel>> selectArticlesByCategory(String category);
}

class RepositoryImpl extends Repository {
  GlobalDataProvider _globalDataProvider;
  LocalDataProvider _localDataProvider;

  RepositoryImpl({
    @required GlobalDataProvider globalDataProvider,
    @required LocalDataProvider localDataProvider,
  })  : _globalDataProvider = globalDataProvider,
        _localDataProvider = localDataProvider;

  @override
  Future<List<ArticleModel>> getArticles(GetArticlesDataModel model) async {
    final result = await _globalDataProvider.getArticles(model);
    return result.articles
        .map((item) => item.copyWith(category: model.category))
        .where((item) => item.description != null && item.urlToImage != null)
        .toList();
  }

  @override
  Stream<List<ArticleModel>> selectArticlesByCategory(String category) {
    return _localDataProvider.selectArticlesByCategory(category);
  }

  @override
  Future<void> insertArticles(List<ArticleModel> articles) {
    return _localDataProvider.insertArticles(articles);
  }

  @override
  Future<void> deleteArticles() {
    return _localDataProvider.deleteArticles();
  }
}
