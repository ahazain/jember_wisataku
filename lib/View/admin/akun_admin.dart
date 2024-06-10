import 'package:flutter/material.dart';
import 'package:jember_wisataku/NavigasiBar/nav_guest.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Akun_Admin extends StatefulWidget {
  const Akun_Admin({Key? key}) : super(key: key);

  @override
  State<Akun_Admin> createState() => _Akun_AdminState();
}

class _Akun_AdminState extends State<Akun_Admin> {
  bool _isEditing = false;
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  String? _userId;

  @override
  void initState() {
    super.initState();
    _fetchUserData();
  }

  Future<void> _fetchUserData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? name = prefs.getString('name');
    String? email = prefs.getString('email');
    String? userId = prefs.getString('user_id');
    setState(() {
      _nameController.text = name ?? '';
      _emailController.text = email ?? '';
      _userId = userId;
    });
  }

  void _toggleEdit() {
    setState(() {
      if (_isEditing) {
        _saveName();
      }
      _isEditing = !_isEditing;
    });
  }

  Future<void> _saveName() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? newName = _nameController.text.trim(); // Trim whitespace
      String? accessToken = prefs.getString('access_token');

      if (newName!.isEmpty) {
        // Menampilkan alert jika nama kosong setelah tombol simpan ditekan
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text('Peringatan'),
              content: Text(
                  'Kolom nama tidak boleh kosong. Data akan kembali riset'),
              actions: <Widget>[
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text('OK'),
                ),
              ],
            );
          },
        );
      } else if (accessToken != null) {
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

          // Menampilkan alert ketika data berhasil diubah
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: Text('Sukses'),
                content: Text('Data berhasil diubah.'),
                actions: <Widget>[
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: Text('OK'),
                  ),
                ],
              );
            },
          );
        } else {
          print('Update gagal: ${response.statusCode}');
        }
      } else {
        print('Token not found');
      }
    } catch (e, stackTrace) {
      print('Error: $e');
      print('Stack Trace: $stackTrace');
    }
  }

  Future<void> _confirmLogout() async {
    return showDialog<void>(
      context: context,
      barrierDismissible:
          false, // dialog tidak bisa ditutup dengan mengetuk di luar
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Konfirmasi Logout'),
          content: SingleChildScrollView(
            child: ListBody(
              children: const <Widget>[
                Text('Anda yakin ingin keluar?'),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Tidak'),
              onPressed: () {
                Navigator.of(context)
                    .pop(); // Tutup dialog tanpa melakukan logout
              },
            ),
            TextButton(
              child: const Text('Ya'),
              onPressed: () {
                _logout(); // Lakukan logout
                Navigator.of(context).pop(); // Tutup dialog setelah logout
              },
            ),
          ],
        );
      },
    );
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 246, 246, 248),
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 246, 246, 248),
        title: Text(
          'Profil',
          style: TextStyle(fontSize: 24, color: Colors.black),
        ),
        automaticallyImplyLeading: false,
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                Stack(
                  children: const [
                    CircleAvatar(
                      radius: 50,
                      backgroundImage: NetworkImage(
                          'https://media.istockphoto.com/id/1131348804/id/vektor/ikon-pengisian-linier-wanita-bisnis-vector-gadis-bisnis-avatar-gambar-profil-gambar-garis.jpg?s=170667a&w=0&k=20&c=ixi0KyyovtLthGlo4MCephen0iZZLnF0pj8twL7qEmE='),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                _buildTextField(
                  controller: _nameController,
                  icon: Icons.person,
                  isEditing: _isEditing,
                ),
                const SizedBox(height: 10),
                _buildTextField(
                  controller: _emailController,
                  icon: Icons.email,
                  isEditing: false,
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: _toggleEdit,
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all<Color>(
                      _isEditing ? const Color(0xFF00AF2C) : Colors.grey,
                    ),
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15.0),
                      ),
                    ),
                    minimumSize: MaterialStateProperty.all(
                      const Size(double.infinity, 50),
                    ),
                  ),
                  child: Text(
                    _isEditing ? 'Simpan' : 'Edit',
                    style: TextStyle(fontSize: 18, color: Colors.white),
                  ),
                ),
                const SizedBox(height: 10),
                ElevatedButton(
                  onPressed: _confirmLogout,
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all<Color>(
                      const Color(0xFFB4211C),
                    ),
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15.0),
                      ),
                    ),
                    minimumSize: MaterialStateProperty.all(
                      const Size(double.infinity, 50),
                    ),
                  ),
                  child: Text(
                    "Keluar",
                    style: TextStyle(fontSize: 18, color: Colors.white),
                  ),
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
        prefixIcon: Icon(icon, color: const Color(0xFF1C1C2D)),
        filled: true,
        fillColor: const Color.fromARGB(255, 223, 223, 223),
        contentPadding: const EdgeInsets.all(15),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }
}
