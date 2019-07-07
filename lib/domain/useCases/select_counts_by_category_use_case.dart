
import 'package:news_flutter/domain/repository/repository.dart';
import 'package:news_flutter/domain/useCases/base_use_case.dart';
import 'package:news_flutter/other/consts.dart';

class SelectCountsByCategoryUseCase extends BaseUseCase<void, Map<String, int>> {

  SelectCountsByCategoryUseCase(Repository repository) : super(repository);

  @override
  Future<Map<String, int>> createRequest([void arg]) async {
    final articlesBusiness = await repository.selectArticlesByCategory(Constants.BUSINESS).first;
    final articlesSports = await repository.selectArticlesByCategory(Constants.SPORTS).first;
    final articlesScience = await repository.selectArticlesByCategory(Constants.SCIENCE).first;
    final articlesTechnology = await repository.selectArticlesByCategory(Constants.TECHNOLOGY).first;

    return {
      Constants.BUSINESS : articlesBusiness.length,
      Constants.SPORTS : articlesSports.length,
      Constants.SCIENCE : articlesScience.length,
      Constants.TECHNOLOGY : articlesTechnology.length,
    };
  }
}