import 'package:aiseek/core/commons/app_constants.dart';
import 'package:aiseek/core/commons/globals.dart';
import 'package:http/http.dart' as https;

class ReferralProvider {
  Future<dynamic> sendReferrer(referral) async {

    final queryParameters = {
      'referrer': referral,
      'client_uuid': Globals.Guid,
    };

    var referralUri = Uri.https(AppConstants.uriAuthority, AppConstants.referralPath, queryParameters);

    Globals.printDebug(inText: referralUri.toString());
    https.Response response = await https.post(referralUri);

    if (response.statusCode == 200) {
      Globals.printDebug(inText: response.statusCode.toString());
      return true;
    } else {
      return false;
    }

  }
}