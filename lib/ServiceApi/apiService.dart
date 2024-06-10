import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  static Future<Map<String, dynamic>> fetchRatings(int attractionId) async {
    final response = await http.get(
      Uri.parse(
          'https://jemberwisataapi-production.up.railway.app/api/wisata/$attractionId/ratings'),
    );
    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to fetch ratings');
    }
  }

  static Future<void> addRating(
      int attractionId, int ratingValue, String accessToken) async {
    final url =
        'https://jemberwisataapi-production.up.railway.app/api/wisata/$attractionId/ratings';

    final response = await http.post(
      Uri.parse(url),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer $accessToken',
      },
      body: jsonEncode(<String, int>{'rating_value': ratingValue}),
    );

    if (response.statusCode != 201 && response.statusCode != 200) {
      throw Exception('Failed to add or update rating');
    }
  }

  static Future fetchData() async {
    try {
      final response = await http.get(Uri.parse(
          'https://jemberwisataapi-production.up.railway.app/api/event'));
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body)['data'];
        return data;
      }
    } catch (e) {
      print(e);
      return null;
    }
  }
}
