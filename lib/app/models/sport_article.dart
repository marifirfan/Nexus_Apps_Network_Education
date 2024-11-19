// To parse this JSON data, do
//
//     final sport = sportFromJson(jsonString);

import 'dart:convert';

Sport sportFromJson(String str) => Sport.fromJson(json.decode(str));

String sportToJson(Sport data) => json.encode(data.toJson());

class Sport {
  int code;
  String status;
  String messages;
  int total;
  List<Datum> data;

  Sport({
    required this.code,
    required this.status,
    required this.messages,
    required this.total,
    required this.data,
  });

  factory Sport.fromJson(Map<String, dynamic> json) => Sport(
        code: json["code"],
        status: json["status"],
        messages: json["messages"],
        total: json["total"],
        data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "code": code,
        "status": status,
        "messages": messages,
        "total": total,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class Datum {
  String title;
  String link;
  String contentSnippet;
  DateTime isoDate;
  Image image;

  Datum({
    required this.title,
    required this.link,
    required this.contentSnippet,
    required this.isoDate,
    required this.image,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        title: json["title"],
        link: json["link"],
        contentSnippet: json["contentSnippet"],
        isoDate: DateTime.parse(json["isoDate"]),
        image: Image.fromJson(json["image"]),
      );

  Map<String, dynamic> toJson() => {
        "title": title,
        "link": link,
        "contentSnippet": contentSnippet,
        "isoDate": isoDate.toIso8601String(),
        "image": image.toJson(),
      };
}

class Image {
  String small;
  String large;

  Image({
    required this.small,
    required this.large,
  });

  factory Image.fromJson(Map<String, dynamic> json) => Image(
        small: json["small"],
        large: json["large"],
      );

  Map<String, dynamic> toJson() => {
        "small": small,
        "large": large,
      };
}
