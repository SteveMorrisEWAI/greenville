import 'package:http/http.dart' as https;
import 'package:aiseek/data/models/previous_search.dart';
import 'dart:convert';
import 'package:aiseek/core/commons/globals.dart';

import '../../core/commons/app_constants.dart';

class PreviousSearchesProvider {
  PreviousSearchesProvider();
  // final Uri myUri;
  var myReturn;

  Future<List<PreviousSearch>> getData() async {
    https.Response response = await https.get(Globals.previousSearchUri);

    if (response.statusCode == 200) {
      final List<dynamic> jsonList = json.decode(response.body);
      return jsonList.map((json) => PreviousSearch.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load data from API');
    }
  }

  Future<List<PreviousSearch>> doSearch(text) async {
    var searchMap = {
      'client_uuid': Globals.Guid,
      'search_string': text
    };

    var searchSearchUri = Uri.https(AppConstants.uriAuthority, AppConstants.searchSearchesPath, searchMap);
    https.Response response = await https.get(searchSearchUri);
    if (response.statusCode == 200) {
      final List<dynamic> jsonList = json.decode(response.body);
      return jsonList.map((json) => PreviousSearch.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load data from API');
    }
  }

  Future deleteSearch(convId) async {

    var deleteMap = {
      'brand_id': AppConstants.Brand_id,
      'client_uuid': Globals.Guid,
      'conv_id': convId
    };

    var deleteUri = Uri.https(AppConstants.uriAuthority, AppConstants.deleteSearchesPath, deleteMap);
    https.Response response = await https.delete(deleteUri);

    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }

  Future deleteAllSearches() async {

    https.Response response = await https.delete(Globals.deleteAllSearchesUri);

    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }
}
