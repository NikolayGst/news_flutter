/*@Entity(tableName = "articles")
data class ArticleModel(
        @PrimaryKey
        val title: String,
        val author: String?,
        val description: String?,
        val url: String,
        val urlToImage: String?,
        val publishedAt: String,
        val category: String
)*/

import 'package:floor/floor.dart';

@Entity(tableName: "articles")
class ArticleModel {
  @PrimaryKey()
  final String title;
  @ColumnInfo(nullable: true)
  final String author;
  @ColumnInfo(nullable: true)
  final String description;
  final String url;
  @ColumnInfo(nullable: true)
  final String urlToImage;
  final String publishedAt;
  final String category;

  ArticleModel(this.title, this.author, this.description, this.url,
      this.urlToImage, this.publishedAt, this.category);

  factory ArticleModel.fromJson(Map<String, dynamic> map) {
    return new ArticleModel(
      map['title'] as String,
      map['author'] as String,
      map['description'] as String,
      map['url'] as String,
      map['urlToImage'] as String,
      map['publishedAt'] as String,
      map['category'] as String,
    );
  }

  ArticleModel copyWith({
    String title,
    String author,
    String description,
    String url,
    String urlToImage,
    String publishedAt,
    String category,
  }) {
    return new ArticleModel(
      title ?? this.title,
      author ?? this.author,
      description ?? this.description,
      url ?? this.url,
      urlToImage ?? this.urlToImage,
      publishedAt ?? this.publishedAt,
      category ?? this.category,
    );
  }
}
