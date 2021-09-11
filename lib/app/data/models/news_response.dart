class NewsResponse {
  NewsResponse({
    this.hits,
    this.nbHits,
    this.page,
    this.nbPages,
    this.hitsPerPage,
    this.exhaustiveNbHits,
    this.query,
    this.params,
    this.processingTimeMs,
  });

  List<Hit> hits;
  int nbHits;
  int page;
  int nbPages;
  int hitsPerPage;
  bool exhaustiveNbHits;
  String query;
  String params;
  int processingTimeMs;

  factory NewsResponse.fromMap(Map<String, dynamic> json) => NewsResponse(
        hits: json["hits"] == null
            ? null
            : List<Hit>.from(json["hits"].map((x) => Hit.fromMap(x))),
        nbHits: json["nbHits"] == null ? null : json["nbHits"],
        page: json["page"] == null ? null : json["page"],
        nbPages: json["nbPages"] == null ? null : json["nbPages"],
        hitsPerPage: json["hitsPerPage"] == null ? null : json["hitsPerPage"],
        exhaustiveNbHits:
            json["exhaustiveNbHits"] == null ? null : json["exhaustiveNbHits"],
        query: json["query"] == null ? null : json["query"],
        params: json["params"] == null ? null : json["params"],
        processingTimeMs:
            json["processingTimeMS"] == null ? null : json["processingTimeMS"],
      );

  Map<String, dynamic> toMap() => {
        "hits": hits == null
            ? null
            : List<dynamic>.from(hits.map((x) => x.toMap())),
        "nbHits": nbHits == null ? null : nbHits,
        "page": page == null ? null : page,
        "nbPages": nbPages == null ? null : nbPages,
        "hitsPerPage": hitsPerPage == null ? null : hitsPerPage,
        "exhaustiveNbHits": exhaustiveNbHits == null ? null : exhaustiveNbHits,
        "query": query == null ? null : query,
        "params": params == null ? null : params,
        "processingTimeMS": processingTimeMs == null ? null : processingTimeMs,
      };
}

class Hit {
  Hit({
    this.createdAt,
    this.title,
    this.url,
    this.author,
    this.points,
    this.storyText,
    this.commentText,
    this.numComments,
    this.storyId,
    this.storyTitle,
    this.storyUrl,
    this.parentId,
    this.createdAtI,
    this.relevancyScore,
    this.tags,
    this.objectId,
    this.highlightResult,
  });

  DateTime createdAt;
  String title;
  String url;
  String author;
  int points;
  String storyText;
  dynamic commentText;
  int numComments;
  dynamic storyId;
  dynamic storyTitle;
  dynamic storyUrl;
  int parentId;
  int createdAtI;
  int relevancyScore;
  List<String> tags;
  String objectId;
  HighlightResult highlightResult;

  factory Hit.fromMap(Map<String, dynamic> json) => Hit(
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        title: json["title"] == null ? null : json["title"],
        url: json["url"] == null ? null : json["url"],
        author: json["author"] == null ? null : json["author"],
        points: json["points"] == null ? null : json["points"],
        storyText: json["story_text"] == null ? null : json["story_text"],
        commentText: json["comment_text"],
        numComments: json["num_comments"] == null ? null : json["num_comments"],
        storyId: json["story_id"],
        storyTitle: json["story_title"],
        storyUrl: json["story_url"],
        parentId: json["parent_id"] == null ? null : json["parent_id"],
        createdAtI: json["created_at_i"] == null ? null : json["created_at_i"],
        relevancyScore:
            json["relevancy_score"] == null ? null : json["relevancy_score"],
        tags: json["_tags"] == null
            ? null
            : List<String>.from(json["_tags"].map((x) => x)),
        objectId: json["objectID"] == null ? null : json["objectID"],
        highlightResult: json["_highlightResult"] == null
            ? null
            : HighlightResult.fromMap(json["_highlightResult"]),
      );

  Map<String, dynamic> toMap() => {
        "created_at": createdAt == null ? null : createdAt.toIso8601String(),
        "title": title == null ? null : title,
        "url": url == null ? null : url,
        "author": author == null ? null : author,
        "points": points == null ? null : points,
        "story_text": storyText == null ? null : storyText,
        "comment_text": commentText,
        "num_comments": numComments == null ? null : numComments,
        "story_id": storyId,
        "story_title": storyTitle,
        "story_url": storyUrl,
        "parent_id": parentId == null ? null : parentId,
        "created_at_i": createdAtI == null ? null : createdAtI,
        "relevancy_score": relevancyScore == null ? null : relevancyScore,
        "_tags": tags == null ? null : List<dynamic>.from(tags.map((x) => x)),
        "objectID": objectId == null ? null : objectId,
        "_highlightResult":
            highlightResult == null ? null : highlightResult.toMap(),
      };
}

class HighlightResult {
  HighlightResult({
    this.title,
    this.url,
    this.author,
    this.storyText,
  });

  Author title;
  Author url;
  Author author;
  Author storyText;

  factory HighlightResult.fromMap(Map<String, dynamic> json) => HighlightResult(
        title: json["title"] == null ? null : Author.fromMap(json["title"]),
        url: json["url"] == null ? null : Author.fromMap(json["url"]),
        author: json["author"] == null ? null : Author.fromMap(json["author"]),
        storyText: json["story_text"] == null
            ? null
            : Author.fromMap(json["story_text"]),
      );

  Map<String, dynamic> toMap() => {
        "title": title == null ? null : title.toMap(),
        "url": url == null ? null : url.toMap(),
        "author": author == null ? null : author.toMap(),
        "story_text": storyText == null ? null : storyText.toMap(),
      };
}

class Author {
  Author({
    this.value,
    this.matchLevel,
    this.matchedWords,
  });

  String value;
  MatchLevel matchLevel;
  List<dynamic> matchedWords;

  factory Author.fromMap(Map<String, dynamic> json) => Author(
        value: json["value"] == null ? null : json["value"],
        matchLevel: json["matchLevel"] == null
            ? null
            : matchLevelValues.map[json["matchLevel"]],
        matchedWords: json["matchedWords"] == null
            ? null
            : List<dynamic>.from(json["matchedWords"].map((x) => x)),
      );

  Map<String, dynamic> toMap() => {
        "value": value == null ? null : value,
        "matchLevel":
            matchLevel == null ? null : matchLevelValues.reverse[matchLevel],
        "matchedWords": matchedWords == null
            ? null
            : List<dynamic>.from(matchedWords.map((x) => x)),
      };
}

enum MatchLevel { NONE }

final matchLevelValues = EnumValues({"none": MatchLevel.NONE});

class EnumValues<T> {
  Map<String, T> map;
  Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    if (reverseMap == null) {
      reverseMap = map.map((k, v) => new MapEntry(v, k));
    }
    return reverseMap;
  }
}
