import 'package:flutter/material.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:jember_wisataku/pages/public/acara_tahunan.dart';
import 'package:jember_wisataku/pages/public/akun.dart';
import 'package:jember_wisataku/pages/public/home.dart';

class buttonNav extends StatefulWidget {
  const buttonNav({Key? key}) : super(key: key);

  @override
  State<buttonNav> createState() => _ButtonNavState();
}

class _ButtonNavState extends State<buttonNav> {
  int currentTabIndex = 0;

  late List<Widget> pages;
  late Widget curretPages;
  late HomePage homapage;
  late acaratahunan acara_tahunan;
  late akun Akun;
  @override
  void initState() {
    homapage = HomePage();
    acara_tahunan = acaratahunan();
    Akun = akun();
    pages = [homapage, acara_tahunan, Akun];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: CurvedNavigationBar(
        height: 50,
        color: Color(0xFF0EF11A),
        backgroundColor: Color.fromARGB(22, 255, 255, 255),
        onTap: (int index) {
          setState(() {
            currentTabIndex = index;
          });
        },
        items: [
          Icon(Icons.home),
          Icon(Icons.event),
          Icon(Icons.person),
        ],
      ),
      body: pages[currentTabIndex],
    );
  }
}
