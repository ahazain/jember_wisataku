import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:jember_wisataku/Aktor/Admin/ProfilAdmin.dart';
import 'package:jember_wisataku/Aktor/Admin/KelolaEvent/DeleteEvent.dart';
import 'package:jember_wisataku/Aktor/Admin/KelolaEvent/UpdateEvent.dart';
import 'package:jember_wisataku/Aktor/Admin/KelolaEvent/CreateEvent.dart';
import 'package:jember_wisataku/Aktor/Admin/KelolaWisata/DeleteWisata.dart';
import 'package:jember_wisataku/Aktor/Admin/KelolaWisata/UpdateWisata.dart';
import 'package:jember_wisataku/NavigasiBar/NavAdmin.dart';
import 'package:jember_wisataku/Aktor/Admin/KelolaWisata/CreateWisata.dart';

class ReadEvent extends StatefulWidget {
  final String title;

  const ReadEvent({Key? key, required this.title});

  @override
  State<ReadEvent> createState() => _ReadEventState();
}

class _ReadEventState extends State<ReadEvent> {
  int _currentIndex = 0; // Track the current selected index

  final List<Widget> _pages = [
    ReadEventPageContent(), // Tambahkan const di sini
    ProfilAdmin(), // Tambahkan const di sini
  ];

  final List<String> _titles = ["Jember Wisata", "Profil"]; // Titles for AppBar

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          _titles[_currentIndex], // Dynamically change title
          style: TextStyle(
              color: Colors.black, fontSize: 24, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        automaticallyImplyLeading: false,
      ),
      body: Stack(
        children: [
          _pages[_currentIndex], // Display the currently selected page
          if (_currentIndex == 0)
            Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: const EdgeInsets.only(bottom: 16.0),
                child: FloatingActionButton(
                  onPressed: () {
                    // Navigasi ke halaman tambah_wisata
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => CreateEvent(),
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

class ReadEventPageContent extends StatefulWidget {
  @override
  _ReadEventPageContentState createState() => _ReadEventPageContentState();
}

class _ReadEventPageContentState extends State<ReadEventPageContent> {
  late Future<List<Map<String, dynamic>>> _fetchDataFuture;

  @override
  void initState() {
    super.initState();
    _fetchDataFuture = _getEvent();
  }

  Future<List<Map<String, dynamic>>> _getEvent() async {
    try {
      final response = await http.get(Uri.parse(
          'https://jemberwisataapi-production.up.railway.app/api/event'));
      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData = json.decode(response.body);
        final List<dynamic>? data = responseData['data'];
        if (data != null) {
          return data
              .map((item) => {
                    'id': item['id'].toString(),
                    'gambar': item['gambar'] ??
                        '', // tambahkan pengecekan null disini
                    'nama_acara': item['nama_acara'] ??
                        '', // tambahkan pengecekan null disini
                    'deskripsi': item['deskripsi'] ?? '',
                  })
              .toList();
        }
      }
      throw Exception('Failed to load data');
    } catch (e) {
      print(e);
      throw e;
    }
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
        } else if (snapshot.hasData) {
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
                        item['nama_acara'],
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
                                builder: (context) => UpdateEvent(
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
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  title: Text('Konfirmasi'),
                                  content: Text(
                                      'Apakah Anda yakin ingin menghapus wisata ini?'),
                                  actions: <Widget>[
                                    TextButton(
                                      onPressed: () {
                                        Navigator.of(context).pop(false);
                                      },
                                      child: Text('Batal'),
                                    ),
                                    TextButton(
                                      onPressed: () {
                                        Navigator.of(context).pop(true);
                                      },
                                      child: Text('Hapus'),
                                    ),
                                  ],
                                );
                              },
                            ).then((confirmed) {
                              if (confirmed != null && confirmed) {
                                showDialog(
                                  context: context,
                                  barrierDismissible:
                                      false, // Tidak dapat menutup dialog selama penghapusan berlangsung
                                  builder: (BuildContext context) {
                                    return AlertDialog(
                                      title: Text('Menghapus'),
                                      content: Row(
                                        children: [
                                          CircularProgressIndicator(), // Tampilkan indikator loading
                                          SizedBox(width: 20),
                                          Text("Menghapus..."),
                                        ],
                                      ),
                                    );
                                  },
                                );
                                // Panggil metode deleteWisata
                                DeleteEvent.deleteWisataEvent(
                                        item['id'].toString())
                                    .then((success) {
                                  Navigator.of(context)
                                      .pop(); // Tutup dialog loading

                                  if (success) {
                                    // Hapus item dari daftar data
                                    setState(() {
                                      snapshot.data!.removeAt(index);
                                    });

                                    // Tampilkan dialog sukses
                                    showDialog(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return AlertDialog(
                                          title: Text('Sukses'),
                                          content:
                                              Text('Event berhasil dihapus'),
                                          actions: <Widget>[
                                            TextButton(
                                              onPressed: () {
                                                Navigator.of(context).pop();
                                              },
                                              child: Text('OK'),
                                            ),
                                          ],
                                        );
                                      },
                                    );
                                  } else {
                                    showDialog(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return AlertDialog(
                                          title: Text('Error'),
                                          content:
                                              Text('Gagal menghapus Event'),
                                          actions: <Widget>[
                                            TextButton(
                                              onPressed: () {
                                                Navigator.of(context).pop();
                                              },
                                              child: Text('OK'),
                                            ),
                                          ],
                                        );
                                      },
                                    );
                                  }
                                });
                              }
                            });
                          },
                        ),
                      ],
                    ),
                  ],
                ),
              );
            }),
          );
        } else {
          return Center(child: Text('No data available'));
        }
      },
    );
  }
}
