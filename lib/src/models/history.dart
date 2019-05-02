// To parse this JSON data, do
//
//     final history = historyFromJson(jsonString);

import 'dart:convert';

List<History> historyFromJson(String str) => new List<History>.from(json.decode(str).map((x) => History.fromJson(x)));

String historyToJson(List<History> data) => json.encode(new List<dynamic>.from(data.map((x) => x.toJson())));

class History {
    String accountId;
    List<String> arguments;
    String bankAccRefCode;
    String category;
    String description;
    String keyPrefix;
    int timestamp;
    DateTime transactionDate;
    int transactionDateTimestamp;
    String transactionId;
    String transactionType;

    History({
        this.accountId,
        this.arguments,
        this.bankAccRefCode,
        this.category,
        this.description,
        this.keyPrefix,
        this.timestamp,
        this.transactionDate,
        this.transactionDateTimestamp,
        this.transactionId,
        this.transactionType,
    });

    factory History.fromJson(Map<String, dynamic> json) => new History(
        accountId: json["accountId"],
        arguments: new List<String>.from(json["arguments"].map((x) => x)),
        bankAccRefCode: json["bankAccRefCode"],
        category: json["category"],
        description: json["description"].toString().replaceAll("[", "").replaceAll("]", ""),
        keyPrefix: json["keyPrefix"],
        timestamp: json["timestamp"],
        transactionDate: DateTime.parse(json["transactionDate"]),
        transactionDateTimestamp: json["transactionDateTimestamp"] == null ? null : json["transactionDateTimestamp"],
        transactionId: json["transactionId"],
        transactionType: json["transactionType"],
    );

    Map<String, dynamic> toJson() => {
        "accountId": accountId,
        "arguments": new List<dynamic>.from(arguments.map((x) => x)),
        "bankAccRefCode": bankAccRefCode,
        "category": category,
        "description": description,
        "keyPrefix": keyPrefix,
        "timestamp": timestamp,
        "transactionDate": transactionDate.toIso8601String(),
        "transactionDateTimestamp": transactionDateTimestamp == null ? null : transactionDateTimestamp,
        "transactionId": transactionId,
        "transactionType": transactionType,
    };
}