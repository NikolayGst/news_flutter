import 'package:dio/dio.dart';
import 'package:news_flutter/domain/models/dataModels/get_articles_data_model.dart';
import 'package:news_flutter/domain/models/responseModels/articles_wrapper_model.dart';
import 'package:news_flutter/other/consts.dart';

abstract class GlobalDataProvider {
  Future<ArticlesWrapperModel> getArticles(GetArticlesDataModel model);
}

class GlobalDataProviderImpl extends GlobalDataProvider {
  Dio _client;

  //TODO сделать в виде зависимости
  GlobalDataProviderImpl() {
    BaseOptions options = new BaseOptions(
      baseUrl: Constants.BASE_URL,
      connectTimeout: 5000,
      receiveTimeout: 3000,
    );
    _client = new Dio(options);
    _client.interceptors.add(LogInterceptor(responseBody: false));
  }

  @override
  Future<ArticlesWrapperModel> getArticles(GetArticlesDataModel model) async {
    final response = await _client.get("/top-headlines", queryParameters: model.toMap());

    if (response.statusCode == 200) {
      final result = response.data as Map<String, dynamic>;
      return ArticlesWrapperModel.fromJson(result);
    } else {
      throw Exception("Request failed with status: ${response.statusCode}.");
    }
  }
}
