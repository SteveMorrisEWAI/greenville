import 'package:http/http.dart' as https;
import 'dart:convert';
import 'package:aiseek/core/commons/globals.dart';
import 'package:aiseek/core/commons/app_constants.dart';
import 'package:aiseek/data/models/post_gpt_result.dart';

class GPTResult {
  GPTResult(this.myUri);
  final Uri myUri;
  Future<dynamic> postData() async {
    var myReturn;
//    https.Response response = await https.post(
    Globals.printDebug(inText: 'GPTResult B4 PostGPTResult');
    PostGPTResult postGPTResult =
        new PostGPTResult(client_uuid: Globals.Guid, brand_id: AppConstants.Brand_id, prompt: Globals.currentPrompt, output_flag: Globals.currentOutputFlag, generate: Globals.generateImage);
    String myJson = jsonEncode(postGPTResult);
    var object = json.decode(myJson);
    var prettyString = JsonEncoder.withIndent('  ').convert(object);
    Globals.printDebug(inText: 'Pretty String = $prettyString');

    https.Response response = await https.post(
      myUri,
      headers: {'Content-Type': 'application/json'},
      body: prettyString,
    );

    var myStatus = response.statusCode;
    Globals.printDebug(inText: 'myStatus $myStatus');
    Globals.printDebug(inText: 'myBody = ${response.body}');
    Globals.URLArray.initializeStack(inSource: 'GPTResult');

    if (myStatus != 200) {
      Map<String, dynamic> myJson = jsonDecode(response.body);
      List<dynamic> errorMessages = myJson['errors'];
      Globals.printDebug(inText: 'MyReturnerror = ${myJson.toString()}');
      String errorMessage = errorMessages[0] ?? '';

      myReturn = 'Bad API Status =' + myStatus.toString();
      Globals.printDebug(inText: 'MyReturn = ${myReturn.toString()}');
//      Globals.currentHTMLPage = myReturn['myHTMLPage'];
//      Globals.printDebug(inText: 'HTML Page  = ${Globals.currentHTMLPage}');
      String errorHTML = '${AppConstants.resultErrorURL}?status=${myStatus.toString()}&desc=API%20Error)%20Bad%20API';
      Globals.printDebug(inText: 'errorHTML = $errorHTML');
      Map<String, String> gptError = {'my_html_page': '$errorHTML', 'status': '${myStatus.toString()}', 'errorMsg': '${errorMessage}'};
      Globals.printDebug(inText: 'MyMap = ${gptError.toString()}');
      return gptError;
    }
    // Post to GPT Result worked
    Globals.printDebug(inText: 'Post gpt_result OK');
    Map myBody = jsonDecode(response.body);
    Globals.printDebug(inText: 'myBody = ${myBody.toString()}');
    return myBody;
  }
}
