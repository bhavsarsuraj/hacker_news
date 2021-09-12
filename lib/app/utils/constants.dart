import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class URLs {
  static final base = 'https://hn.algolia.com/api/v1/';
  static final searchPath = 'search';
  static String itemsPath(String objectID) => 'items/$objectID';
}

class Strings {
  static final appTitle = 'Hacker News';
  static final emptyString = '- -';
  static final searchHint = 'Search news...';
  static final points = 'Points';
  static final couldNotFind =
      'Sorry! We could not find anything matching your search, please try searching something different.';
  static final seeFullStory = 'See full story';
  static final viewReplies = 'View Replies';
  static final hideReplies = 'Hide Replies';
  static final comments = 'Comments';
  static final on = 'on';
  static final error = 'Error';
  static final somethingWentWrong = 'Something Went Wrong. Please try again';
  static final cannotLaunchURL = 'Cannot launch URL. Please try again';
  static final openSettings = 'Open Settings';
}

class Dimensions {
  static final titleTextSize = 18.0;
  static final subtitleSize = 16.0;
  static final mediumTextSize = 13.0;
  static final smallTextSize = 10.0;
  static final horizntalPadding = 12.0;
  static final verticalPadding = 12.0;
}

class Images {
  static final _assetImagePath = 'assets/images/';
  static final noResultImage = _assetImagePath + 'no_result_image.png';
  static final openLinkIcon = _assetImagePath + 'open_link_icon.png';
  static final commentIcon = _assetImagePath + 'comment_icon.png';
  static final noInternet = _assetImagePath + 'no_internet.png';
}

class PrimaryColors {
  static final scaffoldBackgroundColor = Color(0xFFF6F6F6);
  static final primaryYellow = Color(0xFFD79B00);
  static final primaryGrey = Color(0xFFA7A7A7);
  static final secondaryGrey = Color(0xFF6C6C6C);
  static final secondaryBlack = Color(0xFF404040);
  static final shimmerBaseColor = Colors.grey[200];
  static final shimmerHighlightColor = Colors.grey[400];
}
