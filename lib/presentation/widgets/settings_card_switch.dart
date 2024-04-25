import 'package:aiseek/data/models/card_switch.dart';
import 'package:flutter/material.dart';
import 'package:aiseek/core/commons/globals.dart';
//import 'package:fta_version_1/components/color_filters.dart';
//import 'package:aiseek/data/models/previous_search.dart';

class SettingsCardSwitch {
//  final String = "";
  final CardSwitch cardSwitch;

  SettingsCardSwitch({required this.cardSwitch});

  Widget buildImageCard() {
    return Container(
      child: Row(
        children: [
          Padding(
            padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
            child: Text(
              cardSwitch.cardLabel,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.black,
                fontSize: 12,
              ),
            ),
          ),
          Spacer(),
          Switch(
              value: cardSwitch.cardState,
              onChanged: (value) {
                Globals.printDebug(inText: 'New Value = ${value.toString()}');
              })
        ],
      ),
    );
  }
}
