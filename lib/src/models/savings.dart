// To parse this JSON data, do
//
//     final savings = savingsFromJson(jsonString);

import 'dart:convert';

List<Savings> savingsFromJson(String str) => new List<Savings>.from(json.decode(str).map((x) => Savings.fromJson(x)));

String savingsToJson(List<Savings> data) => json.encode(new List<dynamic>.from(data.map((x) => x.toJson())));

class ExitEarlyRequest {
    String keyPrefix;
    String requestId;
    Savings termDeposit;
    String status;
    int quantity;
    double blendedRate;
    DateTime createdDate;
    DateTime expiredDate;
    int expiredDateTimestamp;
    int createdTimestamp;
    int lastUpdateTimestamp;
    double accruedInterest;
    double transferredInterest;

    ExitEarlyRequest({
        this.keyPrefix,
        this.requestId,
        this.termDeposit,
        this.status,
        this.quantity,
        this.blendedRate,
        this.createdDate,
        this.expiredDate,
        this.expiredDateTimestamp,
        this.createdTimestamp,
        this.lastUpdateTimestamp,
        this.accruedInterest,
        this.transferredInterest,
    });

    factory ExitEarlyRequest.fromJson(Map<String, dynamic> json) => new ExitEarlyRequest(
        keyPrefix: json["keyPrefix"],
        requestId: json["requestId"],
        termDeposit: Savings.fromJson(json["termDeposit"]),
        status: json["status"],
        quantity: json["quantity"],
        blendedRate: json["blendedRate"].toDouble(),
        createdDate: DateTime.parse(json["createdDate"]),
        expiredDate: DateTime.parse(json["expiredDate"]),
        expiredDateTimestamp: json["expiredDateTimestamp"],
        createdTimestamp: json["createdTimestamp"],
        lastUpdateTimestamp: json["lastUpdateTimestamp"],
        accruedInterest: json["accruedInterest"].toDouble(),
        transferredInterest: json["transferredInterest"].toDouble(),
    );

    Map<String, dynamic> toJson() => {
        "keyPrefix": keyPrefix,
        "requestId": requestId,
        "termDeposit": termDeposit.toJson(),
        "status": status,
        "quantity": quantity,
        "blendedRate": blendedRate,
        "createdDate": createdDate.toIso8601String(),
        "expiredDate": expiredDate.toIso8601String(),
        "expiredDateTimestamp": expiredDateTimestamp,
        "createdTimestamp": createdTimestamp,
        "lastUpdateTimestamp": lastUpdateTimestamp,
        "accruedInterest": accruedInterest,
        "transferredInterest": transferredInterest,
    };
}

class Savings {
    String keyPrefix;
    String termDepositId;
    String accountId;
    String issuerId;
    String productId;
    String productSymbol;
    String productName;
    String productDescription;
    String status;
    String currency;
    double rate;
    int term;
    String termUnit;
    int quantity;
    DateTime startDate;
    int startDateTimestamp;
    DateTime maturityDate;
    int maturityDateTimestamp;
    int redeemedAmount;
    String issuedEarlyExitRef;
    String redeemEarlyExitRef;
    List<Historys> history;
    double accruedInterest;
    double maturityInterest;
    List<ExitEarlyRequest> exitEarlyRequests;
    int redeemedDateTimestamp;
    double progress;

    Savings({
        this.keyPrefix,
        this.termDepositId,
        this.accountId,
        this.issuerId,
        this.productId,
        this.productSymbol,
        this.productName,
        this.productDescription,
        this.status,
        this.currency,
        this.rate,
        this.term,
        this.termUnit,
        this.quantity,
        this.startDate,
        this.startDateTimestamp,
        this.maturityDate,
        this.maturityDateTimestamp,
        this.redeemedAmount,
        this.issuedEarlyExitRef,
        this.redeemEarlyExitRef,
        this.history,
        this.accruedInterest,
        this.maturityInterest,
        this.exitEarlyRequests,
        this.redeemedDateTimestamp,
        this.progress
    });

    factory Savings.fromJson(Map<String, dynamic> json) => new Savings(
        keyPrefix: json["keyPrefix"],
        termDepositId: json["termDepositId"],
        accountId: json["accountId"],
        issuerId: json["issuerId"],
        productId: json["productId"],
        productSymbol: json["productSymbol"],
        productName: json["productName"],
        productDescription: json["productDescription"],
        status: json["status"],
        currency: json["currency"],
        rate: json["rate"].toDouble(),
        term: json["term"],
        termUnit: json["termUnit"],
        quantity: json["quantity"],
        startDate: DateTime.parse(json["startDate"]),
        startDateTimestamp: json["startDateTimestamp"],
        maturityDate: DateTime.parse(json["maturityDate"]),
        maturityDateTimestamp: json["maturityDateTimestamp"],
        redeemedAmount: json["redeemedAmount"],
        issuedEarlyExitRef: json["issuedEarlyExitRef"],
        redeemEarlyExitRef: json["redeemEarlyExitRef"],
        history: json["history"] != null ? new List<Historys>.from(json["history"].map((x) => Historys.fromJson(x))):[],
        accruedInterest: json["accruedInterest"] == null ? null : json["accruedInterest"].toDouble(),
        maturityInterest: json["maturityInterest"] == null ? null : json["maturityInterest"].toDouble(),
        exitEarlyRequests: json["exitEarlyRequests"] == null ? null : new List<ExitEarlyRequest>.from(json["exitEarlyRequests"].map((x) => ExitEarlyRequest.fromJson(x))),
        redeemedDateTimestamp: json["redeemedDateTimestamp"] == null ? null : json["redeemedDateTimestamp"],
    );

    Map<String, dynamic> toJson() => {
        "keyPrefix": keyPrefix,
        "termDepositId": termDepositId,
        "accountId": accountId,
        "issuerId": issuerId,
        "productId": productId,
        "productSymbol": productSymbol,
        "productName": productName,
        "productDescription": productDescription,
        "status": status,
        "currency": currency,
        "rate": rate,
        "term": term,
        "termUnit": termUnit,
        "quantity": quantity,
        "startDate": startDate.toIso8601String(),
        "startDateTimestamp": startDateTimestamp,
        "maturityDate": maturityDate.toIso8601String(),
        "maturityDateTimestamp": maturityDateTimestamp,
        "redeemedAmount": redeemedAmount,
        "issuedEarlyExitRef": issuedEarlyExitRef,
        "redeemEarlyExitRef": redeemEarlyExitRef,
        "history": new List<dynamic>.from(history.map((x) => x.toJson())),
        "accruedInterest": accruedInterest == null ? null : accruedInterest,
        "maturityInterest": maturityInterest == null ? null : maturityInterest,
        "exitEarlyRequests": exitEarlyRequests == null ? null : new List<dynamic>.from(exitEarlyRequests.map((x) => x.toJson())),
        "redeemedDateTimestamp": redeemedDateTimestamp == null ? null : redeemedDateTimestamp,
    };
}

class Historys {
    DateTime eventTime;
    int eventTimestamp;
    String description;

    Historys({
        this.eventTime,
        this.eventTimestamp,
        this.description,
    });

    factory Historys.fromJson(Map<String, dynamic> json) => new Historys(
        eventTime: DateTime.parse(json["eventTime"]),
        eventTimestamp: json["eventTimestamp"],
        description: json["description"],
    );

    Map<String, dynamic> toJson() => {
        "eventTime": eventTime.toIso8601String(),
        "eventTimestamp": eventTimestamp,
        "description": description,
    };
}
