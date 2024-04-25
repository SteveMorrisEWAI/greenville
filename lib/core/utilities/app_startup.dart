import 'package:aiseek/core/commons/app_constants.dart';
import 'package:aiseek/core/commons/globals.dart';
import 'package:aiseek/core/utilities/shared_preferences.dart';
import 'package:aiseek/data/dataproviders/device_info.dart';
import 'package:aiseek/data/dataproviders/free_trial_end_provider.dart';
import 'package:aiseek/data/dataproviders/ip_info_api.dart';
import 'package:aiseek/data/dataproviders/client_update.dart';
import 'package:aiseek/core/utilities/get_uri.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:purchases_flutter/purchases_flutter.dart';
import 'package:aiseek/core/commons/store_config.dart';
import 'dart:io';

class AppStartup {
  AppStartup(String inSource) {
    Globals.printDebug(inText: 'AppStartup function started - source = $inSource');
  }
  Future<dynamic> initAsync(String mySource) async {
    Globals.printDebug(inText: 'AppStartup initAsync started source = $mySource');
      
      Globals.isFreeTrialNull = true;
      await SharedPreferenceStorage.getFreeTrialExpiry().then((freeTrialExpiryString) => {
        Globals.FreeTrialEndDate = DateTime.parse(freeTrialExpiryString).toUtc()
      }).then( (freeTrialExpiryString) => {
        Globals.isFreeTrialNull = false
      }).onError((error, stackTrace) => {
        // Globals.printDebug(inText: 'AppStartup freeTrialExpiryString error = ${error}')
      });
      Globals.printDebug(inText: 'AppStartup freeTrialExpiryString error = ${Globals.FreeTrialEndDate}');
      

    // if (Globals.Guid == AppConstants.nullGuid) {
      Globals.printDebug(inText: 'AppStartup No Guid so first time install Guid = ${Globals.Guid}');
      final ipAddress = await IpInfoApi.getIPAddress(); //IP address stuff
      Globals.myIP = ipAddress.toString();
      Globals.InstallIP = Globals.myIP;
      SharedPreferenceStorage.setInstallIP();
      // Globals.printDebug(inText: 'myIP = ${Globals.myIP}');
      DeviceInfo _deviceInfo = DeviceInfo();
      await _deviceInfo.initPlatformState(); // Device information


      GetUri _getUriObject = GetUri(AppConstants.clientUpdateRef); // Setup the GetUri Object to fetch the Client Install Uri
      Uri myUri = _getUriObject.SetUri();
      ClientUpdate _ClientUpdate = ClientUpdate(myUri); //Do the post to client_install
      var ClientUpdateReturn = await _ClientUpdate.postData();
      String lefThree = (ClientUpdateReturn.toString().substring(1, 4));
      Globals.printDebug(inText: 'AppStartup ClientUpdateReturn = $ClientUpdateReturn');
      Globals.printDebug(inText: 'AppStartup Left 3 Chars = $lefThree');
      if (lefThree == 'Bad') {
        //Returned this code for now. It may have been working
        if (Globals.ClientInstallRetryCount < 3) {
          ClientUpdateReturn = await _ClientUpdate.postData();
          if (lefThree == 'Bad') {
            Globals.printDebug(inText: 'AppStartup Bad Guid ClientInstallRetryCount = ${Globals.ClientInstallRetryCount.toString()}');
            if (Globals.ClientInstallRetryCount < 3) {
              Globals.printDebug(inText: 'AppStartup Bad Guid First Retry ClientInstallRetryCount = ${Globals.ClientInstallRetryCount.toString()}');
              ClientUpdateReturn = await _ClientUpdate.postData();
              if (lefThree == 'Bad') {
                Globals.printDebug(inText: 'AppStartup Bad Guid Second Retry ClientInstallRetryCount = ${Globals.ClientInstallRetryCount.toString()}');
                if (Globals.ClientInstallRetryCount < 3) {
                  Globals.printDebug(inText: 'AppStartup Bad Guid Third Retry ClientInstallRetryCount = ${Globals.ClientInstallRetryCount.toString()}');
                  ClientUpdateReturn = await _ClientUpdate.postData();
                } else {
                  Globals.printDebug(inText: 'AppStartup  Client_install failed three times');
                }
              }
            }
          }
        }
      }

      Globals.printDebug(inText: 'AppStartup Massive chunk = ${ClientUpdateReturn.toString()}');

      SharedPreferenceStorage.setmyDevice();
      // Globals.printDebug(inText: 'myModel = ${Globals.myModel}');
      SharedPreferenceStorage.setmyModel();
      // Globals.printDebug(inText: 'myDeviceOS = ${Globals.myDeviceOS}');
      SharedPreferenceStorage.setmyDeviceOS();
      // Globals.printDebug(inText: 'AppSharePageURL  = ${Globals.AppSharePageURL}');
      SharedPreferenceStorage.setAppSharePageURL();
      // Globals.printDebug(inText: 'InstallTimeZone  = ${Globals.InstallTimeZone}');
      SharedPreferenceStorage.setInstallTimeZone();
      // Globals.printDebug(inText: 'Brand_id   = ${Globals.Brand_id}');
      // SecureStorage.setBrand_id();
      // Globals.printDebug(inText: 'PrivacyPolicyURL = ${Globals.PrivacyPolicyURL}');
      SharedPreferenceStorage.setPrivacyPolicyURL();
      // Globals.printDebug(inText: 'MessageDisplayLimit   = ${Globals.MessageDisplayLimit}');
      SharedPreferenceStorage.setMessageDisplayLimit();

      Globals.printDebug(inText: 'AppStartup Massive chunk = ${ClientUpdateReturn.toString()}');
      if( Globals.isFreeTrialNull ) {
        SharedPreferenceStorage.setFreeTrialExpiry();
        FreeTrialProvider().sendFreeTrialEndDate(Globals.FreeTrialEndDate.toString());
      }

    // } // End of No guid
    // else {
    //   // Globals.printDebug(inText: 'AppStartup Massive chunk = ${ClientUpdateReturn.toString()}');
    //   Globals.printDebug(inText: 'AppStartup Globals.revenueCatActive = ${Globals.entitlementActive.toString()}');
    //   Globals.InstallIP = await SharedPreferenceStorage.getInstallIP();
    //   // Globals.printDebug(inText: 'Found InstallIP = ${Globals.InstallIP}');
    //   Globals.myDevice = await SharedPreferenceStorage.getmyDevice();
    //   // Globals.printDebug(inText: 'Found myDevice = ${Globals.myDevice}');
    //   Globals.myModel = await SharedPreferenceStorage.getmyModel();
    //   // Globals.printDebug(inText: 'Found myModel = ${Globals.myModel}');
    //   Globals.myDeviceOS = await SharedPreferenceStorage.getmyDeviceOS();
    //   // Globals.printDebug(inText: 'Found myDeviceOS = ${Globals.myDeviceOS}');
    //   Globals.AppSharePageURL = await SharedPreferenceStorage.getAppSharePageURL();
    //   // Globals.printDebug(inText: 'Found AppSharePageURL = ${Globals.AppSharePageURL}');
    //   var myVar = await SharedPreferenceStorage.getInstallTimeZone();
    //   Globals.InstallTimeZone = int.parse(myVar);
    //   // Globals.printDebug(inText: 'Found InstallTimeZone = $myVar');
    //   // Globals.Brand_id = await SecureStorage.getBrand_id();
    //   // Globals.printDebug(inText: 'Found InstallIP = ${Globals.InstallIP}');
    //   Globals.PrivacyPolicyURL = await SharedPreferenceStorage.getPrivacyPolicyURL();
    //   // Globals.printDebug(inText: 'Found PrivacyPolicyURL = ${Globals.PrivacyPolicyURL}');
    //   myVar = await SharedPreferenceStorage.getMessageDisplayLimit();
    //   Globals.MessageDisplayLimit = int.parse(myVar);
    //   // Globals.printDebug(inText: 'Found MessageDisplayLimit = ${Globals.MessageDisplayLimit}');
    // }

    if (Platform.isIOS || Platform.isMacOS) {
      StoreConfig(
        store: Store.appStore,
        apiKey: AppConstants.appleApiKey,
        appUserID: Globals.Guid,
      );
    } else if (Platform.isAndroid) {
      StoreConfig(
        store: Store.playStore,
        apiKey: AppConstants.googleApiKey,
        appUserID: Globals.Guid,
      );
    }
  }
}
