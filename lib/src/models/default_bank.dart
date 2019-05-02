// To parse this JSON data, do
//
//     final defaultBank = defaultBankFromJson(jsonString);

import 'dart:convert';

DefaultBank defaultBankFromJson(String str) => DefaultBank.fromJson(json.decode(str));

String defaultBankToJson(DefaultBank data) => json.encode(data.toJson());

class DefaultBank {
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

    DefaultBank({
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

    factory DefaultBank.fromJson(Map<String, dynamic> json) => new DefaultBank(
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
