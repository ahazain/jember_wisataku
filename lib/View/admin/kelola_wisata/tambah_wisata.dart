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
  TextEditingController _jeniswisataController = TextEditingController();
  TextEditingController _gambarController = TextEditingController();
  TextEditingController _deskripsiController = TextEditingController();
  TextEditingController _alamatController = TextEditingController();
  TextEditingController _latitudeController = TextEditingController();
  TextEditingController _longitudeController = TextEditingController();

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
          "jenis_wisata_id": _jeniswisataController.text,
          "nama_wisata": _nameController.text,
          "gambar": _gambarController.text,
          "deskripsi": _deskripsiController.text,
          "alamat": _alamatController.text,
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
    _jeniswisataController.dispose();
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
      ),
      body: Form(
        key: _formKey,
        child: Column(
          children: [
            TextFormField(
              controller: _nameController,
              decoration: InputDecoration(labelText: "Nama Wisata"),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return "Data tidak boleh kosong";
                }
                return null;
              },
            ),
            TextFormField(
              controller: _jeniswisataController,
              decoration: InputDecoration(labelText: "Jenis Wisata"),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return "Data tidak boleh kosong";
                }
                return null;
              },
            ),
            TextFormField(
              controller: _gambarController,
              decoration: InputDecoration(labelText: "Gambar"),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return "Data tidak boleh kosong";
                }
                return null;
              },
            ),
            TextFormField(
              controller: _deskripsiController,
              decoration: InputDecoration(labelText: "Deskripsi"),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return "Data tidak boleh kosong";
                }
                return null;
              },
            ),
            TextFormField(
              controller: _alamatController,
              decoration: InputDecoration(labelText: "Alamat"),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return "Data tidak boleh kosong";
                }
                return null;
              },
            ),
            TextFormField(
              controller: _latitudeController,
              decoration: InputDecoration(labelText: "Latitude"),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return "Data tidak boleh kosong";
                }
                return null;
              },
            ),
            TextFormField(
              controller: _longitudeController,
              decoration: InputDecoration(labelText: "Longitude"),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return "Data tidak boleh kosong";
                }
                return null;
              },
            ),
            SizedBox(
              height: 25,
            ),
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
            )
          ],
        ),
      ),
    );
  }
}
