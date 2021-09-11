import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hacker_news/app/data/models/news_response.dart';
import 'package:hacker_news/app/data/providers/news_provider.dart';

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

  void getNews() async {
    try {
      articles.assignAll([]);
      loading = true;
      final newArticles = await _apiClient.fetchNewsFor(query: query);
      loading = false;
      if (newArticles == null) return;
      articles.addAll(newArticles);
    } catch (e) {
      print(e);
      loading = false;
    }
  }

  void _didChangeQuery() {
    if (query.trim().isEmpty) return;
    _page = 0;
    getNews();
  }

  // Pagination Part :-

  void _addListener() {
    scrollController.addListener(() {
      if (scrollController.position.maxScrollExtent ==
              scrollController.position.pixels &&
          !loading) {
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
      print(e);
      paginationLoading = false;
    }
  }
}
