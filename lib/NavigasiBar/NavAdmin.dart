import 'package:flutter/material.dart';
import 'package:jember_wisataku/Aktor/Admin/KelolaEvent/ReadEvent.dart';
import 'package:jember_wisataku/Aktor/Admin/KelolaWisata/ReadWisata.dart';
import 'package:jember_wisataku/Aktor/Admin/ProfilAdmin.dart';
import 'package:jember_wisataku/widget/widget_support.dart';

class NavAdmin extends StatefulWidget {
  const NavAdmin({Key? key}) : super(key: key);

  @override
  State<NavAdmin> createState() => _NavAdminState();
}

class _NavAdminState extends State<NavAdmin> {
  int currentTabIndex = 0;

  late List<Widget> pages;
  late ReadWisata homePage;
  late ReadEvent event;
  late ProfilAdmin akunPage;

  @override
  void initState() {
    super.initState();
    homePage = ReadWisata(
      title: 'homeadmin',
    );
    event = ReadEvent(title: 'event');
    akunPage = ProfilAdmin();
    pages = [homePage, event, akunPage];
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
            label: 'Acara Tahunan',
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
