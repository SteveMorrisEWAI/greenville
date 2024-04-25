import 'package:aiseek/core/commons/app_constants.dart';
import 'package:http/http.dart' as https;
import 'dart:convert';
import 'package:aiseek/core/commons/globals.dart';

class ClientUpdate {
  ClientUpdate(this.myUri);
  final Uri myUri;

  Future<dynamic> postData() async {
    Globals.printDebug(inText: 'ClientUpdate Post Data Started');
    var myReturn;
    https.Response response = await https.post(
      myUri,
      headers: {'Content-Type': 'application/json'},
    );

    var myStatus = response.statusCode;
    Globals.printDebug(inText: 'ClientUpdate myStatus $myStatus');
    Globals.printDebug(inText: 'ClientUpdate myBody = ${response.body}');
    if (myStatus != 200) {
      myReturn = 'ClientUpdate Bad API Status =' + myStatus.toString();
      Globals.ClientInstallRetryCount++;
      Globals.printDebug(inText: myReturn);
      return myReturn;
    }
    // Post to client_install worked
    Globals.printDebug(inText: 'Post client_update OK');
    Map myBody = jsonDecode(response.body);
    Globals.printDebug(inText: myBody.toString());
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
    var now = DateTime.now();
    if( Globals.FreeTrialEndDate.year == 2000) {
      Globals.FreeTrialEndDate = DateTime(now.year, now.month, now.day + Globals.FreeTrialLength, now.hour, now.minute);
    }
    Globals.printDebug(inText: 'FreeTrialLength = ${Globals.FreeTrialLength}');
    Globals.printDebug(inText: 'FreeTrialEndDate = ${Globals.FreeTrialEndDate}');
    

    return myBody;
  }
}
