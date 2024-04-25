// To parse this JSON data, do
//
//     final welcome = welcomeFromJson(jsonString);

import 'dart:convert';

PreviousSearch previousSearchFromJson(String str) => PreviousSearch.fromJson(json.decode(str));

String PreviousSearchToJson(PreviousSearch data) => json.encode(data.toJson());

class PreviousSearch {
  PreviousSearch({
    required this.conv_id,
    required this.created,
    required this.prompt,
    required this.page_url,
    required this.share_url,
  });

  String conv_id;
  DateTime created;
  String prompt;
  String page_url;
  String share_url;

  factory PreviousSearch.fromJson(Map<String, dynamic> json) => PreviousSearch(
        conv_id: json["conv_id"],
        created: DateTime.parse(json["created"]),
        prompt: fixEncoding(inStr: json["prompt"]),
        page_url: json["page_url"],
        share_url: json["share_url"],
      );

  Map<String, dynamic> toJson() => {
        "convId": conv_id,
        "created": created,
        "prompt": fixEncoding(inStr: prompt),
        "page_url": page_url,
        "share_url": share_url,
      };
}

String fixEncoding({required String inStr}) {
//  Globals.printDebug(inText: 'PreviousSearch fixEncoding inStr = $inStr');
  final codeUnits = inStr.codeUnits;
  String myReturn = Utf8Decoder().convert(codeUnits);
//  Globals.printDebug(inText: 'PreviousSearch fixEncoding myReturn = $myReturn');
  return myReturn;
}
