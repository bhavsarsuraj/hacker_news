import 'package:get/get.dart';

class News {
  News({
    this.id,
    this.createdAt,
    this.createdAtI,
    this.type,
    this.author,
    this.title,
    this.url,
    this.text,
    this.points,
    this.parentId,
    this.storyId,
    this.children,
    this.options,
  });

  int id;
  DateTime createdAt;
  int createdAtI;
  String type;
  String author;
  String title;
  String url;
  dynamic text;
  int points;
  dynamic parentId;
  dynamic storyId;
  List<NewsChild> children;
  List<dynamic> options;

  factory News.fromMap(Map<String, dynamic> json) => News(
        id: json["id"] == null ? null : json["id"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        createdAtI: json["created_at_i"] == null ? null : json["created_at_i"],
        type: json["type"] == null ? null : json["type"],
        author: json["author"] == null ? null : json["author"],
        title: json["title"] == null ? null : json["title"],
        url: json["url"] == null ? null : json["url"],
        text: json["text"],
        points: json["points"] == null ? null : json["points"],
        parentId: json["parent_id"],
        storyId: json["story_id"],
        children: json["children"] == null
            ? null
            : List<NewsChild>.from(
                json["children"].map((x) => NewsChild.fromMap(x))),
        options: json["options"] == null
            ? null
            : List<dynamic>.from(json["options"].map((x) => x)),
      );

  Map<String, dynamic> toMap() => {
        "id": id == null ? null : id,
        "created_at": createdAt == null ? null : createdAt.toIso8601String(),
        "created_at_i": createdAtI == null ? null : createdAtI,
        "type": type == null ? null : type,
        "author": author == null ? null : author,
        "title": title == null ? null : title,
        "url": url == null ? null : url,
        "text": text,
        "points": points == null ? null : points,
        "parent_id": parentId,
        "story_id": storyId,
        "children": children == null
            ? null
            : List<dynamic>.from(children.map((x) => x.toMap())),
        "options":
            options == null ? null : List<dynamic>.from(options.map((x) => x)),
      };
}

class NewsChild {
  NewsChild({
    this.id,
    this.createdAt,
    this.createdAtI,
    this.type,
    this.author,
    this.title,
    this.url,
    this.text,
    this.points,
    this.parentId,
    this.storyId,
    this.children,
    this.options,
  });

  int id;
  DateTime createdAt;
  int createdAtI;
  Type type;
  String author;
  dynamic title;
  dynamic url;
  String text;
  dynamic points;
  int parentId;
  int storyId;
  List<NewsChild> children;
  List<dynamic> options;
  final isChildrenExpanded = false.obs;

  factory NewsChild.fromMap(Map<String, dynamic> json) => NewsChild(
        id: json["id"] == null ? null : json["id"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        createdAtI: json["created_at_i"] == null ? null : json["created_at_i"],
        type: json["type"] == null ? null : typeValues.map[json["type"]],
        author: json["author"] == null ? null : json["author"],
        title: json["title"],
        url: json["url"],
        text: json["text"] == null ? null : json["text"],
        points: json["points"],
        parentId: json["parent_id"] == null ? null : json["parent_id"],
        storyId: json["story_id"] == null ? null : json["story_id"],
        children: json["children"] == null
            ? null
            : List<NewsChild>.from(
                json["children"].map((x) => NewsChild.fromMap(x))),
        options: json["options"] == null
            ? null
            : List<dynamic>.from(json["options"].map((x) => x)),
      );

  Map<String, dynamic> toMap() => {
        "id": id == null ? null : id,
        "created_at": createdAt == null ? null : createdAt.toIso8601String(),
        "created_at_i": createdAtI == null ? null : createdAtI,
        "type": type == null ? null : typeValues.reverse[type],
        "author": author == null ? null : author,
        "title": title,
        "url": url,
        "text": text == null ? null : text,
        "points": points,
        "parent_id": parentId == null ? null : parentId,
        "story_id": storyId == null ? null : storyId,
        "children": children == null
            ? null
            : List<dynamic>.from(children.map((x) => x.toMap())),
        "options":
            options == null ? null : List<dynamic>.from(options.map((x) => x)),
      };
}

enum Type { COMMENT }

final typeValues = EnumValues({"comment": Type.COMMENT});

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
