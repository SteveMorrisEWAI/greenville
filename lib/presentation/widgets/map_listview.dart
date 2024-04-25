import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
//import 'package:aiseek/core/commons/globals.dart';
//import 'package:aiseek/core/utilities/shared_preferences.dart';

class MapListView extends StatefulWidget {
  final Map<String, dynamic> map;

  const MapListView({
    Key? key,
    required this.map,
  }) : super(key: key);

  @override
  State<MapListView> createState() => _MapListViewState();
}

class _MapListViewState extends State<MapListView> {
  @override
  Widget build(BuildContext context) {
    //_getData();

    return new Container(
      padding: new EdgeInsets.all(32.0),
      child: new Center(
        child: new Column(
          children: <Widget>[
            /*Listview display rows for different widgets,
                Listview.builder automatically builds its child widgets with a
                template and a list*/

            new Expanded(
              child: new ListView.builder(
                itemCount: widget.map.length,
                itemBuilder: (BuildContext context, int index) {
                  String key = widget.map.keys.elementAt(index);
                  return GestureDetector(
                    onTap: () {
                      showDialogFunc(context, key, widget.map[key]);
                    },
                    child: new Row(
                      children: <Widget>[
                        Text(
                          '${key} : ',
                          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                        ),
                        Expanded(
                          child: Text(
                            widget.map[key],
                            maxLines: 10,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(fontSize: 17),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}

showDialogFunc(context, myTitle, myDesc) {
  // if (myTitle == 'RevenueCat Status') {                                  This code was used as a test harness for AISEEK-100
  //   Globals.printDebug(inText: 'MapListView showDialogFunc RevenueCat Status = $myDesc');
  //   return showDialog(
  //       context: context,
  //       builder: (context) => AlertDialog(title: Text('$myTitle'), content: Text('$myDesc'), actions: [
  //             TextButton(
  //                 child: Text('Toggle'),
  //                 onPressed: () {
  //                   SecureStorage.getRevenueCatActive();
  //                   Globals.printDebug(inText: 'MapListView showDialogFunc RevenueCat B4 Flip Status = ${Globals.revenueCatActive.toString()}');
  //                   if (Globals.revenueCatActive) {
  //                     Globals.revenueCatActive = false;
  //                   } else {
  //                     Globals.revenueCatActive = true;
  //                   }
  //                   SecureStorage.setRevenueCatActive();
  //                   Globals.printDebug(inText: 'MapListView showDialogFunc RevenueCat After Flip Status Globals.revenueCatActive = ${Globals.revenueCatActive.toString()}');
  //                   SecureStorage.getRevenueCatActive();
  //                   Globals.printDebug(inText: 'MapListView showDialogFunc RevenueCat After Flip Status = ${Globals.revenueCatActive..toString()}');
  //                 }),
  //             TextButton(
  //               child: Text('OK'),
  //               onPressed: () => Navigator.pop(context),
  //             ),
  //           ]));
  // }
  return showDialog(
      context: context,
      builder: (context) => AlertDialog(title: Text('$myTitle'), content: Text('$myDesc'), actions: [
            TextButton(
                child: Text('Copy'),
                onPressed: () {
                  Clipboard.setData(ClipboardData(text: myTitle + ':' + myDesc));
                }),
            TextButton(
              child: Text('OK'),
              onPressed: () => Navigator.pop(context),
            ),
          ]));
}
