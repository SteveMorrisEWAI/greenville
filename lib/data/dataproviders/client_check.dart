import 'package:http/http.dart' as https;
import 'package:aiseek/core/commons/globals.dart';

class ClientCheck {
  ClientCheck(this.myUri);
  final Uri myUri;

  Future<dynamic> getData() async {
    Globals.printDebug(inText: 'ClientCheck Get Data Started');
    var myReturn;
    https.Response response = await https.get(
      myUri,
      headers: {'Content-Type': 'application/json'},
    );

    var myStatus = response.statusCode;
    Globals.printDebug(inText: 'myStatus $myStatus');
    Globals.printDebug(inText: 'myBody = ${response.body}');
    if (myStatus != 200) {
      myReturn = 'ClientCheck Bad API Status =' + myStatus.toString();
      Globals.ClientInstallRetryCount++;
      Globals.printDebug(inText: myReturn);
      return myReturn;
    }
    // Post to client_install worked
    Globals.printDebug(inText: 'Post ClientCheck OK');
    String myStringBody = response.body.toString();
    Globals.printDebug(inText: myStringBody);
    if (myStringBody == 'true') {
      Globals.ClientCheck = true;
    } else {
      Globals.ClientCheck = false;
    }
    Globals.printDebug(inText: 'ClientCheck returns Global.ClientCheck = ${Globals.ClientCheck.toString()}');
    return myStringBody;
  }
}
