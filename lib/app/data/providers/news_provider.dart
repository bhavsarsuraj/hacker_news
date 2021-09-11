import 'package:dio/dio.dart';
import 'package:hacker_news/app/data/models/news_response.dart';
import 'package:hacker_news/app/utils/constants.dart';

class NewsApiClient {
  Dio _dio;

  NewsApiClient() {
    final options = BaseOptions(
      baseUrl: URLs.base,
      receiveTimeout: 5000,
      sendTimeout: 5000,
      connectTimeout: 5000,
      responseType: ResponseType.json,
    );
    _dio = Dio(options);
  }

  Future<List<Hit>> fetchNewsFor({String query = '', int page = 0}) async {
    try {
      final path = URLs.searchPath;
      final queryParameters = {'query': query, 'page': page};
      final response = await _dio.get(path, queryParameters: queryParameters);
      final newsResponse = NewsResponse.fromMap(response.data);
      return newsResponse.hits;
    } catch (e) {
      print(e);
      return [];
    }
  }
}
