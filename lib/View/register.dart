import 'package:flutter/material.dart';
import 'package:jember_wisataku/View/login.dart';
import 'package:jember_wisataku/View/buttonnav.dart';
import 'package:jember_wisataku/widget/widget_support.dart';
import 'package:jember_wisataku/View/register.dart';

class Register extends StatefulWidget {
  const Register({Key? key});

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF1C1C2D),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(20),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  children: [
                    Center(
                      child: Image.asset(
                        'assets/images/7129445-removebg-preview.png',
                        height: 290,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 20),
                Text(
                  'Daftar',
                  style: AppWidget.head3TextFieldStyle()
                      .copyWith(color: Colors.white),
                ),
                Text(
                  'Silahkan daftar untuk melanjutkan',
                  style: AppWidget.styleNormal()
                      .copyWith(color: Color.fromARGB(106, 255, 255, 255)),
                ),
                SizedBox(height: 20),
                TextFormField(
                  style: TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                    prefixIcon: Icon(Icons.person, color: Colors.white),
                    labelText: "Nama Pengguna",
                    labelStyle: AppWidget.styleNormal(),
                    filled: true,
                    fillColor: Color(0xFF2D2D44),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                      borderSide: BorderSide.none,
                    ),
                  ),
                ),
                SizedBox(height: 20),
                TextFormField(
                  style: TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                    prefixIcon: Icon(Icons.email, color: Colors.white),
                    labelText: "Email",
                    labelStyle: AppWidget.styleNormal(),
                    filled: true,
                    fillColor: Color(0xFF2D2D44),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                      borderSide: BorderSide.none,
                    ),
                  ),
                ),
                SizedBox(height: 20),
                TextFormField(
                  style: AppWidget.styleNormal(),
                  obscureText: true,
                  decoration: InputDecoration(
                    prefixIcon: Icon(Icons.lock, color: Colors.white),
                    labelText: "Kata Sandi",
                    labelStyle: AppWidget.styleNormal(),
                    filled: true,
                    fillColor: Color(0xFF2D2D44),
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
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => login(),
                        ),
                      );
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
                    child: Text(
                      "Daftar",
                      style: AppWidget.head4TextFieldStyle()
                          .copyWith(color: Colors.black),
                    ),
                  ),
                ),
                SizedBox(height: 10),
                GestureDetector(
                  onTap: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => login(),
                      ),
                    );
                  },
                  child: Center(
                    child: Text.rich(
                      TextSpan(
                        children: [
                          TextSpan(
                            text: 'Sudah punya akun? ',
                            style: AppWidget.umumTextFieldStyle()
                                .copyWith(color: Colors.white),
                          ),
                          TextSpan(
                            text: 'Masuk',
                            style: AppWidget.umumTextFieldStyle()
                                .copyWith(color: Color(0xFF00E6AC)),
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
