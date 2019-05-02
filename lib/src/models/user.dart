// To parse this JSON data, do
//
//     final user = userFromJson(jsonString);

import 'dart:convert';

User userFromJson(String str) => User.fromJson(json.decode(str));

String userToJson(User data) => json.encode(data.toJson());

class User {
    String userId;
    String firstName;
    String lastName;
    String email;
    String walletId;
    String businessDate;

    User({
        this.userId,
        this.firstName,
        this.lastName,
        this.email,
        this.walletId,
        this.businessDate,
    });

    factory User.fromJson(Map<String, dynamic> json) => new User(
        userId: json["userID"],
        firstName: json["firstName"],
        lastName: json["lastName"],
        email: json["email"],
        walletId: json["walletID"],
        businessDate: json["businessDate"],
    );

    Map<String, dynamic> toJson() => {
        "userID": userId,
        "firstName": firstName,
        "lastName": lastName,
        "email": email,
        "walletID": walletId,
        "businessDate": businessDate,
    };
}
