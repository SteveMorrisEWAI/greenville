import 'package:aiseek/data/models/statement_item.dart';
import 'package:http/http.dart' as https;
import 'package:aiseek/core/commons/globals.dart';

import '../../core/commons/app_constants.dart';

class StatementProvider {
  StatementProvider();
  // final Uri myUri;
  var myReturn;

  Future<StatementItem> getData() async {
    final queryParameters = {
      'client_uuid': Globals.Guid,
    };
    var url = Uri.https(AppConstants.uriAuthority, AppConstants.statementPath, queryParameters);

    https.Response response = await https.get(url);

    if (response.statusCode == 200) {
      // final dynamic jsonDecoded = json.decode(response.body);
      Globals.printDebug(inText: 'statement API = ${response.body}');
      return StatementItemFromJson(response.body);
      // return jsonDecoded.map((json) => StatementItem.fromJson(json));
    } else {
      throw Exception('Failed to load data from API');
    }
  }

}
