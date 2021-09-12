import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hacker_news/app/data/models/news_response.dart';
import 'package:hacker_news/app/data/providers/news_provider.dart';
import 'package:hacker_news/app/utils/constants.dart';
import 'package:hacker_news/app/utils/snackbars.dart';

class HomeController extends GetxController {
  final _apiClient = NewsApiClient();

  final articles = List<Hit>.empty().obs;

  final scrollController = ScrollController();

  final _paginationLoading = false.obs;
  get paginationLoading => this._paginationLoading.value;
  set paginationLoading(value) => this._paginationLoading.value = value;

  final _loading = false.obs;
  bool get loading => this._loading.value;
  set loading(bool value) => this._loading.value = value;

  final _query = ''.obs;
  String get query => this._query.value;
  set query(String value) => this._query.value = value;

  int _page = 0;

  void onInit() {
    super.onInit();
    getNews();
    _addListener();
    debounce(_query, (_) => _didChangeQuery(),
        time: Duration(milliseconds: 500));
  }

  Future<void> getNews() async {
    try {
      articles.assignAll([]);
      loading = true;
      final newArticles = await _apiClient.fetchNewsFor(query: query);
      loading = false;
      if (newArticles == null) return;
      articles.addAll(newArticles);
    } catch (e) {
      loading = false;
    }
  }

  void _didChangeQuery() {
    _page = 0;
    getNews();
  }

  // Pagination Part :-

  void _addListener() {
    scrollController.addListener(() {
      if (scrollController.position.extentAfter < 500 && !paginationLoading) {
        _page++;
        _getNextPageNews();
      }
    });
  }

  void _getNextPageNews() async {
    try {
      paginationLoading = true;
      final newArticles =
          await _apiClient.fetchNewsFor(query: query, page: _page);
      paginationLoading = false;
      if (newArticles == null) return;
      articles.addAll(newArticles);
      update();
    } catch (e) {
      if (!Get.isSnackbarOpen)
        Get.showSnackbar(
          Snackbars.errorSnackBar(message: Strings.somethingWentWrong),
        );
      paginationLoading = false;
    }
  }

  void didTapSeeFullStory(String url) {
    _apiClient.launchNewsPage(url);
  }
}
