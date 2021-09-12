import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:get/get.dart';
import 'package:hacker_news/app/data/models/news.dart';
import 'package:hacker_news/app/utils/constants.dart';
import 'package:hacker_news/app/widgets/base_scaffold.dart';
import 'package:hacker_news/app/widgets/shimmer_widget.dart';
import 'package:jiffy/jiffy.dart';
import '../controllers/news_detail_controller.dart';

class NewsDetailView extends GetView<NewsDetailController> {
  final BoxDecoration _boxDecoration = BoxDecoration(
    borderRadius: BorderRadius.circular(6),
    color: Colors.white,
  );

  @override
  Widget build(BuildContext context) {
    return BaseScaffold(
      body: _buildBody(),
    );
  }

  Widget _buildBody() {
    return Obx(
      () => controller.news != null
          ? Padding(
              padding: EdgeInsets.symmetric(
                vertical: Dimensions.verticalPadding,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: Dimensions.horizntalPadding),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Flexible(
                          child: Text(
                            controller.news.title,
                            style: TextStyle(
                              fontSize: Dimensions.titleTextSize,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                        SizedBox(width: 12),
                        if (controller.news.createdAt != null)
                          Text(
                            Jiffy(controller.news.createdAt)
                                .format('dd MMM yyyy'),
                            style: TextStyle(
                              fontSize: Dimensions.mediumTextSize,
                              color: PrimaryColors.secondaryGrey,
                            ),
                          )
                      ],
                    ),
                  ),
                  GestureDetector(
                    onTap: () => controller.didTapLink(controller.news.url),
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: Dimensions.horizntalPadding,
                        vertical: Dimensions.verticalPadding,
                      ),
                      child: Image.asset(
                        Images.openLinkIcon,
                        height: 24,
                        width: 24,
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: Dimensions.horizntalPadding),
                    child: Text(
                      '${controller.news.points?.toString() ?? Strings.emptyString} ${Strings.points}',
                      style: TextStyle(
                        fontSize: Dimensions.titleTextSize,
                        fontWeight: FontWeight.w500,
                        color: PrimaryColors.primaryGrey,
                      ),
                    ),
                  ),
                  _getSizedBox(),
                  Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: Dimensions.horizntalPadding),
                    child: Text(
                      Strings.comments,
                      style: TextStyle(
                        fontSize: Dimensions.mediumTextSize,
                        fontWeight: FontWeight.w500,
                        color: PrimaryColors.secondaryBlack,
                      ),
                    ),
                  ),
                  _getSubSizedBox(),
                  Divider(
                    height: 0,
                    thickness: 1.0,
                    indent: Dimensions.horizntalPadding,
                    endIndent: Dimensions.horizntalPadding,
                  ),
                  Expanded(
                    child: ListView.separated(
                      padding: EdgeInsets.symmetric(
                        horizontal: Dimensions.horizntalPadding,
                        vertical: Dimensions.verticalPadding,
                      ),
                      itemCount: controller.news.children.length,
                      itemBuilder: (context, index) => _buildCommentCard(
                        controller.news.children[index],
                      ),
                      separatorBuilder: (context, index) => _getSubSizedBox(),
                    ),
                  ),
                ],
              ),
            )
          : _buildShimmerPage(),
    );
  }

  Widget _buildCommentCard(NewsChild comment) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: Colors.white,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '${comment.author ?? Strings.emptyString}' +
                ' ' +
                Strings.on +
                ' ' +
                Jiffy(comment.createdAt ?? '').format('dd MMM yyyy'),
            style: TextStyle(
              fontSize: Dimensions.mediumTextSize,
              color: PrimaryColors.secondaryGrey,
            ),
          ),
          Html(
            data: comment.text ?? Strings.emptyString,
            onLinkTap: (url, context, attributes, element) =>
                controller.didTapLink(url),
            style: {
              'p': Style(
                fontSize: FontSize(Dimensions.mediumTextSize),
                color: Colors.black,
                fontWeight: FontWeight.w500,
                wordSpacing: 1.5,
              ),
            },
          ),
          if (comment.children.isNotEmpty)
            Theme(
              data: Theme.of(Get.context)
                  .copyWith(dividerColor: Colors.transparent),
              child: ExpansionTile(
                collapsedIconColor: PrimaryColors.primaryYellow,
                iconColor: PrimaryColors.primaryYellow,
                title: Obx(
                  () => Text(
                    comment.isChildrenExpanded.value
                        ? Strings.hideReplies
                        : Strings.viewReplies,
                    style: TextStyle(
                      fontSize: Dimensions.smallTextSize,
                      color: PrimaryColors.primaryYellow,
                    ),
                  ),
                ),
                onExpansionChanged: (value) {
                  comment.isChildrenExpanded.value = value;
                },
                children: comment.children
                    .map((child) => Padding(
                          padding: EdgeInsets.only(
                            left: Dimensions.horizntalPadding,
                          ),
                          child: Padding(
                            padding: const EdgeInsets.only(bottom: 8),
                            child: _buildCommentCard(child),
                          ),
                        ))
                    .toList(),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildShimmerPage() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(
            horizontal: Dimensions.horizntalPadding,
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              ShimmerWidget(
                child: Container(
                  decoration: _boxDecoration,
                  height: 50,
                  width: 200,
                ),
              ),
              SizedBox(width: 12),
              ShimmerWidget(
                child: Container(
                  height: 20,
                  width: 80,
                  decoration: _boxDecoration,
                ),
              ),
            ],
          ),
        ),
        _getSizedBox(),
        Padding(
          padding: EdgeInsets.symmetric(
            horizontal: Dimensions.horizntalPadding,
          ),
          child: ShimmerWidget(
            child: Container(
              height: 24,
              width: 24,
              decoration: _boxDecoration,
            ),
          ),
        ),
        _getSizedBox(),
        Padding(
          padding: EdgeInsets.symmetric(
            horizontal: Dimensions.horizntalPadding,
          ),
          child: ShimmerWidget(
            child: Container(
              height: 30,
              width: 160,
              decoration: _boxDecoration,
            ),
          ),
        ),
        _getSizedBox(),
        Padding(
          padding: EdgeInsets.symmetric(
            horizontal: Dimensions.horizntalPadding,
          ),
          child: ShimmerWidget(
            child: Container(
              height: 16,
              width: 100,
              decoration: _boxDecoration,
            ),
          ),
        ),
        _getSubSizedBox(),
        Expanded(
          child: ListView.separated(
            padding: EdgeInsets.symmetric(
              horizontal: Dimensions.horizntalPadding,
              vertical: Dimensions.verticalPadding,
            ),
            itemCount: 50,
            itemBuilder: (context, index) => _buildShimmerCommentCard(),
            separatorBuilder: (context, index) => _getSubSizedBox(),
          ),
        ),
      ],
    );
  }

  Widget _buildShimmerCommentCard() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: Colors.white,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ShimmerWidget(
            child: Container(
              height: 20,
              width: 200,
              decoration: _boxDecoration,
            ),
          ),
          _getSubSizedBox(),
          ShimmerWidget(
            child: Container(
              height: 100,
              decoration: _boxDecoration,
            ),
          ),
        ],
      ),
    );
  }

  Widget _getSizedBox() => SizedBox(height: 16);

  Widget _getSubSizedBox() => SizedBox(height: 8);
}
