import 'package:floor/floor.dart';
import 'package:news_flutter/domain/models/entites/article_model.dart';


@dao
abstract class ArticlesDao {
  @Insert(onConflict: OnConflictStrategy.REPLACE)
  Future<void> insertArticles(List<ArticleModel> articles);

  @Query("DELETE FROM articles")
  Future<void> deleteArticles();

  @Query("SELECT * from articles WHERE category = :category")
  Stream<List<ArticleModel>> selectArticlesByCategoryAsStream(String category);
}
