import 'package:flutter/material.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:jember_wisataku/View/publik_guest/acara_tahunan.dart';
import 'package:jember_wisataku/View/publik_guest/homepage.dart';
import 'package:jember_wisataku/View/publik_regis/akun_regis.dart';
import 'package:jember_wisataku/View/publik_guest/akun_guest.dart';
import 'package:jember_wisataku/widget/widget_support.dart';

class nav_guest extends StatefulWidget {
  const nav_guest({Key? key}) : super(key: key);

  @override
  State<nav_guest> createState() => _nav_guestState();
}

class _nav_guestState extends State<nav_guest> {
  int currentTabIndex = 0;

  late List<Widget> pages;
  late Widget curretPages;
  late HomePage homapage;
  late acaratahunan acara_tahunan;
  late AkunGuestPage akun;

  @override
  void initState() {
    homapage = HomePage();
    acara_tahunan = acaratahunan();
    akun = AkunGuestPage();
    pages = [homapage, acara_tahunan, akun];
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
        unselectedItemColor: Color.fromARGB(255, 62, 62, 62),
        selectedItemColor: Color.fromARGB(255, 255, 255, 255),
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
