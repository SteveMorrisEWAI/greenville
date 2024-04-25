// To parse this JSON data, do
//
//     final welcome = welcomeFromJson(jsonString);

import 'dart:convert';

StatementItem StatementItemFromJson(String str) => StatementItem.fromJson(json.decode(str));

String StatementItemToJson(StatementItem data) => json.encode(data.toJson());

class StatementItem {
  StatementItem({
    required this.purchased_tokens_total,
    required this.used_tokens_total,
    required this.bank_total,
  });

  int purchased_tokens_total;
  int used_tokens_total;
  int bank_total;

  factory StatementItem.fromJson(Map<String, dynamic> json) => StatementItem(
        purchased_tokens_total: json["purchased_tokens_total"],
        used_tokens_total: json["used_tokens_total"],
        bank_total: json["bank_total"],
      );
      

  Map<String, dynamic> toJson() => {
        "purchased_tokens_total": purchased_tokens_total,
        "transaction_date": used_tokens_total,
        "bank_total": bank_total,
      };
}

String fixEncoding({required String inStr}) {
//  Globals.printDebug(inText: 'StatementItem fixEncoding inStr = $inStr');
  final codeUnits = inStr.codeUnits;
  String myReturn = Utf8Decoder().convert(codeUnits);
//  Globals.printDebug(inText: 'StatementItem fixEncoding myReturn = $myReturn');
  return myReturn;
}
