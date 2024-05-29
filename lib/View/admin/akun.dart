import 'package:flutter/material.dart';
import 'package:jember_wisataku/View/login.dart';
import 'package:jember_wisataku/widget/widget_support.dart';

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
      backgroundColor: Color.fromARGB(255, 28, 28, 45),
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
                        builder: (context) => login(),
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
        prefixIcon: Icon(icon, color: Color.fromARGB(255, 28, 28, 45)),
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