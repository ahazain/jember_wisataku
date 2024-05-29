import 'package:flutter/material.dart';

import 'package:jember_wisataku/View/admin/input_wisata.dart';
import 'package:jember_wisataku/View/publik_guest/button_guest.dart';

import 'package:jember_wisataku/widget/widget_support.dart';

class home_admin extends StatefulWidget {
  final String title;

  const home_admin({super.key, required this.title});

  @override
  State<home_admin> createState() => _home_adminState();
}

class _home_adminState extends State<home_admin> {
  int _currentIndex = 0; // Track the current selected index

  final List<Widget> _pages = [
    HomePageContent(), // Define a separate widget for the home page content
    akun_admin(),
  ];

  final List<String> _titles = ["Jember Wisata", "Profil"]; // Titles for AppBar

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          _titles[_currentIndex], // Dynamically change title
          style: AppWidget.head3TextFieldStyle().copyWith(color: Colors.black),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
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
                    // Add your onPressed code here!
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

// Define a separate widget for the home page content
class HomePageContent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final List<Map<String, String>> cardData = [
      {
        'image': 'assets/images/Sunset_papuma_beach.jpg',
        'title': 'Pantai Papuma',
      },
      {
        'image': 'assets/images/gudeg.jpg',
        'title': 'Gudeg Lumintu',
      },
      {
        'image': 'assets/images/situs_duplang.jpg',
        'title': 'Situs Duplang',
      },
      {
        'image': 'assets/images/gunung_gambir.jpg',
        'title': 'Gunung Gambir',
      },
      {
        'image': 'assets/images/watu_ulo.jpg',
        'title': 'Watu Ulo',
      },
      {
        'image': 'assets/images/kampung_durian.jpg',
        'title': 'Kampung Durian',
      },
      {
        'image': 'assets/images/museum_tembakau.jpg',
        'title': 'Museum Tembakau',
      },
      {
        'image': 'assets/images/bebek_galak.jpg',
        'title': 'Bebek Galak 88',
      },
    ];

    return GridView.count(
      crossAxisCount: 2,
      padding: EdgeInsets.all(10.0), // Padding around the grid
      crossAxisSpacing: 10.0, // Spacing between columns
      mainAxisSpacing: 10.0, // Spacing between rows
      children: List.generate(cardData.length, (index) {
        final item = cardData[index];
        return Card(
          margin: EdgeInsets.all(5.0), // Margin around each card
          clipBehavior: Clip.antiAlias,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Expanded(
                child: Image.asset(
                  item['image']!,
                  fit: BoxFit.cover,
                ),
              ),
              Container(
                color: Colors.grey,
                padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                child: Text(
                  item['title']!,
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
                        MaterialPageRoute(builder: (context) => input_wisata()),
                      );
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
    );
  }
}

class akun_admin extends StatefulWidget {
  const akun_admin({Key? key}) : super(key: key);

  @override
  State<akun_admin> createState() => _akun_adminState();
}

class _akun_adminState extends State<akun_admin> {
  bool _isEditing = false;
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _nameController.text = 'Surahki'; // Ganti dengan nama pengguna sebenarnya
    _emailController.text =
        'surahki@example.com'; // Ganti dengan email pengguna sebenarnya
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    super.dispose();
  }

  void _toggleEdit() {
    setState(() {
      _isEditing = !_isEditing;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                Stack(
                  children: [
                    CircleAvatar(
                      radius: 50,
                      backgroundImage: NetworkImage(
                          'https://media.istockphoto.com/id/1131348804/id/vektor/ikon-pengisian-linier-wanita-bisnis-vector-gadis-bisnis-avatar-gambar-profil-gambar-garis.jpg?s=170667a&w=0&k=20&c=ixi0KyyovtLthGlo4MCephen0iZZLnF0pj8twL7qEmE='),
                    ),
                  ],
                ),
                SizedBox(height: 20),
                _buildTextField(
                  controller: _nameController,
                  icon: Icons.person,
                  isEditing: _isEditing,
                ),
                SizedBox(height: 10),
                _buildTextField(
                  controller: _emailController,
                  icon: Icons.email,
                  isEditing: _isEditing,
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: _toggleEdit,
                  style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all<Color>(Color(0xFF00AF2C)),
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15.0),
                      ),
                    ),
                    minimumSize:
                        MaterialStateProperty.all(Size(double.infinity, 50)),
                  ),
                  child: Text(
                    _isEditing ? 'Simpan' : 'Edit',
                    style: AppWidget.labelbutton(),
                  ),
                ),
                SizedBox(height: 10),
                ElevatedButton(
                  onPressed: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => button_guest(),
                      ),
                    );
                  },
                  style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all<Color>(Color(0xFFB4211C)),
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15.0),
                      ),
                    ),
                    minimumSize:
                        MaterialStateProperty.all(Size(double.infinity, 50)),
                  ),
                  child: Text("Keluar", style: AppWidget.labelbutton()),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required IconData icon,
    required bool isEditing,
  }) {
    return TextFormField(
      controller: controller,
      enabled: isEditing,
      decoration: InputDecoration(
        prefixIcon: Icon(icon, color: Colors.black),
        filled: true,
        fillColor: Colors.grey[200],
        contentPadding: EdgeInsets.all(15),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }
}
