import 'package:http/http.dart' as http;
import 'package:aiseek/core/commons/globals.dart';

class IpInfoApi {
  static Future<String?> getIPAddress() async {
    try {
      final url = Uri.parse('https://api.ipify.org');
      final response = await http.get(url);
//      String myIP = response.body.toString();
//      Globals.printDebug(inText: myIP);
      Globals.myIP = response.body.toString();
      return response.statusCode == 200 ? response.body : 'Bad API Status ${response.statusCode}';
    } catch (e) {
      return null;
    }
  }
}
