import 'package:flutter/material.dart';
import 'package:jember_wisataku/Aktor/UserPublik/ListEvent.dart';
import 'package:jember_wisataku/Aktor/UserPublik/ListWisata.dart';
import 'package:jember_wisataku/Aktor/UserPublik/ProfilRegis.dart';


import 'package:jember_wisataku/widget/widget_support.dart';

class NavRegis extends StatefulWidget {
  const NavRegis({Key? key}) : super(key: key);

  @override
  State<NavRegis> createState() => _Button_nonNavRegisState();
}

class _Button_nonNavRegisState extends State<NavRegis> {
  int currentTabIndex = 0;

  late List<Widget> pages;
  late Widget curretPages;
  late ListWisata homapage;
  late ListEvent acara_tahunan;
  late ProfilRegis Akun;
  @override
  void initState() {
    homapage = ListWisata();
    acara_tahunan = ListEvent();
    Akun = ProfilRegis();
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
