import 'package:news_flutter/domain/models/entites/article_model.dart';
import 'package:news_flutter/domain/repository/repository.dart';
import 'package:news_flutter/domain/useCases/base_use_case.dart';

class SelectArticlesByCategoryUseCase extends BaseUseCaseAsStream<String, List<ArticleModel>> {
  SelectArticlesByCategoryUseCase(Repository repository) : super(repository);

  @override
  Stream<List<ArticleModel>> createRequest([String arg]) {
    return repository.selectArticlesByCategory(arg);
  }
}
