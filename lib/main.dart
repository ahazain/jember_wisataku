import 'package:flutter/material.dart';
import 'package:jember_wisataku/View/admin/akun_admin.dart';
import 'package:jember_wisataku/View/admin/home_admin.dart';
import 'package:jember_wisataku/View/publik_guest/akun_guest.dart';
import 'package:jember_wisataku/View/publik_guest/homepage.dart';
import 'package:jember_wisataku/View/publik_regis/akun_regis.dart';
import 'package:jember_wisataku/View/publik_regis/nav_regis.dart';
import 'package:jember_wisataku/View/publik_guest/splash.dart';
import 'package:jember_wisataku/View/publik_guest/nav_guest.dart';

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
        home: Splash());
  }
}
