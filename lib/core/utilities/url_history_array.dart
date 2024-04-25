import 'package:flutter/material.dart';
import 'package:aiseek/core/commons/app_constants.dart';
import 'package:aiseek/core/commons/globals.dart';

class URLHistoryArray {
  final List<Text> stack = List<Text>.filled(10, Text(''), growable: false);

  int addURL(String content) {
    Globals.printDebug(inText: 'addUrl stockCount = ${stack.length.toString()}');
    int lastIndex = stack.length - 1;

    for (int i = 0; i < lastIndex; i++) {
      stack[i] = stack[i + 1];
    }
    stack[0] = Text(content);
    return stack.length;
  }

  int deleteURL() {
    int lastIndex = stack.length - 1;
    stack[0] = Text('');
    for (int i = lastIndex; i > 0; i--) {
      stack[i] = stack[i - 1];
    }
    return stack.length;
  }

  int findURL(String content) {
    for (int i = 0; i < stack.length; i++) {
      if (stack[i].data == content) {
        return i;
      }
    }
    return -1;
  }

  String firstURL() {
    String myString = AppConstants.arrayStringItemNotFound;
    if (stack.length > 0) {
      myString = stack[0].toString();
    }
    Globals.printDebug(inText: 'firstURL = $firstURL');
    return myString;
  }

  int stackCount() {
    return stack.length;
  }

  void initializeStack() {
    for (int i = 0; i < stack.length; i++) {
      stack[i] = Text('');
    }
  }
}
