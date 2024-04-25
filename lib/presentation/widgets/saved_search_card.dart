import 'package:aiseek/data/models/previous_search.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../core/commons/globals.dart';
//import 'package:fta_version_1/components/color_filters.dart';
//import 'package:aiseek/data/models/previous_search.dart';

class SavedSearchCard {
//  final String = "";
  final PreviousSearch cardSearch;
  SavedSearchCard({required this.cardSearch});

  Widget buildSearchCard(BuildContext context) {

    double deviceWidth = MediaQuery.of(context).size.width;
    final defaultColorScheme = Theme.of(context).colorScheme;
    const padding = 15.0;
    const iconWidth = 29.0;

    return Container(
        decoration: BoxDecoration(
          border: Border.all(
            color: defaultColorScheme.outline,
          ),
          borderRadius: BorderRadius.all(Radius.circular(7)),
        ),
        padding: EdgeInsets.fromLTRB(padding, padding, padding, padding),
        margin: EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 10),
        child: Row(children: [
          ConstrainedBox( 
            constraints: BoxConstraints(maxWidth: deviceWidth - (padding*5) - iconWidth),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  cardSearch.prompt,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 3,
                ),
                Text(
                  DateFormat('MMM dd yyy kk:mm').format(cardSearch.created),
                  style: TextStyle(
                    color: defaultColorScheme.onBackground,
                    fontSize: 12,
                  ),
                ),
              ]),
          ),
          Spacer(),
          Image.asset('assets/images/rightarrow.png', width: iconWidth,),
        ],
      ),
    );
  }
}
