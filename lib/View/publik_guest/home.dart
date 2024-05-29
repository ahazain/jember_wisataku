import 'package:flutter/material.dart';
import 'package:jember_wisataku/View/publik_guest/detail_wisata/details.dart';
import 'package:jember_wisataku/widget/widget_support.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 246, 246, 248),
      body: Stack(
        children: [
          // Green oval background
          Positioned(
            top: -100,
            left: -100,
            child: Container(
              width: 423,
              height: 408,
              decoration: ShapeDecoration(
                color: Color(0xFF77DD77),
                shape: OvalBorder(),
              ),
            ),
          ),

          // Top section
          Positioned(
            top: 20.0,
            left: 17.0,
            right: 10.0,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Hi, Wisatawan",
                    style: AppWidget.boldTextFieldStyle().copyWith(
                        color: const Color.fromARGB(255, 93, 93, 93))),
                SizedBox(height: 10.0),
                Text("Jember Indah",
                    style: AppWidget.headTextFieldStyle().copyWith(
                        color: const Color.fromARGB(255, 93, 93, 93))),
                SizedBox(height: 10.0),
                Row(
                  children: [
                    Expanded(
                      child: TextField(
                        style: AppWidget.umumTextFieldStyle().copyWith(
                            color: const Color.fromARGB(255, 93, 93, 93)),
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
                          fillColor: Color.fromARGB(255, 210, 210, 210),
                        ),
                      ),
                    ),
                    PopupMenuButton(
                      icon: Icon(Icons.filter_list, color: Colors.white),
                      itemBuilder: (BuildContext context) => <PopupMenuEntry>[
                        PopupMenuItem(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Filter Wisata',
                                  style: AppWidget.boldTextFieldStyle()),
                              SizedBox(height: 8),
                              ListTile(
                                leading: Icon(Icons.all_inclusive),
                                title: Text('Semua Wisata',
                                    style: AppWidget.umumTextFieldStyle()),
                                onTap: () {},
                              ),
                              ListTile(
                                leading: Icon(Icons.nature),
                                title: Text('Wisata Alam',
                                    style: AppWidget.umumTextFieldStyle()),
                                onTap: () {},
                              ),
                              ListTile(
                                leading: Icon(Icons.history),
                                title: Text('Wisata Sejarah',
                                    style: AppWidget.umumTextFieldStyle()),
                                onTap: () {},
                              ),
                              ListTile(
                                leading: Icon(Icons.school),
                                title: Text('Wisata Edukasi',
                                    style: AppWidget.umumTextFieldStyle()),
                                onTap: () {},
                              ),
                              ListTile(
                                leading: Icon(Icons.shopping_cart),
                                title: Text('Wisata Belanja',
                                    style: AppWidget.umumTextFieldStyle()),
                                onTap: () {},
                              ),
                              ListTile(
                                leading: Icon(Icons.restaurant),
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
              ],
            ),
          ),
          // Scrollable content
          Positioned.fill(
            top: 150.0,
            child: SingleChildScrollView(
              child: Container(
                margin: EdgeInsets.only(top: 20.0, left: 17.0, right: 10.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ...buildTouristAttractions(context),
                  ],
                ),
              ),
            ),
          ),
        ],
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
      // Add more attractions as needed
    ];

    List<Widget> attractionWidgets = [];
    for (var attraction in attractions) {
      attractionWidgets.add(
        Container(
          margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
          child: Column(
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
                        width: double.infinity,
                        fit: BoxFit.cover,
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
                              style: AppWidget.headTextFieldStyle()
                                  .copyWith(color: Colors.white),
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
        ),
      );
    }
    return attractionWidgets;
  }
}
