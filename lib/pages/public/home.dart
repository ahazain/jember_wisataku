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
        child: Stack(
          children: [
            // Container hijau berbentuk oval
            Positioned(
              top: -100,
              left: -50,
              child: Container(
                width: 423,
                height: 408,
                decoration: ShapeDecoration(
                  color: Color(0xFF67ED38),
                  shape: OvalBorder(),
                ),
              ),
            ),
            // Konten lain di atas container hijau
            Container(
              margin: EdgeInsets.only(top: 20.0, left: 17.0, right: 10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Hi, Wisatawan", style: AppWidget.boldTextFieldStyle()),
                  SizedBox(height: 10.0),
                  Text("Jember Indah", style: AppWidget.headTextFieldStyle()),
                  SizedBox(height: 10.0),
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
                              color: Colors.grey,
                            ),
                            prefixIcon: Icon(
                              Icons.search,
                              color: Colors.grey,
                            ),
                            filled: true,
                            fillColor: Color.fromARGB(255, 222, 222, 222),
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
                                  onTap: () {},
                                ),
                                ListTile(
                                  title: Text('Wisata Alam',
                                      style: AppWidget.umumTextFieldStyle()),
                                  onTap: () {},
                                ),
                                ListTile(
                                  title: Text('Wisata Sejarah',
                                      style: AppWidget.umumTextFieldStyle()),
                                  onTap: () {},
                                ),
                                ListTile(
                                  title: Text('Wisata Edukasi',
                                      style: AppWidget.umumTextFieldStyle()),
                                  onTap: () {},
                                ),
                                ListTile(
                                  title: Text('Wisata Belanja',
                                      style: AppWidget.umumTextFieldStyle()),
                                  onTap: () {},
                                ),
                                ListTile(
                                  title: Text('Wisata Kuliner',
                                      style: AppWidget.umumTextFieldStyle()),
                                  onTap: () {},
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(height: 20.0),
                  ...buildTouristAttractions(context),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  List<Widget> buildTouristAttractions(BuildContext context) {
    List<Map<String, String>> attractions = [
      {
        "image":
            "https://4.bp.blogspot.com/-aIV3NUiKsrk/Ul7bhmliTLI/AAAAAAAADWk/udAysmRkqrU/s1600/gbr+papuma.jpg",
        "title": "Pantai Papuma"
      },
      {
        "image":
            "https://4.bp.blogspot.com/-aIV3NUiKsrk/Ul7bhmliTLI/AAAAAAAADWk/udAysmRkqrU/s1600/gbr+papuma.jpg",
        "title": "Pantai Papuma"
      },
      {
        "image":
            "https://4.bp.blogspot.com/-aIV3NUiKsrk/Ul7bhmliTLI/AAAAAAAADWk/udAysmRkqrU/s1600/gbr+papuma.jpg",
        "title": "Pantai Papuma"
      },
      // Tambahkan lebih banyak objek wisata jika diperlukan
    ];

    List<Widget> attractionWidgets = [];
    for (var attraction in attractions) {
      attractionWidgets.add(
        Column(
          children: [
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
                      attraction["image"]!,
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
                          child: Text(
                            attraction["title"]!,
                            style: AppWidget.headTextFieldStyle(),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 20.0),
          ],
        ),
      );
    }
    return attractionWidgets;
  }
}
