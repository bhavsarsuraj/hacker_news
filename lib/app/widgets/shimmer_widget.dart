import 'package:flutter/material.dart';
import 'package:hacker_news/app/utils/constants.dart';
import 'package:shimmer/shimmer.dart';

class ShimmerWidget extends StatelessWidget {
  final Widget child;

  const ShimmerWidget({Key key, @required this.child}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return _buildShimmerFrom(child: child);
  }

  Widget _buildShimmerFrom({
    @required Widget child,
  }) {
    return Shimmer.fromColors(
      child: child,
      period: Duration(seconds: 1),
      baseColor: PrimaryColors.shimmerBaseColor,
      highlightColor: PrimaryColors.shimmerHighlightColor,
    );
  }
}
