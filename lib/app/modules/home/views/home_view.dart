import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hacker_news/app/data/models/news_response.dart';
import 'package:hacker_news/app/routes/app_pages.dart';
import 'package:hacker_news/app/utils/constants.dart';
import 'package:hacker_news/app/widgets/base_scaffold.dart';
import 'package:hacker_news/app/widgets/shimmer_widget.dart';
import 'package:jiffy/jiffy.dart';
import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  final BoxDecoration _boxDecoration = BoxDecoration(
    borderRadius: BorderRadius.circular(6),
    color: Colors.white,
  );

  @override
  Widget build(BuildContext context) {
    return BaseScaffold(
      appBarTitle: Strings.appTitle,
      onTapTitle: _didTapHome,
      body: _buildBody(),
    );
  }

  Widget _buildTextField() {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: Dimensions.horizntalPadding,
      ),
      child: CupertinoSearchTextField(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
        ),
        onChanged: (String val) {
          controller.query = val;
        },
        placeholder: Strings.searchHint,
      ),
    );
  }

  Widget _buildBody() {
    return Obx(() => RefreshIndicator(
          onRefresh: () async {
            await controller.getNews();
          },
          child: Column(
            children: [
              _buildTextField(),
              _getSizedBox(),
              _buildNewsList(),
            ],
          ),
        ));
  }

  Widget _buildNewsList() {
    return controller.loading
        ? Expanded(
            child: ListView.separated(
              padding: EdgeInsets.symmetric(
                horizontal: Dimensions.horizntalPadding,
                vertical: Dimensions.verticalPadding,
              ),
              itemBuilder: (context, index) => _buildShimmerContainer(),
              separatorBuilder: (context, index) => _getSubSizedBox(),
              itemCount: 50,
            ),
          )
        : controller.articles.isNotEmpty
            ? Expanded(
                child: ListView(
                  padding: EdgeInsets.symmetric(
                    horizontal: Dimensions.horizntalPadding,
                  ),
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
    return GestureDetector(
      onTap: () => _didTapArticle(article: article),
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: Colors.grey[200], width: 1),
          color: Colors.white,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Flexible(
                  child: Text(
                    article.title ?? Strings.emptyString,
                    style: TextStyle(
                      fontSize: Dimensions.subtitleSize,
                      fontWeight: FontWeight.w500,
                    ),
                    overflow: TextOverflow.ellipsis,
                    maxLines: 2,
                  ),
                ),
                SizedBox(width: 8),
                Text(
                  (article.points?.toString() ?? Strings.emptyString) +
                      '  ' +
                      Strings.points,
                  style: TextStyle(
                    fontSize: Dimensions.mediumTextSize,
                  ),
                )
              ],
            ),
            _getSubSizedBox(),
            if (article.url != null)
              GestureDetector(
                onTap: () => controller.didTapSeeFullStory(article.url),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Image.asset(Images.openLinkIcon, height: 24, width: 24),
                    SizedBox(width: 4),
                    Text(
                      Strings.seeFullStory,
                      style: TextStyle(
                        fontSize: Dimensions.mediumTextSize,
                      ),
                    ),
                  ],
                ),
              ),
            _getSizedBox(),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Image.asset(Images.commentIcon, height: 24, width: 24),
                SizedBox(width: 8),
                Text(
                  article.numComments?.toString() ?? Strings.emptyString,
                  style: TextStyle(
                    fontSize: Dimensions.mediumTextSize,
                  ),
                ),
                Spacer(),
                if (article.createdAt != null)
                  Text(
                    Jiffy(article.createdAt).format('dd MMM yyyy') +
                        ' | ' +
                        Jiffy(article.createdAt).format('hh:mm a'),
                    style: TextStyle(
                      fontSize: Dimensions.mediumTextSize,
                      color: PrimaryColors.primaryGrey,
                    ),
                  ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildEmptyView() {
    return Expanded(
      child: ListView(
        padding: EdgeInsets.symmetric(
          horizontal: Dimensions.horizntalPadding,
        ),
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
              style: TextStyle(
                fontSize: Dimensions.mediumTextSize,
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildShimmerContainer() {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.grey[200], width: 1),
        color: Colors.white,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              ShimmerWidget(
                child: Container(
                  height: 20,
                  width: 160,
                  decoration: _boxDecoration,
                ),
              ),
              _getSubSizedBox(),
              ShimmerWidget(
                child: Container(
                  height: 16,
                  width: 60,
                  decoration: _boxDecoration,
                ),
              ),
            ],
          ),
          _getSubSizedBox(),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              ShimmerWidget(
                child: Container(
                  height: 24,
                  width: 24,
                  decoration: _boxDecoration,
                ),
              ),
              SizedBox(width: 4),
              ShimmerWidget(
                child: Container(
                  height: 20,
                  width: 100,
                  decoration: _boxDecoration,
                ),
              ),
            ],
          ),
          _getSizedBox(),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              ShimmerWidget(
                child: Container(
                  height: 24,
                  width: 24,
                  decoration: _boxDecoration,
                ),
              ),
              SizedBox(width: 8),
              ShimmerWidget(
                child: Container(
                  height: 20,
                  width: 40,
                  decoration: _boxDecoration,
                ),
              ),
              Spacer(),
              ShimmerWidget(
                child: Container(
                  height: 20,
                  width: 140,
                  decoration: _boxDecoration,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _getSizedBox() => SizedBox(height: 10);

  Widget _getSubSizedBox() => SizedBox(height: 8);

  void _didTapHome() {
    controller.query = '';
    controller.getNews();
  }

  void _didTapArticle({@required Hit article}) {
    Get.toNamed(Routes.NEWS_DETAIL, arguments: article.objectId);
  }
}
