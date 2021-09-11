import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hacker_news/app/data/models/news_response.dart';
import 'package:hacker_news/app/utils/constants.dart';
import 'package:jiffy/jiffy.dart';

import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: GestureDetector(
          onTap: _didTapHome,
          child: Text(
            Strings.appTitle,
            style: TextStyle(color: Colors.black),
          ),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: _buildBody(),
    );
  }

  Widget _buildTextField() {
    return CupertinoSearchTextField(
      onChanged: (String val) {
        controller.query = val;
      },
      placeholder: Strings.searchHint,
    );
  }

  Widget _buildBody() {
    return Obx(() => SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: Dimensions.horizntalPadding,
            ),
            child: Column(
              children: [
                _buildTextField(),
                _buildNewsList(),
              ],
            ),
          ),
        ));
  }

  Widget _buildNewsList() {
    return controller.loading
        ? Column(
            children: [
              SizedBox(height: 32),
              CircularProgressIndicator(),
            ],
          )
        : controller.articles.isNotEmpty
            ? Expanded(
                child: ListView(
                  controller: controller.scrollController,
                  children: [
                    ListView.separated(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      padding: EdgeInsets.symmetric(
                        vertical: Dimensions.verticalPadding,
                      ),
                      itemBuilder: (context, index) => _buildArticle(
                        controller.articles[index],
                      ),
                      separatorBuilder: (context, index) => _getSubSizedBox(),
                      itemCount: controller.articles.length,
                    ),
                    controller.paginationLoading
                        ? SizedBox(
                            height: 60,
                            child: Center(child: CircularProgressIndicator()),
                          )
                        : Container(),
                  ],
                ),
              )
            : _buildEmptyView();
  }

  Widget _buildArticle(Hit article) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8, vertical: 6),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.grey[200], width: 1),
        color: Colors.white,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            article.title ?? Strings.emptyString,
            style: Theme.of(Get.context).textTheme.headline6,
          ),
          _getSizedBox(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                article.createdAt != null
                    ? Jiffy(article.createdAt).format('dd MMM yyyy')
                    : Strings.emptyString,
                style: Theme.of(Get.context).textTheme.caption,
              ),
              Text(
                article.createdAt != null
                    ? Jiffy(article.createdAt).format('hh:mm a')
                    : Strings.emptyString,
                style: Theme.of(Get.context).textTheme.caption,
              )
            ],
          ),
          _getSubSizedBox(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                (article.points?.toString() ?? Strings.emptyString) +
                    ' ' +
                    Strings.points,
                style: Theme.of(Get.context).textTheme.caption,
              ),
              Spacer(),
              Icon(Icons.comment, size: 14),
              SizedBox(width: 4),
              Text(
                (article.numComments?.toString() ?? Strings.emptyString),
                style: Theme.of(Get.context).textTheme.caption,
              )
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildEmptyView() {
    return Expanded(
      child: ListView(
        padding: const EdgeInsets.symmetric(vertical: 20),
        children: [
          Image.asset(
            Images.noResultImage,
            fit: BoxFit.contain,
          ),
          _getSizedBox(),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Text(
              Strings.couldNotFind,
              style: Theme.of(Get.context).textTheme.subtitle1,
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }

  Widget _getSizedBox() => SizedBox(height: 10);

  Widget _getSubSizedBox() => SizedBox(height: 6);

  void _didTapHome() {
    controller.query = '';
    controller.getNews();
  }
}
