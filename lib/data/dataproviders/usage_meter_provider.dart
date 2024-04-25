import 'package:http/http.dart' as https;
import 'dart:convert';
import 'package:aiseek/core/commons/globals.dart';

import '../../core/commons/app_constants.dart';

class UsageMeterProvider {
  UsageMeterProvider();

  Future<double> getData() async {
    final queryParameters = {
      'client_uuid': Globals.Guid,
    };
    var url = Uri.https(AppConstants.uriAuthority, AppConstants.usageMeterPath, queryParameters);
    var resp = await https.get(url);

    if( resp.statusCode == 422 ) {
      return -100;
    }
    
    Globals.printDebug(inText: 'App usage API = ${json.decode(resp.body).toString()}');
    
    final double usage = double.parse(resp.body);

    return usage;
  }

}

