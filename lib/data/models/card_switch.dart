import 'dart:convert';

CardSwitch cardSwitchFromJson(String str) => CardSwitch.fromJson(json.decode(str));

String CardSwitchToJson(CardSwitch data) => json.encode(data.toJson());

class CardSwitch {
  CardSwitch({
    required this.cardLabel,
    required this.cardState,
  });

  String cardLabel;
  bool cardState;

  factory CardSwitch.fromJson(Map<String, dynamic> json) => CardSwitch(
        cardLabel: json["card_label"],
        cardState: json["card_state"],
      );

  Map<String, dynamic> toJson() => {
        "card_label": cardLabel,
        "card_state": cardState,
      };
}
