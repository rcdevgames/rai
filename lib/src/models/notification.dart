// To parse this JSON data, do
//
//     final notifications = notificationsFromJson(jsonString);

import 'dart:convert';

List<Notifications> notificationsFromJson(String str) => new List<Notifications>.from(json.decode(str).map((x) => Notifications.fromJson(x)));

String notificationsToJson(List<Notifications> data) => json.encode(new List<dynamic>.from(data.map((x) => x.toJson())));

class Notifications {
    String id;
    String userId;
    String message;
    DateTime dateTimestamp;

    Notifications({
        this.id,
        this.userId,
        this.message,
        this.dateTimestamp,
    });

    factory Notifications.fromJson(Map<String, dynamic> json) => new Notifications(
        id: json["id"],
        userId: json["userId"],
        message: json["message"],
        dateTimestamp: DateTime.parse(json["dateTimestamp"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "userId": userId,
        "message": message,
        "dateTimestamp": dateTimestamp.toIso8601String(),
    };
}
