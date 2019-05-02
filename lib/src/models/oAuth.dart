// To parse this JSON data, do
//
//     final oAuth = oAuthFromJson(jsonString);

import 'dart:convert';

OAuth oAuthFromJson(String str) => OAuth.fromJson(json.decode(str));

String oAuthToJson(OAuth data) => json.encode(data.toJson());

class OAuth {
    String accessToken;
    String tokenType;
    int expiresIn;

    OAuth({
        this.accessToken,
        this.tokenType,
        this.expiresIn,
    });

    factory OAuth.fromJson(Map<String, dynamic> json) => new OAuth(
        accessToken: json["access_token"],
        tokenType: json["token_type"],
        expiresIn: json["expires_in"],
    );

    Map<String, dynamic> toJson() => {
        "access_token": accessToken,
        "token_type": tokenType,
        "expires_in": expiresIn,
    };
}
