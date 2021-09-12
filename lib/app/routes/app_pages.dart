import 'package:get/get.dart';
import 'package:hacker_news/app/modules/home/bindings/home_binding.dart';
import 'package:hacker_news/app/modules/home/views/home_view.dart';
import 'package:hacker_news/app/modules/news%20detail/bindings/news_detail_binding.dart';
import 'package:hacker_news/app/modules/news%20detail/views/news_detail_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.HOME;

  static final routes = [
    GetPage(
      name: _Paths.HOME,
      page: () => HomeView(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: _Paths.NEWS_DETAIL,
      page: () => NewsDetailView(),
      binding: NewsDetailBinding(),
    ),
  ];
}
