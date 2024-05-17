import "package:flutter/material.dart";
import "package:jember_wisataku/pages/public/detail_event/details.dart";
import "package:jember_wisataku/widget/widget_support.dart";

class acaratahunan extends StatefulWidget {
  const acaratahunan({Key? key}) : super(key: key);

  @override
  State<acaratahunan> createState() => _acaratahunanState();
}

class _acaratahunanState extends State<acaratahunan> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
      child: Container(
        margin: EdgeInsets.only(top: 20.0, left: 17.0, right: 10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Event", style: AppWidget.boldTextFieldStyle()),
            SizedBox(
              height: 10.0,
            ),
            Text("Kota Jember", style: AppWidget.headTextFieldStyle()),
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
              ],
            ),
            SizedBox(height: 20.0),
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => detail_event()),
                );
              },
              child: Center(
                child: Stack(
                  children: [
                    Image.asset(
                      "assets/images/62ef257df3e8bcf7e477b0b5-zqZnew-scaled.jpeg",
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
                          child: Text("JVC",
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
                      "https://ryusei.co.id/cdn/shop/articles/jember-3jpg_uTCF1.jpg?v=1604717607",
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
                      "https://ryusei.co.id/cdn/shop/articles/jember-3jpg_uTCF1.jpg?v=1604717607",
                      height: 216,
                    ),
                    Positioned(
                      top: 150,
                      left: 0,
                      right: 0,
                      child: Container(
                        color: Color.fromARGB(82, 159, 159, 159),
                        padding: EdgeInsets.symmetric(vertical: 20.0),
                        child: Center(
                          child: Text("JVC",
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
