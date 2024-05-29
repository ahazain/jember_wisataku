import 'package:flutter/material.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:jember_wisataku/View/acara_tahunan.dart';
import 'package:jember_wisataku/View/akun.dart';
import 'package:jember_wisataku/View/home.dart';
import 'package:jember_wisataku/widget/widget_support.dart';

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
