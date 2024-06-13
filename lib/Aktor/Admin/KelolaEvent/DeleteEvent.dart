import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class DeleteEvent {
  static Future<bool> deleteWisataEvent(String id) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? accessToken = prefs.getString('access_token');

      final response = await http.delete(
        Uri.parse(
            'https://jemberwisataapi-production.up.railway.app/api/event/$id'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer $accessToken', // Sertakan Bearer Token
        },
      );

      if (response.statusCode == 200) {
        return true; // Berhasil menghapus
      } else {
        throw Exception('Gagal menghapus event'); // Gagal menghapus
      }
    } catch (e) {
      print(e);
      return false; // Gagal menghapus
    }
  }
}
