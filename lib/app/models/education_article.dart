import 'dart:convert';

Education educationFromJson(String str) => Education.fromJson(json.decode(str));

String educationToJson(Education data) => json.encode(data.toJson());

class Education {
  String status;
  int totalResults;
  List<Result> results;
  String nextPage;

  Education({
    required this.status,
    required this.totalResults,
    required this.results,
    required this.nextPage,
  });

  factory Education.fromJson(Map<String, dynamic> json) => Education(
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
  String title;
  String link;
  String description;

  Result({
    required this.title,
    required this.link,
    required this.description,
  });

  factory Result.fromJson(Map<String, dynamic> json) => Result(
        title: json["title"],
        link: json["link"],
        description: json["description"],
      );

  Map<String, dynamic> toJson() => {
        "title": title,
        "link": link,
        "description": description,
      };
}
