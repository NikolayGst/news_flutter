import 'package:news_flutter/domain/models/dataModels/get_articles_data_model.dart';
import 'package:news_flutter/domain/models/entites/article_model.dart';
import 'package:news_flutter/domain/repository/repository.dart';
import 'package:news_flutter/other/consts.dart';

import 'base_use_case.dart';

class GetAllArticlesUseCase extends BaseUseCase<void, void> {
  GetAllArticlesUseCase(Repository repository) : super(repository);

 @override
  Future<void> createRequest([void arg]) async {
   await repository.deleteArticles();

   final result = List<ArticleModel>();

   final articlesBusiness = await repository.getArticles(GetArticlesDataModel(Constants.BUSINESS));
   final articlesSports = await repository.getArticles(GetArticlesDataModel(Constants.SPORTS));
   final articlesScience = await repository.getArticles(GetArticlesDataModel(Constants.SCIENCE));
   final articlesTechnology = await repository.getArticles(GetArticlesDataModel(Constants.TECHNOLOGY));

   result.addAll(articlesBusiness);
   result.addAll(articlesSports);
   result.addAll(articlesScience);
   result.addAll(articlesTechnology);

   await repository.insertArticles(result);
   return;
  }
}
