import 'package:flutter/material.dart';
import 'package:jember_wisataku/pages/public/detail_wisata/details.dart';
import 'package:jember_wisataku/widget/widget_support.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
      child: Container(
        margin: EdgeInsets.only(top: 20.0, left: 17.0, right: 10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Hi, Wisatawan", style: AppWidget.boldTextFieldStyle()),
            SizedBox(
              height: 10.0,
            ),
            Text("Jember Indah", style: AppWidget.headTextFieldStyle()),
            SizedBox(
              height: 10.0,
            ),
            Row(
              children: [
                Expanded(
                  child: TextField(
                    style: AppWidget.umumTextFieldStyle(),
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(17.0),
                        borderSide: BorderSide.none,
                      ),
                      hintText: "eg. wisata kawah ijen",
                      hintStyle: TextStyle(
                        color:
                            Colors.grey, // Memberikan warna abu-abu pada hint
                      ),
                      prefixIcon: Icon(
                        Icons.search,
                        color: Colors
                            .grey, // Memberikan warna abu-abu pada ikon search
                      ),
                      filled: true, // Mengisi latar belakang dengan warna
                      fillColor: Color.fromARGB(
                          255, 222, 222, 222), // Warna latar belakang
                    ),
                  ),
                ),
                PopupMenuButton(
                  icon: Icon(Icons.filter_list),
                  itemBuilder: (BuildContext context) => <PopupMenuEntry>[
                    PopupMenuItem(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Jenis Wisata',
                              style: AppWidget.boldTextFieldStyle()),
                          SizedBox(height: 8),
                          ListTile(
                            title: Text('Semua Wisata',
                                style: AppWidget.umumTextFieldStyle()),
                            onTap: () {
                              // Tambahkan logika untuk menangani pemilihan filter 1
                            },
                          ),
                          ListTile(
                            title: Text('Wisata Alam',
                                style: AppWidget.umumTextFieldStyle()),
                            onTap: () {
                              // Tambahkan logika untuk menangani pemilihan filter 1
                            },
                          ),
                          ListTile(
                            title: Text('Wisata Sejarah',
                                style: AppWidget.umumTextFieldStyle()),
                            onTap: () {
                              // Tambahkan logika untuk menangani pemilihan filter 1
                            },
                          ),
                          ListTile(
                            title: Text('Wisata Edukasi',
                                style: AppWidget.umumTextFieldStyle()),
                            onTap: () {
                              // Tambahkan logika untuk menangani pemilihan filter 1
                            },
                          ),
                          ListTile(
                            title: Text('Wisata Belanja',
                                style: AppWidget.umumTextFieldStyle()),
                            onTap: () {
                              // Tambahkan logika untuk menangani pemilihan filter 1
                            },
                          ),
                          ListTile(
                            title: Text('Wisata Kuliner',
                                style: AppWidget.umumTextFieldStyle()),
                            onTap: () {
                              // Tambahkan logika untuk menangani pemilihan filter 1
                            },
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(height: 20.0),
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => details()),
                );
              },
              child: Center(
                child: Stack(
                  children: [
                    Image.network(
                      "https://4.bp.blogspot.com/-aIV3NUiKsrk/Ul7bhmliTLI/AAAAAAAADWk/udAysmRkqrU/s1600/gbr+papuma.jpg",
                      height: 218,
                    ),
                    Positioned(
                      top: 150,
                      left: 0,
                      right: 0,
                      child: Container(
                        color: Color.fromARGB(82, 159, 159, 159),
                        padding: EdgeInsets.symmetric(vertical: 20.0),
                        child: Center(
                          child: Text("Pantai Papuma",
                              style: AppWidget.headTextFieldStyle()),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 20.0),
            GestureDetector(
              onTap: () {
                // Navigator.push(
                //   context,
                //   MaterialPageRoute(builder: (context) => DetailPage()),
                // );
              },
              child: Center(
                child: Stack(
                  children: [
                    Image.network(
                      "https://4.bp.blogspot.com/-aIV3NUiKsrk/Ul7bhmliTLI/AAAAAAAADWk/udAysmRkqrU/s1600/gbr+papuma.jpg",
                      height: 218,
                    ),
                    Positioned(
                      top: 150,
                      left: 0,
                      right: 0,
                      child: Container(
                        color: Color.fromARGB(82, 159, 159, 159),
                        padding: EdgeInsets.symmetric(vertical: 20.0),
                        child: Center(
                          child: Text("Pantai Papuma",
                              style: AppWidget.headTextFieldStyle()),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 20.0),
            GestureDetector(
              onTap: () {
                // Navigator.push(
                //   context,
                //   MaterialPageRoute(builder: (context) => DetailPage()),
                // );
              },
              child: Center(
                child: Stack(
                  children: [
                    Image.network(
                      "https://4.bp.blogspot.com/-aIV3NUiKsrk/Ul7bhmliTLI/AAAAAAAADWk/udAysmRkqrU/s1600/gbr+papuma.jpg",
                      height: 218,
                    ),
                    Positioned(
                      top: 150,
                      left: 0,
                      right: 0,
                      child: Container(
                        color: Color.fromARGB(82, 159, 159, 159),
                        padding: EdgeInsets.symmetric(vertical: 20.0),
                        child: Center(
                          child: Text("Pantai Papuma",
                              style: AppWidget.headTextFieldStyle()),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 20.0),
            GestureDetector(
              onTap: () {
                // Navigator.push(
                //   context,
                //   MaterialPageRoute(builder: (context) => DetailPage()),
                // );
              },
              child: Center(
                child: Stack(
                  children: [
                    Image.network(
                      "https://4.bp.blogspot.com/-aIV3NUiKsrk/Ul7bhmliTLI/AAAAAAAADWk/udAysmRkqrU/s1600/gbr+papuma.jpg",
                      height: 218,
                    ),
                    Positioned(
                      top: 150,
                      left: 0,
                      right: 0,
                      child: Container(
                        color: Color.fromARGB(82, 159, 159, 159),
                        padding: EdgeInsets.symmetric(vertical: 20.0),
                        child: Center(
                          child: Text("Pantai Papuma",
                              style: AppWidget.headTextFieldStyle()),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 20.0),
            GestureDetector(
              onTap: () {
                // Navigator.push(
                //   context,
                //   MaterialPageRoute(builder: (context) => DetailPage()),
                // );
              },
              child: Center(
                child: Stack(
                  children: [
                    Image.network(
                      "https://4.bp.blogspot.com/-aIV3NUiKsrk/Ul7bhmliTLI/AAAAAAAADWk/udAysmRkqrU/s1600/gbr+papuma.jpg",
                      height: 218,
                    ),
                    Positioned(
                      top: 150,
                      left: 0,
                      right: 0,
                      child: Container(
                        color: Color.fromARGB(82, 159, 159, 159),
                        padding: EdgeInsets.symmetric(vertical: 20.0),
                        child: Center(
                          child: Text("Pantai Papuma",
                              style: AppWidget.headTextFieldStyle()),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    ));
  }
}
