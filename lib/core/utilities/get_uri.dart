import 'dart:io';

import 'package:aiseek/core/commons/app_constants.dart';
import 'package:aiseek/core/commons/globals.dart';

class GetUri {
  final String apiRef;

  GetUri(this.apiRef) {
    Globals.printDebug(inText: 'apiRef = $apiRef');
  }

  Uri SetUri() {
    Globals.printDebug(inText: 'SetUri = $apiRef');
    Uri myUri;
    Map<String, String> myMap = {};
    if (apiRef == AppConstants.clientUuidRef) {
      Globals.printDebug(inText: 'SetUri start clientUuidRef');
//      myMap = {'brand_id': AppConstants.Brand_id};
      myUri = Uri.https(AppConstants.uriAuthority, AppConstants.uriUuidPath, {'brand_id': AppConstants.Brand_id});
      Globals.printDebug(inText: 'SetUri myUri = ${myUri.toString()}');
      return myUri;
    } else if (apiRef == AppConstants.clientUpdateRef) {
      int tzOffset = DateTime.now().timeZoneOffset.inHours;
      Globals.printDebug(inText: 'SetUri Guid = ${Globals.Guid}');
      var vendorId = (Platform.isIOS) ? Globals.IOSidentifierForVendor : Globals.AndroidID;
      myMap = {
        'client_uuid': Globals.Guid,
        'brand_id': AppConstants.Brand_id,
        'device_id': vendorId,
        'device_type': Globals.myModel,
        'device_os': Globals.myDeviceOS,
        'tzoffset': tzOffset.toString(),
        'install_ip_address': Globals.myIP,
        'app_version': Globals.versionNumber
      };
      myUri = Uri.https(AppConstants.uriAuthority, AppConstants.uriClientUpdatePath, myMap);
      Globals.printDebug(inText: 'Authority ${AppConstants.uriAuthority}');
      Globals.printDebug(inText: 'uriInstallPath = ${AppConstants.uriClientUpdatePath}');
      Globals.printDebug(inText: myMap.toString());
      String myUrl = myUri.toString();
      Globals.printDebug(inText: 'GetUri SetUri ClientUpdate URL = $myUrl'); //Debug
      return myUri;
    } else if (apiRef == AppConstants.GPTResultRef) {
      Globals.printDebug(inText: 'Prompt = ${Globals.currentPrompt}');
      myUri = Uri.https(AppConstants.uriAuthority, AppConstants.gptResultPath);
      String myUrl = myUri.toString();
      Globals.printDebug(inText: 'GetUri SetUri GetResults myUrl = $myUrl');
      return myUri;
    } else if (apiRef == AppConstants.previousSearchRef) {
      myMap = {'client_uuid': Globals.Guid};
      myUri = Uri.https(AppConstants.uriAuthority, AppConstants.previousSearchesPath, myMap);
      String myUrl = myUri.toString();
      Globals.printDebug(inText: 'GetUri SetUri previousSearchUrl = $myUrl');
      return myUri;
    } else if (apiRef == AppConstants.deleteAllSearches) {
      myMap = {'brand_id': AppConstants.Brand_id, 'client_uuid': Globals.Guid};
      myUri = Uri.https(AppConstants.uriAuthority, AppConstants.deleteAllSearchesPath, myMap);
      return myUri;
    } else if (apiRef == AppConstants.clientCheckRef) {
      myMap = {'brand_id': AppConstants.Brand_id, 'client_uuid': Globals.Guid};
      myUri = Uri.https(AppConstants.uriAuthority, AppConstants.uriClientCheckPath, myMap);
      return myUri;
    } else if (apiRef == AppConstants.appHints) {
      myUri = Uri.https(AppConstants.uriAuthority, AppConstants.appHintsPath);
      return myUri;
    } else {
      var myError = 'Unknown apiRef $apiRef';
      myUri = Uri.parse(myError);
      Globals.printDebug(inText: myError.toString());
      return myUri;
    }
  }
}
