import 'package:flutter/material.dart';
import 'package:aiseek/core/commons/globals.dart';

class StatefulWrapper extends StatefulWidget {
  final Function onInit;
  final Widget child;
  StatefulWrapper({required this.onInit, required this.child});
  @override
  _StatefulWrapperState createState() => _StatefulWrapperState();
}

class _StatefulWrapperState extends State<StatefulWrapper> {
  @override
  void initState() {
    Globals.printDebug(inText: 'StatefulWrapper B4 init');
    widget.onInit();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return widget.child;
  }
}
