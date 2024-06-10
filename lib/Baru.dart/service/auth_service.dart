// import 'dart:convert';
// import 'package:http/http.dart' as http;
// import 'package:shared_preferences/shared_preferences.dart';
// import 'package:jember_wisataku/Baru.dart/models/wisata.dart';

// class ApiService {
//   final String baseUrl =
//       "http://127.0.0.1:8000/api"; // Update with your actual API base URL

//   Future<http.Response> register(
//       String name, String email, String password) async {
//     final url = Uri.parse('$baseUrl/auth/register');
//     final response = await http.post(
//       url,
//       headers: {
//         'Content-Type': 'application/json',
//       },
//       body: jsonEncode({
//         'name': name,
//         'email': email,
//         'password': password,
//       }),
//     );
//     return response;
//   }

//   Future<http.Response> login(String email, String password) async {
//     final url = Uri.parse('$baseUrl/auth/login');
//     final response = await http.post(
//       url,
//       headers: {
//         'Content-Type': 'application/json',
//       },
//       body: jsonEncode({
//         'email': email,
//         'password': password,
//       }),
//     );
//     if (response.statusCode == 200) {
//       SharedPreferences prefs = await SharedPreferences.getInstance();
//       var data = json.decode(response.body);
//       await prefs.setString('token', data['access_token']);
//     }
//     return response;
//   }

//   Future<http.Response> me() async {
//     try {
//       SharedPreferences prefs = await SharedPreferences.getInstance();
//       String? token = prefs.getString('token');
//       if (token == null) {
//         throw Exception('Token is null');
//       }
//       final url = Uri.parse('$baseUrl/auth/me');
//       final response = await http.get(
//         url,
//         headers: {
//           'Authorization': 'Bearer $token',
//           'Content-Type': 'application/json',
//         },
//       );
//       if (response.statusCode == 200) {
//         return response;
//       } else {
//         throw Exception('Failed to load user data');
//       }
//     } catch (e) {
//       throw Exception('Error loading user data: $e');
//     }
//   }

//   Future<http.Response> logout() async {
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     String? token = prefs.getString('token');
//     final url = Uri.parse('$baseUrl/auth/logout');
//     final response = await http.post(
//       url,
//       headers: {
//         'Authorization': 'Bearer $token',
//         'Content-Type': 'application/json',
//       },
//     );
//     if (response.statusCode == 200) {
//       await prefs.remove('token');
//     }
//     return response;
//   }

//   Future<http.Response> refresh() async {
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     String? token = prefs.getString('token');
//     final url = Uri.parse('$baseUrl/auth/refresh');
//     final response = await http.post(
//       url,
//       headers: {
//         'Authorization': 'Bearer $token',
//         'Content-Type': 'application/json',
//       },
//     );
//     if (response.statusCode == 200) {
//       var data = json.decode(response.body);
//       await prefs.setString('token', data['access_token']);
//     }
//     return response;
//   }

//   Future<http.Response> updateProfile(
//       String name, String email, String? password) async {
//     try {
//       SharedPreferences prefs = await SharedPreferences.getInstance();
//       String? token = prefs.getString('token');
//       if (token == null) {
//         throw Exception('Token is null');
//       }

//       final url = Uri.parse('$baseUrl/auth/update-profile');
//       final response = await http.post(
//         url,
//         headers: {
//           'Authorization': 'Bearer $token',
//           'Content-Type': 'application/json',
//         },
//         body: jsonEncode({
//           'name': name,
//           'email': email,
//           if (password != null) 'password': password,
//         }),
//       );
//       if (response.statusCode == 200) {
//         return response;
//       } else {
//         throw Exception('Failed to update user profile');
//       }
//     } catch (e) {
//       throw Exception('Error updating user profile: $e');
//     }
//   }

//   Future<List<Wisata>> getWisata() async {
//     try {
//       SharedPreferences prefs = await SharedPreferences.getInstance();
//       String? token = prefs.getString('token');
//       if (token == null) {
//         throw Exception('Token is null');
//       }
//       final url = Uri.parse('$baseUrl/wisata');
//       final response = await http.get(
//         url,
//         headers: {
//           'Authorization': 'Bearer $token',
//           'Content-Type': 'application/json',
//         },
//       );
//       if (response.statusCode == 200) {
//         List<dynamic> body = json.decode(response.body)['data'];
//         List<Wisata> wisataList =
//             body.map((dynamic item) => Wisata.fromJson(item)).toList();
//         return wisataList;
//       } else {
//         throw Exception('Failed to load wisata');
//       }
//     } catch (e) {
//       throw Exception('Error loading wisata: $e');
//     }
//   }
// }


import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:jember_wisataku/Baru.dart/models/wisata.dart';

class ApiService {
  final String baseUrl = 'http://127.0.0.1:8000/api/auth/';

  Future<http.Response> register(String name, String email, String password) async {
    final url = Uri.parse(baseUrl + 'register');
    final response = await http.post(
      url,
      headers: {
        'Content-Type': 'application/json',
      },
      body: jsonEncode({
        'name': name,
        'email': email,
        'password': password,
      }),
    );
    return response;
  }

  Future<http.Response> login(String email, String password) async {
    final url = Uri.parse(baseUrl + 'login');
    final response = await http.post(
      url,
      headers: {
        'Content-Type': 'application/json',
      },
      body: jsonEncode({
        'email': email,
        'password': password,
      }),
    );
    return response;
  }

  Future<Wisata?> getUserData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? token = prefs.getString('access_token');

    if (token != null) {
      final url = Uri.parse(baseUrl + 'user');
      final response = await http.get(
        url,
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData = json.decode(response.body);
        return Wisata.fromJson(responseData);
      }
    }
    return null;
  }
}
