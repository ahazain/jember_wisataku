import 'package:flutter/material.dart';
import 'package:jember_wisataku/View/admin/akun.dart';
import 'package:jember_wisataku/View/admin/homeAdmin.dart';
import 'package:jember_wisataku/View/home.dart';
import 'package:jember_wisataku/View/login.dart';
import 'package:jember_wisataku/View/akun.dart';
import 'package:jember_wisataku/View/buttonnav.dart';
import 'package:jember_wisataku/View/splash.dart';
import 'package:jember_wisataku/View/homepage.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        // home: Splash(),
        home: buttonNav());
  }
}
