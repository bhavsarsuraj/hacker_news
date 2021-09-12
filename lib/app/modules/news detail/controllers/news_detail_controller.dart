import 'package:get/get.dart';
import 'package:hacker_news/app/data/models/news.dart';
import 'package:hacker_news/app/data/providers/news_provider.dart';
import 'package:hacker_news/app/utils/constants.dart';
import 'package:hacker_news/app/utils/snackbars.dart';
import 'package:meta/meta.dart';
import 'package:url_launcher/url_launcher.dart';

class NewsDetailController extends GetxController {
  final String objectId;
  NewsDetailController({@required this.objectId});

  final _apiClient = NewsApiClient();

  final _news = Rx<News>(null);
  News get news => this._news.value;
  set news(News value) => this._news.value = value;

  @override
  void onInit() {
    super.onInit();
    _getNews();
  }

  void _getNews() async {
    try {
      final detailedNews = await _apiClient.getFullNewsOf(objectId: objectId);
      if (detailedNews == null) return;
      news = detailedNews;
    } catch (e) {
      if (!Get.isSnackbarOpen)
        Get.showSnackbar(
          Snackbars.errorSnackBar(message: Strings.somethingWentWrong),
        );
    }
  }

  void didTapLink(String url) async {
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
