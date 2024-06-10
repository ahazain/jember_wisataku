import 'package:flutter/material.dart';
import 'package:jember_wisataku/View/publik_guest/nav_guest.dart';

import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:jember_wisataku/widget/widget_support.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Akun_Admin extends StatefulWidget {
  const Akun_Admin({Key? key}) : super(key: key);

  @override
  State<Akun_Admin> createState() => _Akun_AdminState();
}

class _Akun_AdminState extends State<Akun_Admin> {
  bool _isEditing = false;
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _fetchUserData();
  }

  Future<void> _fetchUserData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? name = prefs.getString('name');
    String? email = prefs.getString('email');
    setState(() {
      _nameController.text = name ?? '';
      _emailController.text = email ?? '';
    });
  }

  Future<void> _saveName() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? newName = _nameController.text;
      String? accessToken = prefs.getString('access_token');

      if (accessToken != null && newName.isNotEmpty) {
        print('Access token: $accessToken');
        print('New name: $newName');

        final response = await http.put(
          Uri.parse(
              'https://jemberwisataapi-production.up.railway.app/api/auth/update'),
          headers: <String, String>{
            'Content-Type': 'application/json',
            'Authorization': 'Bearer $accessToken',
          },
          body: jsonEncode(<String, String>{
            'name': newName,
          }),
        );

        if (response.statusCode == 200) {
          print('Update berhasil: ${response.body}');
          await prefs.setString('name', newName);
        } else {
          print('Update gagal: ${response.statusCode}');
        }
      } else {
        print('Token not found or name is empty');
      }
    } catch (e, stackTrace) {
      print('Error: $e');
      print('Stack Trace: $stackTrace');
    }
  }

  Future<void> _logout() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();

      String? accessToken = prefs.getString('access_token');

      if (accessToken != null) {
        final response = await http.post(
          Uri.parse(
              'https://jemberwisataapi-production.up.railway.app/api/auth/logout'),
          headers: <String, String>{
            'Content-Type': 'application/json',
            'Authorization': 'Bearer $accessToken',
          },
          body: jsonEncode(<String, String>{
            'token': accessToken,
          }),
        );

        if (response.statusCode == 200) {
          await prefs.clear();
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => nav_guest(),
            ),
          );
          print('Logout berhasil: ${response.body}');
        } else {
          print('Logout gagal: ${response.statusCode}');
          print('Response body: ${response.body}');
        }
      } else {
        print('Access token tidak ditemukan di SharedPreferences');
      }
    } catch (e, stackTrace) {
      print('Error: $e');
      print('Stack Trace: $stackTrace');
    }
  }

  void _toggleEdit() {
    setState(() {
      if (_isEditing) {
        _saveName();
      }
      _isEditing = !_isEditing;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 246, 246, 248),
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 246, 246, 248),
        title: Text('Profil', style: AppWidget.head3TextFieldStyle()),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                Stack(
                  children: [
                    CircleAvatar(
                      radius: 50,
                      backgroundImage: NetworkImage(
                          'https://media.istockphoto.com/id/1131348804/id/vektor/ikon-pengisian-linier-wanita-bisnis-vector-gadis-bisnis-avatar-gambar-profil-gambar-garis.jpg?s=170667a&w=0&k=20&c=ixi0KyyovtLthGlo4MCephen0iZZLnF0pj8twL7qEmE='),
                    ),
                    // Uncomment this if you want to use the edit icon on the avatar
                    // Positioned(
                    //   bottom: 0,
                    //   right: 0,
                    //   child: CircleAvatar(
                    //     backgroundColor: Colors.white,
                    //     radius: 20,
                    //     child: IconButton(
                    //       icon: Icon(Icons.edit, color: Color(0xFF44DB3C)),
                    //       onPressed: _toggleEdit,
                    //     ),
                    //   ),
                    // ),
                  ],
                ),
                SizedBox(height: 20),
                _buildTextField(
                  controller: _nameController,
                  icon: Icons.person,
                  isEditing: _isEditing,
                ),
                SizedBox(height: 10),
                _buildTextField(
                  controller: _emailController,
                  icon: Icons.email,
                  isEditing: _isEditing,
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: _toggleEdit,
                  style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all<Color>(Color(0xFF00AF2C)),
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15.0),
                      ),
                    ),
                    minimumSize:
                        MaterialStateProperty.all(Size(double.infinity, 50)),
                  ),
                  child: Text(
                    _isEditing ? 'Simpan' : 'Edit',
                    style: AppWidget.labelbutton(),
                  ),
                ),
                SizedBox(height: 10),
                ElevatedButton(
                  onPressed: _logout,
                  style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all<Color>(Color(0xFFB4211C)),
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15.0),
                      ),
                    ),
                    minimumSize:
                        MaterialStateProperty.all(Size(double.infinity, 50)),
                  ),
                  child: Text("Keluar", style: AppWidget.labelbutton()),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required IconData icon,
    required bool isEditing,
  }) {
    return TextFormField(
      controller: controller,
      enabled: isEditing,
      decoration: InputDecoration(
        prefixIcon: Icon(icon, color: Color(0xFF1C1C2D)),
        filled: true,
        fillColor: const Color.fromARGB(255, 223, 223, 223),
        contentPadding: EdgeInsets.all(15),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }
}
