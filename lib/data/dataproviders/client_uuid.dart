import 'package:http/http.dart' as https;
import 'dart:convert';
import 'package:aiseek/core/commons/globals.dart';
import 'package:aiseek/core/utilities/shared_preferences.dart';

class ClientUuid {
  ClientUuid(this.myUri);
  final Uri myUri;

  Future<String> postData() async {
    Globals.printDebug(inText: 'Client Uuid Post Data Started');
    var myReturn;
    https.Response response = await https.post(
      myUri,
      headers: {'Content-Type': 'application/json'},
    );
    Globals.printDebug(inText: 'ClientUuid after post');
    var myStatus = response.statusCode;
    Globals.printDebug(inText: 'ClientUuid  post Status $myStatus');
    Globals.printDebug(inText: 'ClientUuid myBody = ${response.body}');
    if (myStatus != 200) {
      myReturn = 'Bad API Status =' + myStatus.toString();
      Globals.ClientInstallRetryCount++;
      Globals.printDebug(inText: myReturn);
      return myReturn;
    }
    // Post to client_install worked
    Globals.printDebug(inText: 'Post client_uuid OK');
    Map myBody = jsonDecode(response.body);
    Globals.printDebug(inText: myBody.toString());
    String myGuid = myBody['client_uuid'];
    Globals.printDebug(inText: 'ClientUUID myGuid = $myGuid');
    Globals.Guid = myGuid;
    Globals.printDebug(inText: 'ClientUuid myBody = $myBody');
//
//  Remove first and last characters from the string as there are double quotes
//
//     int mySubStr = myBody.length - 1;
//     String myShortGuid = myBody.substring(1, mySubStr);
//     Globals.printDebug(inText: 'ClientUuid myShortGuid = $myShortGuid');
//     Globals.Guid = myShortGuid;
    SharedPreferenceStorage.setGuid(inSource: 'ClientUuid');
    Globals.printDebug(inText: 'Guid = ${Globals.Guid}');
    return myGuid;
  }
}
