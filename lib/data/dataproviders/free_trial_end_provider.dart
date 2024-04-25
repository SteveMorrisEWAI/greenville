import 'package:aiseek/core/commons/app_constants.dart';
import 'package:http/http.dart' as https;
import 'package:aiseek/core/commons/globals.dart';

class FreeTrialProvider {
  Future sendFreeTrialEndDate(String endDate) async {
    final queryParameters = {
      'client_uuid': Globals.Guid,
      'free_trial_end_date': endDate
    };
    var url = Uri.https(AppConstants.uriAuthority, AppConstants.freeTrialEndPath, queryParameters);

    https.Response response = await https.post(url);

    if (response.statusCode == 200) {
      Globals.printDebug(inText: 'free_trial_end_date API = ${response.body}');
    } else {
      throw Exception('Failed to load data from API');
    }
  }
}
