import 'package:aiseek/core/utilities/get_uri.dart';
import 'package:http/http.dart' as https;
import 'dart:convert';
import 'package:aiseek/core/commons/globals.dart';

import '../../core/commons/app_constants.dart';
import '../models/app_hints_model.dart';

class AppHintsProvider {
  AppHintsProvider();

  Future<AppHint> getData() async {
    // var url = Uri.parse("https://aiseek.development.nonprodsvc.com/v1/client/app-hints");
    GetUri _getUri4AppHints = GetUri(AppConstants.appHints);
    Globals.appHintUri = _getUri4AppHints.SetUri();
    var resp = await https.get(Globals.appHintUri);
    Globals.printDebug(inText: 'App Hints API = ${json.decode(resp.body).toString()}');
    
    final AppHint appHint = appHintFromJson(resp.body);

    return appHint;
  }

}

