import "package:flutter/material.dart";
import "package:jember_wisataku/widget/widget_support.dart";

class details extends StatefulWidget {
  const details({super.key});

  @override
  State<details> createState() => _detailsState();
}

class _detailsState extends State<details> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.only(top: 40.0, left: 20.0, right: 20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Icon(Icons.arrow_back_ios_new_outlined,
                    color: Colors.black),
              ),
              SizedBox(height: 20.0),
              Center(
                child: Image.network(
                  "https://4.bp.blogspot.com/-aIV3NUiKsrk/Ul7bhmliTLI/AAAAAAAADWk/udAysmRkqrU/s1600/gbr+papuma.jpg",
                  height: 200,
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 10.0, left: 18.0, right: 20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text(
                      "Pantai Papuma",
                      style: AppWidget.bold2TextFieldStyle(),
                    ),
                    SizedBox(height: 10),
                    Text(
                      "Pantai Papuma di Jember adalah keindahan alam dan pesona pantai yang menakjubkan. Terletak di ujung selatan Jawa Timur, pantai ini menawarkan pemandangan yang menakjubkan dengan garis pantai yang panjang, pasir putih yang lembut, dan ombak yang memukau. Suasana Pantai Papuma begitu menenangkan dan menyejukkan. Saat matahari terbenam, panorama Pantai Papuma menjadi semakin memikat dengan warna-warna senja yang memukau.",
                      style: AppWidget.leghtTextFieldStyle(),
                      textAlign: TextAlign.justify,
                    ),
                    SizedBox(
                      height: 20.0,
                    ),
                    Text(
                      "Informasi Tiket Masuk dan Biaya Parkir:",
                      style: AppWidget.boldTextFieldStyle(),
                    ),
                    SizedBox(height: 10),
                    RichText(
                      text: TextSpan(
                        style: AppWidget.leghtTextFieldStyle(),
                        children: [
                          TextSpan(
                            text:
                                "• Tiket masuk Pantai Papuma di weekdays sebesar Rp. 18.000,- per orang.\n",
                          ),
                          TextSpan(
                            text:
                                "• Tiket masuk Pantai Papuma di weekend sebesar Rp. 25.000,- per orang.\n",
                          ),
                          TextSpan(
                            text:
                                "• Biaya parkir mobil sebesar Rp. 10.000,- per unit.\n",
                          ),
                          TextSpan(
                            text:
                                "• Biaya parkir motor sebesar Rp. 5.000,- per unit.\n",
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  IconButton(
                    onPressed: () {
                      // Handle WhatsApp action here
                    },
                    icon: Icon(Icons.message,
                        color: Colors.green), // Assuming WhatsApp icon is green
                  ),
                  IconButton(
                    onPressed: () {
                      // Handle Maps action here
                    },
                    icon: Icon(Icons.location_on,
                        color: Colors.red), // Assuming Maps icon is red
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
