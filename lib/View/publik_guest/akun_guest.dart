import 'package:flutter/material.dart';
import 'package:jember_wisataku/View/admin/kelola_wisata/read_wisata.dart';
import 'package:jember_wisataku/NavigasiBar/nav_admin.dart';
import 'package:jember_wisataku/View/publik_guest/homepage.dart';

import 'package:jember_wisataku/NavigasiBar/nav_regis.dart';
import 'package:jember_wisataku/widget/widget_support.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class AkunPage extends StatefulWidget {
  const AkunPage({super.key});

  @override
  State<AkunPage> createState() => _AkunPageState();
}

class _AkunPageState extends State<AkunPage> {
  final TextEditingController _emailController =
      TextEditingController(text: 'admin@gmail.com');
  final TextEditingController _passwordController =
      TextEditingController(text: '12345');
  final TextEditingController _registerEmailController =
      TextEditingController();
  final TextEditingController _registerPasswordController =
      TextEditingController();
  final TextEditingController _registerUsernameController =
      TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();
  bool _isPasswordVisible = false;
  bool isLogin = true;

  String? _userType;

  Future<void> _register() async {
    // Ambil nilai dari kolom input
    String name = _registerUsernameController.text;
    String email = _registerEmailController.text;
    String password = _registerPasswordController.text;
    String confirmPassword =
        _confirmPasswordController.text; // Tambahkan baris ini

    // Periksa jika salah satu kolom kosong
    if (name.isEmpty ||
        email.isEmpty ||
        password.isEmpty ||
        confirmPassword.isEmpty) {
      // Tampilkan AlertDialog untuk memberikan peringatan
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Kolom Harus Diisi'),
            content: Text('Harap lengkapi semua kolom untuk mendaftar.'),
            actions: [
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
      return;
    }

    // Periksa jika kata sandi dan konfirmasi kata sandi cocok
    if (password != confirmPassword) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Konfirmasi Kata Sandi Tidak Cocok'),
            content:
                Text('Pastikan konfirmasi kata sandi sama dengan kata sandi.'),
            actions: [
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
      return;
    }

    // Periksa jika alamat email tidak sesuai format
    final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    if (!emailRegex.hasMatch(email)) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Email Tidak Terdefinisi'),
            content: Text('Masukkan alamat email yang valid.'),
            actions: [
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
      return; // Hentikan proses pendaftaran jika alamat email tidak valid
    }
    if (password.length < 8) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Kata Sandi Terlalu Pendek'),
            content: Text('Kata sandi harus memiliki minimal 8 karakter.'),
            actions: [
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
      return; // Hentikan proses pendaftaran jika kata sandi terlalu pendek
    }

    final url = Uri.parse(
        'https://jemberwisataapi-production.up.railway.app/api/auth/register');
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

    if (response.statusCode == 200) {
      final responseData = json.decode(response.body);
      if (responseData['message'] == 'PENDAFTARAN BERHASIL') {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text('Pendaftaran Berhasil'),
              content: Text('Selamat! Anda berhasil mendaftar.'),
              actions: [
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
        setState(() {
          isLogin = true;
        });
      } else {
        if (responseData['message'] == null) {
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: Text('Pendaftaran Gagal'),
                content: Text('Email sudah pernah digunakan.'),
                actions: [
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
          // Show general error message
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('${responseData['message']}'),
            ),
          );
        }
      }
    }
  }

  Future<void> _login() async {
    String email = _emailController.text;
    String password = _passwordController.text;

    // Periksa jika salah satu kolom kosong
    if (email.isEmpty || password.isEmpty) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Kolom Harus Diisi'),
            content: Text('Harap lengkapi semua kolom untuk masuk.'),
            actions: [
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
      return; // Hentikan proses login jika ada kolom yang kosong
    }

    // Periksa jika alamat email tidak sesuai format
    final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    if (!emailRegex.hasMatch(email)) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Email Tidak Valid'),
            content: Text('Masukkan alamat email yang valid.'),
            actions: [
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
      return; // Hentikan proses login jika alamat email tidak valid
    }

    final url = Uri.parse(
        'https://jemberwisataapi-production.up.railway.app/api/auth/login');
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

    if (response.statusCode == 200) {
      final Map<String, dynamic> responseData = json.decode(response.body);
      if (responseData['access_token'] != null) {
        setState(() {
          _userType = responseData['user']['role'];
        });
        print(responseData);
        SharedPreferences prefs = await SharedPreferences.getInstance();
        await prefs.setString('access_token', responseData['access_token']);
        await prefs.setInt('id', responseData['user']['id']);
        await prefs.setString('name', responseData['user']['name']);
        await prefs.setString('email', responseData['user']['email']);
        await prefs.setString('role', responseData['user']['role']);

        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text('Berhasil'),
              content: Text('Selamat! Anda berhasil masuk.'),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                    if (_userType == 'admin') {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (context) => NavAdmin()),
                      );
                    } else if (_userType == 'publik') {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (context) => nav_regis()),
                      );
                    }
                  },
                  child: Text('OK'),
                ),
              ],
            );
          },
        );
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('PERIKSA EMAIL DAN KATASANDI ANDA'),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 255, 255, 255),
      body: Center(
        child: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.all(20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Image.asset(
                    isLogin
                        ? 'assets/images/8102349-removebg-preview.png'
                        : 'assets/images/8102349-removebg-preview.png',
                    height: isLogin ? 250 : 290,
                  ),
                ),
                SizedBox(height: 20),
                Text(
                  isLogin ? 'Masuk' : 'Daftar',
                  style: AppWidget.head3TextFieldStyle()
                      .copyWith(color: const Color.fromARGB(255, 49, 49, 49)),
                ),
                Text(
                  isLogin
                      ? 'Silahkan masuk untuk melanjutkan'
                      : 'Silahkan daftar untuk melanjutkan',
                  style: AppWidget.styleNormal()
                      .copyWith(color: Color.fromARGB(255, 49, 49, 49)),
                ),
                SizedBox(height: 20),
                if (isLogin) ...[
                  _buildLoginForm(),
                ] else ...[
                  _buildRegisterForm(),
                ],
                SizedBox(height: 10),
                Center(
                  child: GestureDetector(
                    onTap: () {
                      setState(() {
                        isLogin = !isLogin;
                      });
                    },
                    child: Text.rich(
                      TextSpan(
                        children: [
                          TextSpan(
                            text: isLogin
                                ? 'Belum punya akun? '
                                : 'Sudah punya akun? ',
                            style: AppWidget.umumTextFieldStyle().copyWith(
                                color: Color.fromARGB(255, 49, 49, 49)),
                          ),
                          TextSpan(
                            text: isLogin ? 'Daftar' : 'Masuk',
                            style: AppWidget.umumTextFieldStyle().copyWith(
                                color: Color.fromARGB(255, 88, 172, 88)),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildLoginForm() {
    return Column(
      children: [
        TextFormField(
          controller: _emailController,
          style: TextStyle(color: const Color.fromARGB(255, 49, 49, 49)),
          decoration: InputDecoration(
            prefixIcon:
                Icon(Icons.email, color: const Color.fromARGB(255, 49, 49, 49)),
            labelText: "Email",
            labelStyle: AppWidget.styleNormal(),
            filled: true,
            fillColor: Color.fromARGB(255, 210, 210, 210),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15),
              borderSide: BorderSide.none,
            ),
          ),
        ),
        SizedBox(height: 20),
        TextFormField(
          controller: _passwordController,
          style: AppWidget.styleNormal(),
          obscureText: true,
          decoration: InputDecoration(
            prefixIcon:
                Icon(Icons.lock, color: const Color.fromARGB(255, 49, 49, 49)),
            labelText: "Kata Sandi",
            labelStyle: AppWidget.styleNormal(),
            filled: true,
            fillColor: Color.fromARGB(255, 210, 210, 210),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15),
              borderSide: BorderSide.none,
            ),
          ),
        ),
        SizedBox(height: 10),
        // Align(
        //   alignment: Alignment.centerRight,
        //   child: TextButton(
        //     onPressed: () {},
        //     child: Text("Lupa Kata Sandi?", style: AppWidget.styleNormal()),
        //   ),
        // ),
        SizedBox(height: 20),
        Center(
          child: ElevatedButton(
            onPressed: () async {
              await _login();
            },
            style: ButtonStyle(
              backgroundColor:
                  MaterialStateProperty.all<Color>(Color(0xFF77DD77)),
              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15.0),
                ),
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 16),
              child: Text("Masuk",
                  style: AppWidget.head4TextFieldStyle()
                      .copyWith(color: Colors.black)),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildRegisterForm() {
    return Column(
      children: [
        TextFormField(
          controller: _registerUsernameController,
          style: TextStyle(color: const Color.fromARGB(255, 49, 49, 49)),
          decoration: InputDecoration(
            prefixIcon: Icon(Icons.person,
                color: const Color.fromARGB(255, 49, 49, 49)),
            labelText: "Nama Pengguna",
            labelStyle: AppWidget.styleNormal(),
            filled: true,
            fillColor: Color.fromARGB(255, 210, 210, 210),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15),
              borderSide: BorderSide.none,
            ),
          ),
        ),
        SizedBox(height: 20),
        TextFormField(
          controller: _registerEmailController,
          style: TextStyle(color: const Color.fromARGB(255, 49, 49, 49)),
          decoration: InputDecoration(
            prefixIcon:
                Icon(Icons.email, color: const Color.fromARGB(255, 49, 49, 49)),
            labelText: "Email",
            labelStyle: AppWidget.styleNormal(),
            filled: true,
            fillColor: Color.fromARGB(255, 210, 210, 210),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15),
              borderSide: BorderSide.none,
            ),
          ),
        ),
        SizedBox(height: 20),
        TextFormField(
          controller: _registerPasswordController,
          style: TextStyle(color: const Color.fromARGB(255, 49, 49, 49)),
          obscureText: !_isPasswordVisible, // Add this line
          decoration: InputDecoration(
            prefixIcon:
                Icon(Icons.lock, color: const Color.fromARGB(255, 49, 49, 49)),
            labelText: "Kata Sandi",
            labelStyle: AppWidget.styleNormal(),
            filled: true,
            fillColor: Color.fromARGB(255, 210, 210, 210),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15),
              borderSide: BorderSide.none,
            ),
            // Add IconButton for password visibility toggle
            suffixIcon: IconButton(
              icon: Icon(
                _isPasswordVisible ? Icons.visibility : Icons.visibility_off,
                color: const Color.fromARGB(255, 49, 49, 49),
              ),
              onPressed: () {
                setState(() {
                  _isPasswordVisible = !_isPasswordVisible;
                });
              },
            ),
          ),
        ),
        SizedBox(height: 20),
        TextFormField(
          controller: _confirmPasswordController,
          style: TextStyle(color: const Color.fromARGB(255, 49, 49, 49)),
          obscureText: !_isPasswordVisible, // Add this line
          decoration: InputDecoration(
            prefixIcon:
                Icon(Icons.lock, color: const Color.fromARGB(255, 49, 49, 49)),
            labelText: "Konfirmasi Kata Sandi",
            labelStyle: AppWidget.styleNormal(),
            filled: true,
            fillColor: Color.fromARGB(255, 210, 210, 210),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15),
              borderSide: BorderSide.none,
            ),
            // Add IconButton for password visibility toggle
            suffixIcon: IconButton(
              icon: Icon(
                _isPasswordVisible ? Icons.visibility : Icons.visibility_off,
                color: const Color.fromARGB(255, 49, 49, 49),
              ),
              onPressed: () {
                setState(() {
                  _isPasswordVisible = !_isPasswordVisible;
                });
              },
            ),
          ),
        ),
        SizedBox(height: 20),
        Center(
          child: ElevatedButton(
            onPressed: () async {
              await _register();
            },
            style: ButtonStyle(
              backgroundColor:
                  MaterialStateProperty.all<Color>(Color(0xFF77DD77)),
              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15.0),
                ),
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 16),
              child: Text("Daftar",
                  style: AppWidget.head4TextFieldStyle()
                      .copyWith(color: Colors.black)),
            ),
          ),
        ),
      ],
    );
  }
}
