import 'package:flutter/material.dart';
import 'package:jember_wisataku/pages/admin/wisataAdmin.dart';

class homeAdmin extends StatefulWidget {
  final String title;

  const homeAdmin({super.key, required this.title});

  @override
  State<homeAdmin> createState() => _homeAdminState();
}

class _homeAdminState extends State<homeAdmin> {
  // Data untuk setiap card
  final List<Map<String, String>> cardData = [
    {
      'image': 'assets/images/Sunset_papuma_beach.jpg',
      'title': 'Pantai Papuma',
    },
    {
      'image': 'assets/Sunset_papuma_beach.jpg',
      'title': 'Gunung Bromo',
    },
    {
      'image': 'assets/Sunset_papuma_beach.jpg',
      'title': 'Situs Duplang',
    },
    // Tambahkan lebih banyak data sesuai kebutuhan
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        centerTitle: true,
        backgroundColor: Colors.green,
      ),
      body: GridView.count(
        crossAxisCount: 2,
        children: List.generate(cardData.length, (index) {
          // Mengambil data untuk card saat ini
          final item = cardData[index];
          return Card(
            clipBehavior: Clip.antiAlias,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                // Gambar di bagian atas
                Expanded(
                  child: Image.asset(
                    item['image']!, // Menggunakan image dari data
                    fit: BoxFit.cover,
                  ),
                ),
                // Teks judul di bawah gambar
                Container(
                  color: Colors.black.withOpacity(0.5),
                  padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  child: Text(
                    item['title']!, // Menggunakan title dari data
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
                                builder: (context) => DetailWisata()));
                      },
                    ),
                    IconButton(
                      icon: Icon(Icons.delete),
                      color: Colors.red,
                      onPressed: () {
                        // Aksi yang ingin dijalankan saat tombol hapus ditekan
                      },
                    ),
                  ],
                ),
              ],
            ),
          );
        }),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Beranda',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_circle),
            label: 'Akun',
          ),
        ],
      ),
    );
  }
}
