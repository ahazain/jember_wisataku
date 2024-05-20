import 'package:flutter/material.dart';
import 'package:jember_wisataku/pages/admin/homeAdmin.dart';
import 'package:jember_wisataku/pages/public/akun.dart';
import 'package:jember_wisataku/pages/public/buttonnav.dart';
import 'package:jember_wisataku/pages/splash.dart';
import 'package:jember_wisataku/pages/public/homepage.dart';

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
      home: buttonNav(),
    );
  }
}
