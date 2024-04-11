import 'dart:convert';
import 'package:http/http.dart' as http_client;

final class CharacterAPIRestServices {
  Future<Map<String, dynamic>> fetchData({required urlString}) async {
    final url = Uri.parse(urlString);
    final response = await http_client.get(url);

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Data not found');
    }
  }
}
