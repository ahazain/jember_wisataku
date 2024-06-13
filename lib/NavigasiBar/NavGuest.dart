import 'package:flutter/material.dart';
import 'package:jember_wisataku/Aktor/UserPublik/ListEvent.dart';
import 'package:jember_wisataku/Aktor/UserPublik/ListWisata.dart';
import 'package:jember_wisataku/Aktor/UserPublik/ProfilGuest.dart';
import 'package:jember_wisataku/widget/widget_support.dart';

class NavGuest extends StatefulWidget {
  const NavGuest({Key? key}) : super(key: key);

  @override
  State<NavGuest> createState() => _NavGuestState();
}

class _NavGuestState extends State<NavGuest> {
  int currentTabIndex = 0;

  late List<Widget> pages;
  late Widget curretPages;
  late ListWisata homapage;
  late ListEvent acara_tahunan;
  late ProfilGuest akun;

  @override
  void initState() {
    homapage = ListWisata();
    acara_tahunan = ListEvent();
    akun = ProfilGuest();
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
