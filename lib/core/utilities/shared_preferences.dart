import 'package:aiseek/core/commons/globals.dart';
import 'package:aiseek/core/commons/app_constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferenceStorage {
  static Future<SharedPreferences> _storage = SharedPreferences.getInstance();

  static Future deleteAll() async {
    var preferences = await _storage;
    await preferences.clear();
  }

  static Future setGuid({required String inSource}) async {
    Globals.printDebug(inText: 'Source = $inSource SharedPreferenceStorage setGuid Globals.Guid = ${Globals.Guid.toString()}');
    var preferences = await _storage;
    await preferences.setString(AppConstants.guidRef, Globals.Guid);
    Globals.printDebug(inText: 'Source = $inSource Set Guid write ${AppConstants.guidRef} to ${Globals.Guid}');
  }

  static Future getGuid({required String inSource}) async {
    var preferences = await _storage;
    var myReturn = await preferences.getString(AppConstants.guidRef) ?? AppConstants.nullGuid;
    Globals.printDebug(inText: 'Source = $inSource SharedPreferenceStorage getGuid return =  $myReturn');
    return myReturn;
  }

  static Future setmyModel() async {
    var preferences = await _storage;
    await preferences.setString(AppConstants.myModel, Globals.myModel);
  }

  static Future getmyModel() async {
    var preferences = await _storage;
    var myReturn = preferences.getString(AppConstants.myModel);
    return myReturn;
  }

  static Future setAppSharePageURL() async {
    var preferences = await _storage;
    await preferences.setString(AppConstants.AppSharePageURL, Globals.AppSharePageURL);
  }

  static Future getAppSharePageURL() async {
    var preferences = await _storage;
    var myReturn = preferences.getString(AppConstants.AppSharePageURL);
    return myReturn;
  }

  static Future setInstallTimeZone() async {
    var preferences = await _storage;
    await preferences.setString(AppConstants.InstallTimeZone, Globals.InstallTimeZone.toString());
  }

  static Future getInstallTimeZone() async {
    var preferences = await _storage;
    var myReturn = preferences.getString(AppConstants.InstallTimeZone);
    return myReturn;
  }

  static Future setInstallIP() async {
    var preferences = await _storage;
    await preferences.setString(AppConstants.InstallIP, Globals.InstallIP);
  }

  static Future getInstallIP() async {
    var preferences = await _storage;
    var myReturn = preferences.getString(AppConstants.InstallIP);
    return myReturn;
  }

  static Future setmyDevice() async {
    var preferences = await _storage;
    await preferences.setString(AppConstants.myDevice, Globals.myDevice);
  }

  static Future getmyDevice() async {
    var preferences = await _storage;
    var myReturn = preferences.getString(AppConstants.myDevice);
    return myReturn;
  }

  static Future setmyDeviceOS() async {
    var preferences = await _storage;
    await preferences.setString(AppConstants.myDeviceOS, Globals.myDeviceOS);
  }

  static Future getmyDeviceOS() async {
    var preferences = await _storage;
    var myReturn = preferences.getString(AppConstants.myDeviceOS);
    return myReturn;
  }

  static Future setPrivacyPolicyURL() async {
    var preferences = await _storage;
    await preferences.setString(AppConstants.PrivacyPolicyURL, Globals.PrivacyPolicyURL);
  }

  static Future getPrivacyPolicyURL() async {
    var preferences = await _storage;
    var myReturn = preferences.getString(AppConstants.PrivacyPolicyURL);
    return myReturn;
  }

  static Future setMessageDisplayLimit() async {
    var preferences = await _storage;
    await preferences.setString(AppConstants.MessageDisplayLimit, Globals.MessageDisplayLimit.toString());
  }

  static Future getMessageDisplayLimit() async {
    var preferences = await _storage;
    var myReturn = preferences.getString(AppConstants.MessageDisplayLimit);
    return myReturn;
  }

  static Future setFreeTrialExpiry() async {
    var preferences = await _storage;
    Globals.printDebug(inText: 'Source =  SharedPreferenceStorage setFreeTrialExpiry return =  ${Globals.FreeTrialEndDate.toString()}');
    await preferences.setString(AppConstants.FreeTrialLength, Globals.FreeTrialEndDate.toString());
  }

  static Future getFreeTrialExpiry() async {
    var preferences = await _storage;
    var myReturn = preferences.getString(AppConstants.FreeTrialLength);
    Globals.printDebug(inText: 'Source =  SharedPreferenceStorage getFreeTrialExpiry return =  $myReturn');

    return myReturn;
  }

  // static Future setEntitlementActive({required String inSource}) async {
  //   var preferences = await _storage;
  //   String myEntitlementActive = Globals.entitlementActive.toString();
  //   Globals.printDebug(inText: 'Source = $inSource SharedPreferenceStorage myRevenueCatActive = $myEntitlementActive');
  //   await preferences.setString(AppConstants.entitlementActiveRef, myEntitlementActive);
  //   Globals.printDebug(inText: 'Source = $inSource SharedPreferenceStorage setEntitlementActive set to $myEntitlementActive');
  // }

  // static Future<bool> getEntitlementActive({required String inSource}) async {
  //   var preferences = await _storage;
  //   var myEntitlementActive = preferences.getString(AppConstants.entitlementActiveRef);
  //   Globals.printDebug(inText: 'Source = $inSource SharedPreferenceStorage getEntitlementActive myEntitlementActive = ${myEntitlementActive.toString()} ');
  //   bool myReturn = true;
  //   String myTrue = myReturn.toString();
  //   String myString = myEntitlementActive.toString();
  //   if (myString == myTrue) {
  //     // myReturn = true;
  //   } else {
  //     myReturn = false;
  //   }
  //   Globals.printDebug(
  //       inText:
  //           'Source = $inSource SharedPreferenceStorage getEntitlementActive returning myReturn = ${myReturn.toString()}, myString = $myString and myTrue = $myTrue');
  //   return myReturn;
  // }
}
