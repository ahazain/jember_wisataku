import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;
import 'package:jember_wisataku/View/admin/kelola_wisata/read_wisata.dart';
import 'package:jember_wisataku/NavigasiBar/nav_admin.dart';
import 'package:jember_wisataku/View/publik_guest/homepage.dart';
import 'package:jember_wisataku/NavigasiBar/nav_guest.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Editwisata extends StatefulWidget {
  final Map<String, dynamic> wisata;

  const Editwisata({Key? key, required this.wisata}) : super(key: key);

  @override
  State<Editwisata> createState() => _EditwisataState();
}

class _EditwisataState extends State<Editwisata> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController _nameController = TextEditingController();
  TextEditingController _gambarController = TextEditingController();
  TextEditingController _deskripsiController = TextEditingController();
  TextEditingController _alamatController = TextEditingController();
  int? _jeniswisataController;
  TextEditingController _latitudeController = TextEditingController();
  TextEditingController _longitudeController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _nameController.text = widget.wisata['nama_wisata'];
    _jeniswisataController = widget.wisata['jenis_wisata_id'] is int
        ? widget.wisata['jenis_wisata_id']
        : int.tryParse(widget.wisata['jenis_wisata_id'].toString());
    _latitudeController.text = widget.wisata['latitude'].toString();
    _longitudeController.text = widget.wisata['longitude'].toString();
    _alamatController.text = widget.wisata['alamat'];
    _gambarController.text = widget.wisata['gambar'];
    _deskripsiController.text = widget.wisata['deskripsi'];
  }

  Future updateWisata() async {
    try {
      // Ambil SharedPreferences instance
      SharedPreferences prefs = await SharedPreferences.getInstance();

      // Ambil access_token dari SharedPreferences
      String? accessToken = prefs.getString('access_token');

      // Jika access_token tidak ditemukan, arahkan pengguna ke tampilan akun_publik
      if (accessToken == null || accessToken.isEmpty) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => NavAdmin()),
        );
        return;
      }

      final response = await http.put(
        Uri.parse(
            'https://jemberwisataapi-production.up.railway.app/api/wisata/' +
                widget.wisata['id'].toString()),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer $accessToken', // Sertakan Bearer Token
        },
        body: jsonEncode(<String, dynamic>{
          "nama_wisata": _nameController.text,
          "jenis_wisata_id": _jeniswisataController,
          "latitude": _latitudeController.text,
          "longitude": _longitudeController.text,
          "alamat": _alamatController.text,
          "gambar": _gambarController.text,
          "deskripsi": _deskripsiController.text,
        }),
      );

      if (response.statusCode == 200) {
        var jsonResponse = json.decode(response.body);
        print('Success: $jsonResponse');
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Wisata update successfully!')),
        );
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => NavAdmin()),
        );
      } else {
        throw Exception('Failed to update data WISATA');
      }
    } catch (e) {
      print('Error saving event: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to update wisata')),
      );
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _alamatController.dispose();
    // _jeniswisataController.dispose();
    _latitudeController.dispose();
    _longitudeController.dispose();
    _gambarController.dispose();
    _deskripsiController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Wisata'),
        automaticallyImplyLeading: false,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              children: [
                TextFormField(
                  controller: _nameController,
                  decoration: InputDecoration(
                    labelText: "Nama Wisata",
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Data tidak boleh kosong";
                    }
                    return null;
                  },
                ),
                SizedBox(height: 16),
                DropdownButtonFormField<int>(
                  decoration: InputDecoration(
                    labelText: "Jenis Wisata",
                    border: OutlineInputBorder(),
                  ),
                  value: _jeniswisataController,
                  items: [
                    DropdownMenuItem(value: 1, child: Text("Wisata Alam")),
                    DropdownMenuItem(value: 2, child: Text("Wisata Edukasi")),
                    DropdownMenuItem(value: 3, child: Text("Wisata Belanja")),
                    DropdownMenuItem(value: 4, child: Text("Wisata Sejarah")),
                    DropdownMenuItem(value: 5, child: Text("Wisata Kuliner")),
                  ],
                  onChanged: (value) {
                    setState(() {
                      _jeniswisataController = value!;
                    });
                  },
                  validator: (value) {
                    if (value == null) {
                      return "Data tidak boleh kosong";
                    }
                    return null;
                  },
                ),
                SizedBox(height: 16),
                TextFormField(
                  controller: _gambarController,
                  decoration: InputDecoration(
                    labelText: "Gambar",
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Data tidak boleh kosong";
                    }
                    return null;
                  },
                ),
                SizedBox(height: 16),
                TextFormField(
                  controller: _deskripsiController,
                  decoration: InputDecoration(
                    labelText: "Deskripsi",
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Data tidak boleh kosong";
                    }
                    return null;
                  },
                ),
                SizedBox(height: 16),
                TextFormField(
                  controller: _alamatController,
                  decoration: InputDecoration(
                    labelText: "Alamat",
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Data tidak boleh kosong";
                    }
                    return null;
                  },
                ),
                SizedBox(height: 16),
                TextFormField(
                  controller: _latitudeController,
                  decoration: InputDecoration(
                    labelText: "Latitude",
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Data tidak boleh kosong";
                    }
                    return null;
                  },
                ),
                SizedBox(height: 16),
                TextFormField(
                  controller: _longitudeController,
                  decoration: InputDecoration(
                    labelText: "Longitude",
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Data tidak boleh kosong";
                    }
                    return null;
                  },
                ),
                SizedBox(height: 25),
                ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      updateWisata().then((value) {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => NavAdmin(),
                          ),
                        );
                      });
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    minimumSize:
                        Size(double.infinity, 48), // Lebar maksimum tombol
                  ),
                  child: Text('Update'),
                ),
                SizedBox(height: 16),
                ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  style: ElevatedButton.styleFrom(
                    minimumSize:
                        Size(double.infinity, 48), // Lebar maksimum tombol
                  ),
                  child: Text('Back'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
