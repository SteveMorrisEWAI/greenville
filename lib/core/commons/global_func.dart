import 'dart:io';
import 'package:flutter/material.dart';
import 'package:aiseek/core/commons/app_constants.dart';
import 'package:aiseek/core/commons/globals.dart';
import 'package:logger/logger.dart';

class GlobalFunc {
// Debug
  bool debugFlag = true;
  var logger = Logger(
    printer: PrettyPrinter(
        methodCount: 2,
        // number of method calls to be displayed
        errorMethodCount: 8,
        // number of method calls if stacktrace is provided
        lineLength: 300,
        // width of the output
        colors: true,
        // Colorful log messages
        printEmojis: true,
        // Print an emoji for each log message
        printTime: true // Should each log print contain a timestamp  ),
        ),
  );

  void exitFunc(context) {
    Globals.printDebug(inText: 'Start exit Func');
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Exit App aiseek'),
        content: const Text('If you want to exit tap "OK" '),
        actions: <Widget>[
          TextButton(
            child: Text('Cancel'),
            onPressed: () => Navigator.pop(context),
          ),
          TextButton(
            child: const Text('OK'),
            onPressed: () {
              if (Platform.isIOS) {
                Globals.printDebug(inText: 'Exit IOS');
                // FlutterExitApp.exitApp(iosForceExit: true);
              } // force exit in ios
              else {
                Globals.printDebug(inText: 'Exit Anything else ');
                // FlutterExitApp.exitApp();
              }
            },
          ),
        ],
      ),
    );
  }
  void printWrapped(String text) {
    if (!AppConstants.debug_flag) return;
    final pattern = RegExp('.{1,800}'); // 800 is the size of each chunk
    pattern.allMatches(text).forEach((match) => print(match.group(0)));
  }
}
