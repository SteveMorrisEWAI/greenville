import 'package:aiseek/core/commons/globals.dart';
import 'package:aiseek/core/utilities/shared_preferences.dart';

class CheckFreeTrial {
  static bool isFreeTrialActive() {
    Globals.printDebug(inText: 'Checking free trial FreeTrialEndDate = ${Globals.FreeTrialEndDate}');

    if( Globals.FreeTrialEndDate.isAfter(DateTime.now().toUtc())  ) return true;
    return false;
  }
  static bool isFreeTrialStarted() {
    Globals.printDebug(inText: 'Checking free trial Started = ${Globals.FreeTrialEndDate}');
    if( Globals.FreeTrialEndDate.year != 2000 ) return true;
    return false;
  }

  static Future<bool> isFreeTrialNone() async {
    Globals.isFreeTrialNull = true;
    await SharedPreferenceStorage.getFreeTrialExpiry().then((freeTrialExpiryString) => {
      Globals.FreeTrialEndDate = DateTime.parse(freeTrialExpiryString).toUtc()
    }).then( (freeTrialExpiryString) => {
      Globals.isFreeTrialNull = false
    }).onError((error, stackTrace) => {
      // Globals.printDebug(inText: 'AppStartup freeTrialExpiryString error = ${error}')
    });
    return Globals.isFreeTrialNull;
  }
}