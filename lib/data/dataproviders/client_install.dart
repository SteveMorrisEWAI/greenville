import 'package:aiseek/core/commons/app_constants.dart';
import 'package:http/http.dart' as https;
import 'dart:convert';
import 'package:aiseek/core/commons/globals.dart';
import 'package:aiseek/core/utilities/shared_preferences.dart';

class ClientInstall {
  ClientInstall(this.myUri);
  final Uri myUri;

  Future<dynamic> postData() async {
    Globals.printDebug(inText: 'Client Install Post Data Started');
    var myReturn;
    if (Globals.ClientInstallRetryCount != 0) {
      Globals.printDebug(inText: 'Client Install Retry Count ${Globals.ClientInstallRetryCount}');
    }
//    https.Response response = await https.post(
    https.Response response = await https.post(
      myUri,
      headers: {'Content-Type': 'application/json'},
    );

    var myStatus = response.statusCode;
    Globals.printDebug(inText: 'myStatus $myStatus');
    Globals.printDebug(inText: 'myBody = ${response.body}');
    if (myStatus != 200) {
      myReturn = 'Bad API Status =' + myStatus.toString();
      Globals.ClientInstallRetryCount++;
      Globals.printDebug(inText: myReturn);
      return myReturn;
    }
    // Post to client_install worked
    Globals.printDebug(inText: 'Post client_install OK');
    Map myBody = jsonDecode(response.body);
    Globals.printDebug(inText: myBody.toString());
    Globals.Guid = myBody['client_uuid'];
    SharedPreferenceStorage.setGuid(inSource: 'ClientInstall');
    Globals.printDebug(inText: 'Guid = ${Globals.Guid}');
    Globals.AppSharePageURL = myBody["appshare_page_url"];
    Globals.printDebug(inText: 'AppSharePageURL = ${Globals.AppSharePageURL}');
    Globals.InstallTimeZone = myBody["install_time_zone"].toInt();
    Globals.printDebug(inText: 'InstallTimeZone = ${Globals.InstallTimeZone}');
    Globals.printDebug(inText: 'Brand_id = ${AppConstants.Brand_id}');
    Globals.InstallIP = Globals.myIP;
    Globals.printDebug(inText: 'InstallIP = ${Globals.InstallIP}');
    Globals.PrivacyPolicyURL = myBody['privacy_policy_url'];
    Globals.printDebug(inText: 'PrivacyPolicyURL = ${Globals.PrivacyPolicyURL}');
    Globals.MessageDisplayLimit = myBody['message_display_limit'].toInt();
    Globals.printDebug(inText: 'MessageDisplayLimit = ${Globals.MessageDisplayLimit}');

    Globals.FreeTrialLength = myBody['days_trial'].toInt();
    Globals.printDebug(inText: 'FreeTrialLength = ${Globals.FreeTrialLength}');

    return myBody;
  }
}
