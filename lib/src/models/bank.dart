// To parse this JSON data, do
//
//     final bank = bankFromJson(jsonString);

import 'dart:convert';

List<Bank> bankFromJson(String str) => new List<Bank>.from(json.decode(str).map((x) => Bank.fromJson(x)));

String bankToJson(List<Bank> data) => json.encode(new List<dynamic>.from(data.map((x) => x.toJson())));

class Bank {
    int bankAcctId;
    String bankAcctName;
    String bankAcctNo;
    String bankAcctShortCode;
    String bankAcctCurrency;
    String bankAcctIssuerId;
    num bankAcctBalance;
    int bankId;
    String bankName;
    String bankCode;
    int isDefault;

    Bank({
        this.bankAcctId,
        this.bankAcctName,
        this.bankAcctNo,
        this.bankAcctShortCode,
        this.bankAcctCurrency,
        this.bankAcctIssuerId,
        this.bankAcctBalance,
        this.bankId,
        this.bankName,
        this.bankCode,
        this.isDefault,
    });

    factory Bank.fromJson(Map<String, dynamic> json) => new Bank(
        bankAcctId: json["bankAcctId"],
        bankAcctName: json["bankAcctName"],
        bankAcctNo: json["bankAcctNo"],
        bankAcctShortCode: json["bankAcctShortCode"],
        bankAcctCurrency: json["bankAcctCurrency"],
        bankAcctIssuerId: json["bankAcctIssuerId"],
        bankAcctBalance: json["bankAcctBalance"].toDouble(),
        bankId: json["bankId"],
        bankName: json["bankName"],
        bankCode: json["bankCode"],
        isDefault: json["isDefault"],
    );

    Map<String, dynamic> toJson() => {
        "bankAcctId": bankAcctId,
        "bankAcctName": bankAcctName,
        "bankAcctNo": bankAcctNo,
        "bankAcctShortCode": bankAcctShortCode,
        "bankAcctCurrency": bankAcctCurrency,
        "bankAcctIssuerId": bankAcctIssuerId,
        "bankAcctBalance": bankAcctBalance,
        "bankId": bankId,
        "bankName": bankName,
        "bankCode": bankCode,
        "isDefault": isDefault,
    };
}
