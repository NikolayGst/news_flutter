import 'package:news_flutter/domain/dataProviders/local/database/database.dart';
import 'package:news_flutter/domain/models/entites/article_model.dart';

abstract class LocalDataProvider {
  Future<void> insertArticles(List<ArticleModel> articles);
  Future<void> deleteArticles();
  Stream<List<ArticleModel>> selectArticlesByCategory(String category);
}

class LocalDataProviderImpl extends LocalDataProvider {
  Future<NewsDatabase> _database;

  //TODO сделать в виде зависимости
  LocalDataProviderImpl() {
    _database = $FloorNewsDatabase.databaseBuilder("news_database.db").build();
  }

  @override
  Future<void> insertArticles(List<ArticleModel> articles) async {
    var db = await _database;
    return db.articlesDao.insertArticles(articles);
  }

  @override
  Future<void> deleteArticles() async {
    var db = await _database;
    return db.articlesDao.deleteArticles();
  }

  @override
  Stream<List<ArticleModel>> selectArticlesByCategory(String category) async* {
    var db = await _database;
    yield* db.articlesDao.selectArticlesByCategoryAsStream(category);
  }
}
