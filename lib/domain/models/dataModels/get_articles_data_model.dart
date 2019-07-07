import 'package:equatable/equatable.dart';
import 'package:news_flutter/other/consts.dart';

class GetArticlesDataModel extends Equatable {

  final String category;
  int page;
  String country;
  int pageSize;

  GetArticlesDataModel(this.category, [this.page = 1, this.country = "ru", this.pageSize = 50])
      : super([category, page, country, pageSize]);

  Map<String, dynamic> toMap() {
    return {
      'category': this.category,
      'page': this.page,
      'country': this.country,
      'pageSize': this.pageSize,
      "apiKey": Constants.API_KEY
    };
  }

  @override
  String toString() {
    return "GetArticleDataModel { category: $category; }";
  }
}
