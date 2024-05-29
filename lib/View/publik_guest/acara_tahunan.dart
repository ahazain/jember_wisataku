import "package:flutter/material.dart";
import "package:jember_wisataku/View/publik_guest/detail_event/details.dart";
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
      backgroundColor: Color.fromARGB(255, 246, 246, 248),
      body: Stack(
        children: [
          // Container hijau berbentuk oval yang tetap
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
          Positioned(
            top: 500,
            left: 180,
            child: Container(
              width: 423,
              height: 408,
              decoration: ShapeDecoration(
                color: Color(0xFF67ED38),
                shape: OvalBorder(),
              ),
            ),
          ),
          // Bagian yang tetap di atas
          Positioned(
            top: 20.0,
            left: 17.0,
            right: 10.0,
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
                  ],
                ),
              ],
            ),
          ),
          // Konten yang bisa di-scroll
          Positioned.fill(
            top: 150.0, // Berikan top padding agar tidak tertutup
            child: SingleChildScrollView(
              child: Container(
                margin: EdgeInsets.only(top: 0.0, left: 17.0, right: 10.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 40.0), // Tambahkan jarak
                    buildEventCard(
                      context,
                      "assets/images/62ef257df3e8bcf7e477b0b5-zqZnew-scaled.jpeg",
                      "JVC",
                    ),
                    SizedBox(height: 20.0),
                    buildEventCard(
                      context,
                      "https://ryusei.co.id/cdn/shop/articles/jember-3jpg_uTCF1.jpg?v=1604717607",
                      "Pantai Papuma",
                    ),
                    SizedBox(height: 20.0),
                    buildEventCard(
                      context,
                      "https://ryusei.co.id/cdn/shop/articles/jember-3jpg_uTCF1.jpg?v=1604717607",
                      "JVC",
                    ),
                    SizedBox(height: 20.0),
                    buildEventCard(
                      context,
                      "https://4.bp.blogspot.com/-aIV3NUiKsrk/Ul7bhmliTLI/AAAAAAAADWk/udAysmRkqrU/s1600/gbr+papuma.jpg",
                      "Pantai Papuma",
                    ),
                    SizedBox(height: 20.0),
                    buildEventCard(
                      context,
                      "https://4.bp.blogspot.com/-aIV3NUiKsrk/Ul7bhmliTLI/AAAAAAAADWk/udAysmRkqrU/s1600/gbr+papuma.jpg",
                      "Pantai Papuma",
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildEventCard(BuildContext context, String imageUrl, String title) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => detail_event()),
        );
      },
      child: Container(
        margin: EdgeInsets.only(top: 0.0, left: 20.0, right: 20.0),
        child: Center(
          child: Stack(
            children: [
              if (imageUrl.startsWith('http'))
                Image.network(
                  imageUrl,
                  height: 218,
                  width: double.infinity,
                  fit: BoxFit.cover,
                )
              else
                Image.asset(
                  imageUrl,
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
                      title,
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
    );
  }
}
