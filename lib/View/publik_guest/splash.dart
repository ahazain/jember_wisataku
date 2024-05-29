import 'dart:async';
import 'package:flutter/material.dart';
import 'package:jember_wisataku/View/admin/home_admin.dart';
import 'package:jember_wisataku/View/publik_guest/nav_guest.dart';
import 'package:jember_wisataku/widget/widget_support.dart';
import 'package:animated_text_kit/animated_text_kit.dart';

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
        MaterialPageRoute(builder: (context) => nav_guest()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 248, 248, 248),
      body: Container(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                'assets/images/logo.png',
                height: 250,
              ),
              SizedBox(height: 20),
              AnimatedTextKit(
                animatedTexts: [
                  WavyAnimatedText(
                    'Jember Wisata',
                    textStyle: AppWidget.head2TextFieldStyle(),
                    speed: Duration(milliseconds: 200),
                  ),
                ],
                isRepeatingAnimation: true,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
