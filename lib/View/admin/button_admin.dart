import 'package:flutter/material.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:jember_wisataku/View/admin/home_admin.dart';
import 'package:jember_wisataku/View/publik_guest/acara_tahunan.dart';
import 'package:jember_wisataku/View/publik_regis/akun_regis.dart';
import 'package:jember_wisataku/View/publik_guest/akun_guest.dart';
import 'package:jember_wisataku/View/publik_guest/home.dart';
import 'package:jember_wisataku/widget/widget_support.dart';

class button_admin extends StatefulWidget {
  const button_admin({Key? key}) : super(key: key);

  @override
  State<button_admin> createState() => _Button_adminState();
}

class _Button_adminState extends State<button_admin> {
  int currentTabIndex = 0;

  late List<Widget> pages;
  late Widget curretPages;
  late home_admin homapage;
  late akun_admin Akun;
  @override
  void initState() {
    homapage = home_admin(title: 'Admin Home');
    Akun = akun_admin();
    pages = [homapage, Akun];
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
            icon: Icon(Icons.person),
            label: 'Akun',
          ),
        ],
      ),
      body: pages[currentTabIndex],
    );
  }
}
