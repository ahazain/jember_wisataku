import 'package:flutter/material.dart';
import 'package:jember_wisataku/View/admin/akun_admin.dart';
import 'package:jember_wisataku/View/admin/nav_admin.dart';
import 'package:jember_wisataku/View/admin/home_admin.dart';
import 'package:jember_wisataku/View/publik_guest/nav_guest.dart';
import 'package:jember_wisataku/View/publik_regis/nav_regis.dart';
import 'package:jember_wisataku/widget/widget_support.dart';

class AkunGuestPage extends StatefulWidget {
  const AkunGuestPage({super.key});

  @override
  State<AkunGuestPage> createState() => _AkunGuestPageState();
}

class _AkunGuestPageState extends State<AkunGuestPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _registerEmailController =
      TextEditingController();
  final TextEditingController _registerPasswordController =
      TextEditingController();
  final TextEditingController _registerUsernameController =
      TextEditingController();

  bool isLogin = true;

  String? _userType;

  Future<void> _login() async {
    String email = _emailController.text;
    String password = _passwordController.text;

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
                    isLogin
                        ? 'assets/images/8102349-removebg-preview.png'
                        : 'assets/images/7129445-removebg-preview.png',
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
        Align(
          alignment: Alignment.centerRight,
          child: TextButton(
            onPressed: () {},
            child: Text("Lupa Kata Sandi?", style: AppWidget.styleNormal()),
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
                  MaterialPageRoute(builder: (context) => nav_admin()),
                );
              } else if (_userType == 'user') {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => nav_regis()),
                );
              } else {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Email atau kata sandi salah')),
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
        SizedBox(height: 20),
        Center(
          child: ElevatedButton(
            onPressed: () {
              // Implement your registration logic here
            },
            style: ButtonStyle(
              backgroundColor:
                  MaterialStateProperty.all<Color>(Color(0xFF00E6AC)),
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
