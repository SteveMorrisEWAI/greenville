import 'package:flutter/foundation.dart';
import 'package:aiseek/core/commons/globals.dart';

class RevenueCatModel extends ChangeNotifier {
  bool _revenueCatActive = false;

  bool get revenueCatActive => _revenueCatActive;

  set revenueCatActive(bool value) {
    _revenueCatActive = value;
    Globals.entitlementActive = value;
    Globals.printDebug(inText: 'RevenueCatModel Set RevenueCatModel ChangeNotifier. _revenueCatActive = ${_revenueCatActive.toString()}');
    notifyListeners();
  }
}
