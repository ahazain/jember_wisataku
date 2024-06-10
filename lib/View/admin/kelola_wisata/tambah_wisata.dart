import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:jember_wisataku/View/admin/kelola_wisata/read_wisata.dart';
import 'package:jember_wisataku/View/admin/nav_admin.dart';
import 'package:jember_wisataku/View/publik_guest/homepage.dart';
import 'package:jember_wisataku/View/publik_guest/nav_guest.dart';
import 'package:shared_preferences/shared_preferences.dart';

class tambah_wisata extends StatefulWidget {
  const tambah_wisata({super.key});

  @override
  State<tambah_wisata> createState() => _tambah_wisataState();
}

class _tambah_wisataState extends State<tambah_wisata> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController _nameController = TextEditingController();
  TextEditingController _gambarController = TextEditingController();
  TextEditingController _deskripsiController = TextEditingController();
  TextEditingController _alamatController = TextEditingController();
  TextEditingController _latitudeController = TextEditingController();
  TextEditingController _longitudeController = TextEditingController();
  int? _selectedJenisWisata;

  Future saveWisata() async {
    try {
      // Ambil SharedPreferences instance
      SharedPreferences prefs = await SharedPreferences.getInstance();

      // Ambil access_token dari SharedPreferences
      String? accessToken = prefs.getString('access_token');

      // Jika access_token tidak ditemukan, arahkan pengguna ke tampilan akun_publik
      if (accessToken == null || accessToken.isEmpty) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => nav_guest()),
        );
        return;
      }

      // Lanjutkan dengan pengiriman request HTTP dengan Bearer Token
      final response = await http.post(
        Uri.parse(
            'https://jemberwisataapi-production.up.railway.app/api/wisata'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer $accessToken', // Sertakan Bearer Token
        },
        body: jsonEncode(<String, dynamic>{
          "jenis_wisata_id": _selectedJenisWisata,
          "nama_wisata": _nameController.text,
          "gambar": _gambarController.text,
          "deskripsi": _deskripsiController.text,
          "alamat": _alamatController.text,
          "latitude": _latitudeController.text,
          "longitude": _longitudeController.text,
        }),
      );

      if (response.statusCode == 200) {
        // Jika berhasil, kembalikan data JSON yang diterima
        return json.decode(response.body);
      } else {
        // Jika gagal, lemparkan Exception
        throw Exception('Failed to save data wisata');
      }
    } catch (e) {
      print('Error saving wisata: $e');
      return null;
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _gambarController.dispose();
    _deskripsiController.dispose();
    _alamatController.dispose();
    _latitudeController.dispose();
    _longitudeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Tambah Wisata'),
        automaticallyImplyLeading: false,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
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
                value: _selectedJenisWisata,
                items: [
                  DropdownMenuItem(value: 1, child: Text("Wisata Alam")),
                  DropdownMenuItem(value: 2, child: Text("Wisata Edukasi")),
                  DropdownMenuItem(value: 3, child: Text("Wisata Belanja")),
                  DropdownMenuItem(value: 4, child: Text("Wisata Sejarah")),
                  DropdownMenuItem(value: 5, child: Text("Wisata Kuliner")),
                ],
                onChanged: (value) {
                  setState(() {
                    _selectedJenisWisata = value!;
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
                    saveWisata().then((value) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => NavAdmin(),
                        ),
                      );
                    });
                  }
                },
                child: Text('Save'),
              ),
              SizedBox(height: 16),
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text('Back'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
