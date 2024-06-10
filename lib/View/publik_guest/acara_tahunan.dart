import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:jember_wisataku/View/publik_guest/detail_AcaraTahunan.dart';
import 'package:jember_wisataku/View/publik_guest/detail_wisata.dart';
import 'package:jember_wisataku/widget/widget_support.dart';

class AcaraTahunan extends StatefulWidget {
  @override
  _AcaraTahunanState createState() => _AcaraTahunanState();
}

class _AcaraTahunanState extends State<AcaraTahunan> {
  List _listdata = [];
  List _fullListData = [];
  TextEditingController _searchController = TextEditingController();

  Future _getdata() async {
    try {
      final response = await http.get(Uri.parse(
          'https://jemberwisataapi-production.up.railway.app/api/event'));
      if (response.statusCode == 200) {
        print('Response body: ${response.body}');
        final data = jsonDecode(response.body)['data'];
        setState(() {
          _listdata = data;
          _fullListData = List.from(data); // Simpan daftar lengkap
        });
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  void initState() {
    _getdata();
    super.initState();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 246, 246, 248),
      body: Stack(
        children: [
          // Latar belakang oval hijau
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

          // Bagian atas
          Positioned(
            top: 34.0,
            left: 17.0,
            right: 25.0,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Hi, Wisatawan",
                    style: AppWidget.boldTextFieldStyle().copyWith(
                        color: const Color.fromARGB(255, 93, 93, 93))),
                SizedBox(height: 4.0),
                Text("Jember Indah",
                    style: AppWidget.headTextFieldStyle().copyWith(
                        color: const Color.fromARGB(255, 93, 93, 93))),
                SizedBox(height: 10.0),
                Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: _searchController,
                        onChanged: _search,
                        style: AppWidget.umumTextFieldStyle().copyWith(
                            color: const Color.fromARGB(255, 93, 93, 93)),
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(17.0),
                            borderSide: BorderSide.none,
                          ),
                          hintText: "eg. jember fashion carnaval",
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

          // Konten yang dapat digulir
          Positioned.fill(
            top: 180.0,
            child: SingleChildScrollView(
              child: Container(
                margin: EdgeInsets.only(top: 20.0, left: 10.0, right: 10.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: _buildTouristAttractions(context),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  List<Widget> _buildTouristAttractions(BuildContext context) {
    return _listdata.map((attraction) {
      return Container(
        margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
        child: Column(
          children: [
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => Detail_Acara(attraction: attraction),
                  ),
                );
              },
              child: Center(
                child: Column(
                  children: _buildImageStacks(attraction),
                ),
              ),
            ),
            SizedBox(height: 00.0),
          ],
        ),
      );
    }).toList();
  }

  List<Widget> _buildImageStacks(Map<String, dynamic> attraction) {
    List<Widget> imageStacks = [];
    String imageUrl = attraction["gambar"];
    String name = attraction["nama_acara"];

    imageStacks.add(
      Stack(
        children: [
          Image.network(
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
              padding: EdgeInsets.symmetric(vertical: 26.0),
              child: Center(
                child: Text(
                  name,
                  style: AppWidget.boldTextFieldStyle()
                      .copyWith(color: Colors.white),
                ),
              ),
            ),
          ),
        ],
      ),
    );

    return imageStacks;
  }

  void _search(String query) {
    if (query.isEmpty) {
      setState(() {
        _listdata = List.from(
            _fullListData); // Kembalikan ke daftar lengkap jika query kosong
      });
      return;
    }
    List filteredList = _fullListData.where((attraction) {
      String attractionName = attraction['nama_acara'].toString().toLowerCase();
      return attractionName.contains(query.toLowerCase());
    }).toList();

    setState(() {
      _listdata = filteredList;
    });
  }
}
