import 'dart:convert';
import 'package:http/http.dart' as http_client;

final class CharacterAPIRestServices {
  final String _baseURL = 'https://rickandmortyapi.com/api/';

  Future<Map<String, dynamic>> fetchData({required urlComplement}) async {
    final String rawURL = _baseURL + urlComplement;
    try {
      final url = Uri.parse(rawURL);
      final response = await http_client.get(url);

      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      } else {
        return Future.error(Exception('Not data found!'));
      }
    } catch (e) {
      return Future.error(e);
    }
  }
}
