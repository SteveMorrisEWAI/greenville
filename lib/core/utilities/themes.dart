import 'package:aiseek/core/commons/app_constants.dart';
import 'package:aiseek/core/commons/globals.dart';
import 'package:flutter/material.dart';

class Themes {
  lightColorScheme() {
    return ColorScheme.light(
      brightness: Brightness.light,
      primary: Globals.primaryColor,
      onPrimary: Colors.white,
      background: Globals.backgroundColorLightTheme,
      onBackground: Globals.textColorLightTheme,
      shadow: Color.fromARGB(255, 241, 241, 241),
      outline: Color.fromARGB(255, 219, 219, 219),
      secondaryContainer: Color.fromARGB(255, 40, 40, 40), // bottom nav BG
      onSecondaryContainer: Color.fromARGB(255, 156, 156, 156), // bottom nav button colour
      errorContainer: Colors.amber,
      onErrorContainer: Colors.black
    );
  }

  darkColorScheme() {
    return ColorScheme.dark(
      brightness: Brightness.dark,
      primary: Globals.primaryColor,
      onPrimary: Colors.white,
      background: Color.fromARGB(255, 33, 42, 52),
      onBackground: Color.fromARGB(255, 210, 210, 210),
      shadow: Color.fromARGB(255, 48, 59, 72),
      outline: Color.fromARGB(255, 93, 108, 125),
      secondaryContainer: Color.fromARGB(255, 18, 23, 29), // bottom nav BG
      onSecondaryContainer: Color.fromARGB(255, 93, 108, 125),// bottom nav button colour
      errorContainer: Colors.amber,
      onErrorContainer: Colors.black
    );
  }

  subscribeButtonStyle(context) { 
    return TextButton.styleFrom(
      foregroundColor: Theme.of(context).colorScheme.onPrimary,
      backgroundColor: Theme.of(context).colorScheme.primary,
      maximumSize: Size(200, 40),
      padding: EdgeInsets.symmetric(horizontal: 40.0),
      textStyle: TextStyle(fontSize: AppConstants.paymentPageFontSize + 2, fontWeight: FontWeight.bold),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(5.0)),
      ),
    );
  }

  primaryButtonStyle(context) { 
    return TextButton.styleFrom(
      elevation: 0.1,
      foregroundColor: Theme.of(context).colorScheme.onPrimary,
      backgroundColor: Theme.of(context).colorScheme.primary,
      padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 15.0),
      textStyle: TextStyle(fontSize: AppConstants.paymentPageFontSize + 2, fontWeight: FontWeight.bold),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(5.0)),
      ),
    );
  }

  greyButtonStyle(context) {
    return TextButton.styleFrom(
      elevation: 0,
      foregroundColor: Theme.of(context).colorScheme.onBackground,
      backgroundColor: Colors.white10,
      maximumSize: Size(200, 40),
      padding: EdgeInsets.symmetric(horizontal: 10.0),
      textStyle: TextStyle(fontSize: AppConstants.paymentPageFontSize + 2, fontWeight: FontWeight.bold),
      side: BorderSide(width: 1.0, color: Theme.of(context).colorScheme.outline),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(5.0)),
      ),
    );
  }

  settingsDivider(context) {
    return Divider(
      height: 20,
      thickness: 1,
      endIndent: 0,
      color: Theme.of(context).colorScheme.outline,
    );
  }
}