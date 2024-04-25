// To parse this JSON data, do
//
//     final appHint = appHintFromJson(jsonString);

import 'dart:convert';

AppHint appHintFromJson(String str) => AppHint.fromJson(json.decode(str));

String appHintToJson(AppHint data) => json.encode(data.toJson());

class AppHint {
    List<String> tips;
    List<String> suggestions;

    AppHint({
        required this.tips,
        required this.suggestions,
    });

    factory AppHint.fromJson(Map<String, dynamic> json) => AppHint(
        tips: List<String>.from(json["tips"].map((x) => x)),
        suggestions: List<String>.from(json["suggestions"].map((x) => x)),
    );

    Map<String, dynamic> toJson() => {
        "tips": List<dynamic>.from(tips.map((x) => x)),
        "suggestions": List<dynamic>.from(suggestions.map((x) => x)),
    };
}
