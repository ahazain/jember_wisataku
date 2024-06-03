import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:jember_wisataku/View/admin/akun_admin.dart';
import 'package:jember_wisataku/View/admin/tambah_wisata.dart';
import 'package:jember_wisataku/View/admin/update.wisata.dart' as update;
import 'package:jember_wisataku/View/publik_guest/nav_guest.dart';
import 'package:jember_wisataku/widget/widget_support.dart';
import 'package:jember_wisataku/View/admin/delete_wisata.dart' as delete;

class HomeAdmin extends StatefulWidget {
  final String title;

  const HomeAdmin({Key? key, required this.title});

  @override
  State<HomeAdmin> createState() => _HomeAdminState();
}

class _HomeAdminState extends State<HomeAdmin> {
  int _currentIndex = 0;

  final List<Widget> _pages = [
    HomePageContent(),
    AkunAdmin(),
  ];

  final List<String> _titles = ["Jember Wisata", "Profil"];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          _titles[_currentIndex],
          style: AppWidget.head3TextFieldStyle().copyWith(color: Colors.black),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
      ),
      body: Stack(
        children: [
          _pages[_currentIndex],
          if (_currentIndex == 0)
            Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: const EdgeInsets.only(bottom: 16.0),
                child: FloatingActionButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => tambah_wisata(),
                      ),
                    );
                  },
                  child: Icon(Icons.add),
                  backgroundColor: Color.fromARGB(255, 0, 220, 33),
                ),
              ),
            ),
        ],
      ),
    );
  }
}

class HomePageContent extends StatefulWidget {
  @override
  _HomePageContentState createState() => _HomePageContentState();
}

class _HomePageContentState extends State<HomePageContent> {
  late Future<List<Map<String, dynamic>>> _fetchDataFuture;

  @override
  void initState() {
    super.initState();
    _fetchDataFuture = fetchData();
  }

  Future<List<Map<String, dynamic>>> fetchData() async {
    final response =
        await http.get(Uri.parse('http://127.0.0.1:8000/api/wisata'));
    if (response.statusCode == 200) {
      final Map<String, dynamic> responseData = json.decode(response.body);
      final List<dynamic>? data = responseData['data'];
      if (data != null) {
        return data
            .map((item) => {
                  'id': item['id'].toString(),
                  'gambar': item['gambar'],
                  'nama_wisata': item['nama_wisata'],
                  'jenis_wisata_id': item['jenis_wisata_id'],
                  'deskripsi': item['deskripsi'],
                  'alamat': item['alamat'],
                })
            .toList();
      }
    }
    print('Failed to load data');
    throw Exception('Failed to load data');
  }

  Future<void> _deleteWisata(String id) async {
    final response = await http.delete(
      Uri.parse('http://127.0.0.1:8000/api/wisata/$id'),
    );

    if (response.statusCode == 200) {
      setState(() {
        _fetchDataFuture = fetchData();
      });
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to delete wisata')),
      );
    }
  }

  Future<void> _showDeleteConfirmationDialog(String id) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Konfirmasi Hapus'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text('Apakah Anda yakin ingin menghapus item ini?'),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text('Tidak'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text('Ya'),
              onPressed: () {
                _deleteWisata(id);
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Map<String, dynamic>>>(
      future: _fetchDataFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else {
          return GridView.count(
            crossAxisCount: 2,
            padding: EdgeInsets.all(10.0),
            crossAxisSpacing: 10.0,
            mainAxisSpacing: 10.0,
            children: List.generate(snapshot.data!.length, (index) {
              final item = snapshot.data![index];
              return Card(
                margin: EdgeInsets.all(5.0),
                clipBehavior: Clip.antiAlias,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    Expanded(
                      child: Image.network(
                        item['gambar'],
                        fit: BoxFit.cover,
                      ),
                    ),
                    Container(
                      color: Colors.grey,
                      padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                      child: Text(
                        item['nama_wisata'],
                        style: TextStyle(color: Colors.white, fontSize: 16),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    ButtonBar(
                      alignment: MainAxisAlignment.center,
                      children: [
                        IconButton(
                          icon: Icon(Icons.edit),
                          color: Colors.blue,
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => update.UpdateWisata(
                                    wisata: {...item, 'id': item['id']}),
                              ),
                            ).then((updatedWisata) {
                              if (updatedWisata != null) {
                                setState(() {
                                  snapshot.data![index] = updatedWisata;
                                });
                              }
                            });
                          },
                        ),
                        IconButton(
                          icon: Icon(Icons.delete),
                          color: Colors.red,
                          onPressed: () {
                            _showDeleteConfirmationDialog(item['id']);
                          },
                        ),
                      ],
                    ),
                  ],
                ),
              );
            }),
          );
        }
      },
    );
  }
}
