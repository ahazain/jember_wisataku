import 'package:flutter/material.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:jember_wisataku/View/publik_guest/acara_tahunan.dart';
import 'package:jember_wisataku/View/publik_guest/detail_AcaraTahunan.dart';
import 'package:jember_wisataku/View/publik_guest/homepage.dart';
import 'package:jember_wisataku/View/publik_regis/akun_regis.dart';

import 'package:jember_wisataku/widget/widget_support.dart';

class nav_regis extends StatefulWidget {
  const nav_regis({Key? key}) : super(key: key);

  @override
  State<nav_regis> createState() => _Button_nonnav_regisState();
}

class _Button_nonnav_regisState extends State<nav_regis> {
  int currentTabIndex = 0;

  late List<Widget> pages;
  late Widget curretPages;
  late HomePage homapage;
  late AcaraTahunan acara_tahunan;
  late akun_regis Akun;
  @override
  void initState() {
    homapage = HomePage();
    acara_tahunan = AcaraTahunan();
    Akun = akun_regis();
    pages = [homapage, acara_tahunan, Akun];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentTabIndex,
        onTap: (int index) {
          setState(() {
            currentTabIndex = index;
          });
        },
        backgroundColor: Color(0xFF77DD77), // Warna hijau
        selectedItemColor: Color.fromARGB(255, 62, 62, 62),

        unselectedItemColor: Color.fromARGB(255, 253, 230, 230),
        selectedLabelStyle: AppWidget.labelbutton(),
        unselectedLabelStyle: AppWidget.labelbutton(),
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.event),
            label: 'Event',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Akun',
          ),
        ],
      ),
      body: pages[currentTabIndex],
    );
  }
}
