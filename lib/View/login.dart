import 'package:flutter/material.dart';
import 'package:jember_wisataku/View/admin/homeAdmin.dart'; // Pastikan impor halaman admin
import 'package:jember_wisataku/View/buttonnav.dart'; // Misalnya ini adalah halaman utama untuk user biasa
import 'package:jember_wisataku/View/register.dart';
import 'package:jember_wisataku/widget/widget_support.dart';

class login extends StatefulWidget {
  const login({Key? key});

  @override
  State<login> createState() => _loginState();
}

class _loginState extends State<login> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  String? _userType; // Variabel untuk menyimpan jenis pengguna (admin/user)

  // Contoh fungsi login yang memeriksa kredensial dan mengembalikan jenis pengguna
  Future<void> _login() async {
    String email = _emailController.text;
    String password = _passwordController.text;

    // Logika pemeriksaan akun
    if (email == 'admin@example.com' && password == 'admin123') {
      _userType = 'admin';
    } else if (email == 'user@example.com' && password == 'user123') {
      _userType = 'user';
    } else {
      _userType = null;
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
                    'assets/images/8102349-removebg-preview.png',
                    height: 250,
                  ),
                ),
                SizedBox(height: 20),
                Text(
                  'Masuk',
                  style: AppWidget.head3TextFieldStyle()
                      .copyWith(color: const Color.fromARGB(255, 49, 49, 49)),
                ),
                Text(
                  'Silahkan masuk untuk melanjutkan',
                  style: AppWidget.styleNormal()
                      .copyWith(color: Color.fromARGB(255, 49, 49, 49)),
                ),
                SizedBox(height: 20),
                TextFormField(
                  controller: _emailController,
                  style:
                      TextStyle(color: const Color.fromARGB(255, 49, 49, 49)),
                  decoration: InputDecoration(
                    prefixIcon: Icon(Icons.email,
                        color: const Color.fromARGB(255, 49, 49, 49)),
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
                    prefixIcon: Icon(Icons.lock,
                        color: const Color.fromARGB(255, 49, 49, 49)),
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
                Align(
                  alignment: Alignment.centerRight,
                  child: TextButton(
                    onPressed: () {
                      // Tambahkan fungsi untuk menangani lupa kata sandi di sini
                    },
                    child: Text(
                      "Lupa Kata Sandi?",
                      style: AppWidget.styleNormal(),
                    ),
                  ),
                ),
                SizedBox(height: 20),
                Center(
                  child: ElevatedButton(
                    onPressed: () async {
                      await _login();
                      if (_userType == 'admin') {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  homeAdmin(title: 'Admin Home')),
                        );
                      } else if (_userType == 'user') {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(builder: (context) => buttonNav()),
                        );
                      } else {
                        // Tampilkan pesan error jika login gagal
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                              content: Text('Email atau kata sandi salah')),
                        );
                      }
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
                      child: Text(
                        "Masuk",
                        style: AppWidget.head4TextFieldStyle()
                            .copyWith(color: Colors.black),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 10),
                Center(
                  child: GestureDetector(
                    onTap: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const Register(),
                        ),
                      );
                    },
                    child: Text.rich(
                      TextSpan(
                        children: [
                          TextSpan(
                              text: 'Belum punya akun? ',
                              style: AppWidget.umumTextFieldStyle().copyWith(
                                  color: Color.fromARGB(255, 49, 49, 49))),
                          TextSpan(
                            text: 'Daftar',
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
}
