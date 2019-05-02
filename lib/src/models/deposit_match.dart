// To parse this JSON data, do
//
//     final depositMatch = depositMatchFromJson(jsonString);

import 'dart:convert';

List<DepositMatch> depositMatchFromJson(String str) => new List<DepositMatch>.from(json.decode(str).map((x) => DepositMatch.fromJson(x)));

String depositMatchToJson(List<DepositMatch> data) => json.encode(new List<dynamic>.from(data.map((x) => x.toJson())));

class DepositMatch {
    String id;
    String currency;
    DateTime maturityDate;
    num amount;
    num rate;
    String bankName;
    String bankCode;
    bool isNew;
    num interest;
    String tag;

    DepositMatch({
        this.id,
        this.currency,
        this.maturityDate,
        this.amount,
        this.rate,
        this.bankName,
        this.bankCode,
        this.isNew,
        this.interest,
        this.tag,
    });

    factory DepositMatch.fromJson(Map<String, dynamic> json) => new DepositMatch(
        id: json["id"],
        currency: json["currency"],
        maturityDate: DateTime.parse(json["maturityDate"]),
        amount: json["amount"],
        rate: json["rate"],
        bankName: json["bankName"],
        bankCode: json["bankCode"],
        isNew: json["isNew"],
        interest: json["interest"].toDouble(),
        tag: json["tag"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "currency": currency,
        "maturityDate": "${maturityDate.year.toString().padLeft(4, '0')}-${maturityDate.month.toString().padLeft(2, '0')}-${maturityDate.day.toString().padLeft(2, '0')}",
        "amount": amount,
        "rate": rate,
        "bankName": bankName,
        "bankCode": bankCode,
        "isNew": isNew,
        "interest": interest,
        "tag": tag,
    };
}
