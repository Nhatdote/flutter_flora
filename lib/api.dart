import 'dart:convert';

import 'package:http/http.dart' as http;

class API {
  static Future<List<Map<String, dynamic>>> get districts async {
    const String api = 'https://provinces.open-api.vn/api/p/1?depth=2';

    var res = await http.get(Uri.parse(api));

    if (res.statusCode == 200) {
      String responseString = utf8.decode(res.bodyBytes);
      Map<String, dynamic> body = jsonDecode(responseString);
      List districts = body['districts'];

      return districts.map((h) {
        return {
          'id': h['code'],
          'name': h['name'],
        };
      }).toList();
    }

    return [];
  }
}
