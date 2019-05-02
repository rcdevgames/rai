// To parse this JSON data, do
//
//     final defaultAccount = defaultAccountFromJson(jsonString);

import 'dart:convert';

DefaultAccount defaultAccountFromJson(String str) => DefaultAccount.fromJson(json.decode(str));

String defaultAccountToJson(DefaultAccount data) => json.encode(data.toJson());

class DefaultAccount {
    String keyPrefix;
    String accountId;
    String issuerId;
    String status;
    String kycStatus;
    String currency;
    num quantity;
    String bankAccCode;
    int fourDigitBankAcc;
    int timestamp;

    DefaultAccount({
        this.keyPrefix,
        this.accountId,
        this.issuerId,
        this.status,
        this.kycStatus,
        this.currency,
        this.quantity,
        this.bankAccCode,
        this.fourDigitBankAcc,
        this.timestamp,
    });

    factory DefaultAccount.fromJson(Map<String, dynamic> json) => new DefaultAccount(
        keyPrefix: json["keyPrefix"],
        accountId: json["accountId"],
        issuerId: json["issuerId"],
        status: json["status"],
        kycStatus: json["kycStatus"],
        currency: json["currency"],
        quantity: json["quantity"],
        bankAccCode: json["bankAccCode"],
        fourDigitBankAcc: json["fourDigitBankAcc"],
        timestamp: json["timestamp"],
    );

    Map<String, dynamic> toJson() => {
        "keyPrefix": keyPrefix,
        "accountId": accountId,
        "issuerId": issuerId,
        "status": status,
        "kycStatus": kycStatus,
        "currency": currency,
        "quantity": quantity,
        "bankAccCode": bankAccCode,
        "fourDigitBankAcc": fourDigitBankAcc,
        "timestamp": timestamp,
    };
}
