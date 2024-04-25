import 'package:aiseek/data/models/previous_search.dart';
import 'package:flutter/material.dart';
//import 'package:fta_version_1/components/color_filters.dart';
//import 'package:aiseek/data/models/previous_search.dart';

class MyCard {
//  final String = "";
  final PreviousSearch cardSearch;
  MyCard({required this.cardSearch});

  Widget buildImageCard() => Card(
        clipBehavior: Clip.antiAlias,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
                  child: Text(
                    cardSearch.created.toString(),
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                      fontSize: 9,
                    ),
                  ),
                ),
                Text(
                  cardSearch.prompt,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 3,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                    fontSize: 11,
                  ),
                ),
              ],
            ),
            Icon(Icons.chevron_right, color: Colors.black, size: 24.0),
          ],
        ),
      );
}
