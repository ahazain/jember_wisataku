import 'dart:async';
import 'package:flutter/material.dart';
import 'package:jember_wisataku/pages/login.dart';
import 'package:jember_wisataku/pages/register.dart';
import 'package:jember_wisataku/widget/widget_support.dart';

class Splash extends StatefulWidget {
  const Splash({super.key});

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  @override
  void initState() {
    super.initState();
    Timer(Duration(seconds: 3), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => login()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF344D3E),
      body: Container(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                'assets/images/logo.png',
                height: 250,
              ),
              Text(
                'Jember Wisata',
                style: AppWidget.head2TextFieldStyle(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
