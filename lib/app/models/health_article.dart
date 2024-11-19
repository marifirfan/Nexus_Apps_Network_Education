// To parse this JSON data, do
//
//     final health = healthFromJson(jsonString);

import 'dart:convert';

Health healthFromJson(String str) => Health.fromJson(json.decode(str));

String healthToJson(Health data) => json.encode(data.toJson());

class Health {
  String status;
  int totalResults;
  List<Result> results;
  String nextPage;

  Health({
    required this.status,
    required this.totalResults,
    required this.results,
    required this.nextPage,
  });

  factory Health.fromJson(Map<String, dynamic> json) => Health(
        status: json["status"],
        totalResults: json["totalResults"],
        results:
            List<Result>.from(json["results"].map((x) => Result.fromJson(x))),
        nextPage: json["nextPage"],
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "totalResults": totalResults,
        "results": List<dynamic>.from(results.map((x) => x.toJson())),
        "nextPage": nextPage,
      };
}

class Result {
  String articleId;
  String title;
  String link;
  List<Category>? keywords;
  dynamic creator;
  dynamic videoUrl;
  String description;
  Content content;
  DateTime pubDate;
  PubDateTz pubDateTz;
  String imageUrl;
  SourceId sourceId;
  int sourcePriority;
  SourceName sourceName;
  String sourceUrl;
  String sourceIcon;
  Language language;
  List<Country> country;
  List<Category> category;
  AiTag aiTag;
  AiTag sentiment;
  AiTag sentimentStats;
  Ai aiRegion;
  Ai aiOrg;
  bool duplicate;

  Result({
    required this.articleId,
    required this.title,
    required this.link,
    required this.keywords,
    required this.creator,
    required this.videoUrl,
    required this.description,
    required this.content,
    required this.pubDate,
    required this.pubDateTz,
    required this.imageUrl,
    required this.sourceId,
    required this.sourcePriority,
    required this.sourceName,
    required this.sourceUrl,
    required this.sourceIcon,
    required this.language,
    required this.country,
    required this.category,
    required this.aiTag,
    required this.sentiment,
    required this.sentimentStats,
    required this.aiRegion,
    required this.aiOrg,
    required this.duplicate,
  });

  factory Result.fromJson(Map<String, dynamic> json) => Result(
        articleId: json["article_id"],
        title: json["title"],
        link: json["link"],
        keywords: json["keywords"] == null
            ? []
            : List<Category>.from(
                json["keywords"]!.map((x) => categoryValues.map[x]!)),
        creator: json["creator"],
        videoUrl: json["video_url"],
        description: json["description"],
        content: contentValues.map[json["content"]]!,
        pubDate: DateTime.parse(json["pubDate"]),
        pubDateTz: pubDateTzValues.map[json["pubDateTZ"]]!,
        imageUrl: json["image_url"],
        sourceId: sourceIdValues.map[json["source_id"]]!,
        sourcePriority: json["source_priority"],
        sourceName: sourceNameValues.map[json["source_name"]]!,
        sourceUrl: json["source_url"],
        sourceIcon: json["source_icon"],
        language: languageValues.map[json["language"]]!,
        country: List<Country>.from(
            json["country"].map((x) => countryValues.map[x]!)),
        category: List<Category>.from(
            json["category"].map((x) => categoryValues.map[x]!)),
        aiTag: aiTagValues.map[json["ai_tag"]]!,
        sentiment: aiTagValues.map[json["sentiment"]]!,
        sentimentStats: aiTagValues.map[json["sentiment_stats"]]!,
        aiRegion: aiValues.map[json["ai_region"]]!,
        aiOrg: aiValues.map[json["ai_org"]]!,
        duplicate: json["duplicate"],
      );

  Map<String, dynamic> toJson() => {
        "article_id": articleId,
        "title": title,
        "link": link,
        "keywords": keywords == null
            ? []
            : List<dynamic>.from(
                keywords!.map((x) => categoryValues.reverse[x])),
        "creator": creator,
        "video_url": videoUrl,
        "description": description,
        "content": contentValues.reverse[content],
        "pubDate": pubDate.toIso8601String(),
        "pubDateTZ": pubDateTzValues.reverse[pubDateTz],
        "image_url": imageUrl,
        "source_id": sourceIdValues.reverse[sourceId],
        "source_priority": sourcePriority,
        "source_name": sourceNameValues.reverse[sourceName],
        "source_url": sourceUrl,
        "source_icon": sourceIcon,
        "language": languageValues.reverse[language],
        "country":
            List<dynamic>.from(country.map((x) => countryValues.reverse[x])),
        "category":
            List<dynamic>.from(category.map((x) => categoryValues.reverse[x])),
        "ai_tag": aiTagValues.reverse[aiTag],
        "sentiment": aiTagValues.reverse[sentiment],
        "sentiment_stats": aiTagValues.reverse[sentimentStats],
        "ai_region": aiValues.reverse[aiRegion],
        "ai_org": aiValues.reverse[aiOrg],
        "duplicate": duplicate,
      };
}

enum Ai { ONLY_AVAILABLE_IN_CORPORATE_PLANS }

final aiValues = EnumValues({
  "ONLY AVAILABLE IN CORPORATE PLANS": Ai.ONLY_AVAILABLE_IN_CORPORATE_PLANS
});

enum AiTag { ONLY_AVAILABLE_IN_PROFESSIONAL_AND_CORPORATE_PLANS }

final aiTagValues = EnumValues({
  "ONLY AVAILABLE IN PROFESSIONAL AND CORPORATE PLANS":
      AiTag.ONLY_AVAILABLE_IN_PROFESSIONAL_AND_CORPORATE_PLANS
});

enum Category { HEALTH }

final categoryValues = EnumValues({"health": Category.HEALTH});

enum Content { ONLY_AVAILABLE_IN_PAID_PLANS }

final contentValues = EnumValues(
    {"ONLY AVAILABLE IN PAID PLANS": Content.ONLY_AVAILABLE_IN_PAID_PLANS});

enum Country { INDONESIA }

final countryValues = EnumValues({"indonesia": Country.INDONESIA});

enum Language { INDONESIAN }

final languageValues = EnumValues({"indonesian": Language.INDONESIAN});

enum PubDateTz { UTC }

final pubDateTzValues = EnumValues({"UTC": PubDateTz.UTC});

enum SourceId { DETIK, LIPUTAN6 }

final sourceIdValues =
    EnumValues({"detik": SourceId.DETIK, "liputan6": SourceId.LIPUTAN6});

enum SourceName { DETIK, LIPUTAN6 }

final sourceNameValues =
    EnumValues({"Detik": SourceName.DETIK, "Liputan6": SourceName.LIPUTAN6});

class EnumValues<T> {
  Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    reverseMap = map.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }
}
