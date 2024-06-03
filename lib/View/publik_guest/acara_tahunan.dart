import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:jember_wisataku/View/publik_guest/detail_event.dart';
import 'package:jember_wisataku/widget/widget_support.dart';

class acaratahunan extends StatefulWidget {
  @override
  _acaratahunanState createState() => _acaratahunanState();
}

class _acaratahunanState extends State<acaratahunan> {
  List _listdata = [];
  List _fullListData = [];
  TextEditingController _searchController = TextEditingController();

  Future _getdata() async {
    try {
      final response =
          await http.get(Uri.parse('http://192.168.1.51/api?jenis=event'));
      if (response.statusCode == 200) {
        print(response.body);
        final data = jsonDecode(response.body);
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
    _searchController.addListener(_search);
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
                        controller: _searchController,
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

          // Scrollable content
          Positioned.fill(
            top: 150.0,
            child: SingleChildScrollView(
              child: Container(
                margin: EdgeInsets.only(top: 20.0, left: 17.0, right: 10.0),
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
                  MaterialPageRoute(builder: (context) => detail_event()),
                );
              },
              child: Center(
                child: Column(
                  children: _buildImageStacks(attraction),
                ),
              ),
            ),
            SizedBox(height: 20.0),
          ],
        ),
      );
    }).toList();
  }

  List<Widget> _buildImageStacks(Map<String, dynamic> attraction) {
    List<Widget> imageStacks = [];
    List<String> imageUrls = attraction["gambar"]
        .split(','); // Assuming multiple URLs are separated by commas
    List<String> names = attraction["nama_event"]
        .split(','); // Assuming multiple names are separated by commas

    for (int i = 0; i < imageUrls.length; i++) {
      imageStacks.add(
        Stack(
          children: [
            Image.network(
              imageUrls[i],
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
                    names[i],
                    style: AppWidget.headTextFieldStyle()
                        .copyWith(color: Colors.white),
                  ),
                ),
              ),
            ),
          ],
        ),
      );
      imageStacks.add(SizedBox(height: 10.0)); // Adding space between images
    }

    return imageStacks;
  }

  void _search() {
    String query = _searchController.text.toLowerCase();
    if (query.isEmpty) {
      setState(() {
        _listdata = List.from(
            _fullListData); // Kembalikan ke daftar lengkap jika query kosong
      });
      return;
    }
    List filteredList = _fullListData.where((attraction) {
      String attractionName = attraction['nama_event'].toString().toLowerCase();
      return attractionName.contains(query);
    }).toList();

    setState(() {
      _listdata = filteredList;
    });
  }
}
