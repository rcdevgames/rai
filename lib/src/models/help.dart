// To parse this JSON data, do
//
//     final help = helpFromJson(jsonString);

import 'dart:convert';

List<Help> helpFromJson(String str) => new List<Help>.from(json.decode(str).map((x) => Help.fromJson(x)));

String helpToJson(List<Help> data) => json.encode(new List<dynamic>.from(data.map((x) => x.toJson())));

class Help {
    String categoryName;
    List<Article> articles;

    Help({
        this.categoryName,
        this.articles,
    });

    factory Help.fromJson(Map<String, dynamic> json) => new Help(
        categoryName: json["categoryName"],
        articles: new List<Article>.from(json["articles"].map((x) => Article.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "categoryName": categoryName,
        "articles": new List<dynamic>.from(articles.map((x) => x.toJson())),
    };
}

class Article {
    int id;
    String title;
    String body;

    Article({
        this.id,
        this.title,
        this.body,
    });

    factory Article.fromJson(Map<String, dynamic> json) => new Article(
        id: json["id"],
        title: json["title"],
        body: json["body"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "body": body,
    };
}
