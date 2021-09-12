import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:hacker_news/app/data/models/news.dart';
import 'package:hacker_news/app/data/models/news_response.dart';
import 'package:hacker_news/app/utils/snackbars.dart';
import 'package:meta/meta.dart';
import 'package:hacker_news/app/utils/constants.dart';
import 'package:url_launcher/url_launcher.dart';

class NewsApiClient {
  Dio _dio;

  NewsApiClient() {
    final options = BaseOptions(
      baseUrl: URLs.base,
      receiveTimeout: 50000,
      sendTimeout: 50000,
      connectTimeout: 50000,
      responseType: ResponseType.json,
    );
    _dio = Dio(options);
  }

  Future<List<Hit>> fetchNewsFor({String query = '', int page = 0}) async {
    try {
      final path = URLs.searchPath;
      final queryParameters = {'query': query, 'page': page};
      final response = await _dio.get(path, queryParameters: queryParameters);
      if (response != null) {
        final newsResponse = NewsResponse.fromMap(response.data);
        // Remove all news which doesn't have tile of news or comments
        return newsResponse.hits
            .where((hit) => hit.title != null && hit.numComments != null)
            .toList();
      }
      return [];
    } catch (e) {
      throw e;
    }
  }

  Future<News> getFullNewsOf({@required String objectId}) async {
    try {
      final path = URLs.itemsPath(objectId);
      final response = await _dio.get(path);
      if (response != null) return News.fromMap(response.data);
      return null;
    } catch (e) {
      Get.showSnackbar(
        Snackbars.errorSnackBar(message: Strings.somethingWentWrong),
      );
      return null;
    }
  }

  void launchNewsPage(String url) async {
    try {
      if (await canLaunch(url)) {
        await launch(url);
      } else {
        if (!Get.isSnackbarOpen)
          Get.showSnackbar(
            Snackbars.errorSnackBar(message: Strings.cannotLaunchURL),
          );
      }
    } catch (e) {
      if (!Get.isSnackbarOpen)
        Get.showSnackbar(
          Snackbars.errorSnackBar(message: Strings.somethingWentWrong),
        );
    }
  }
}
