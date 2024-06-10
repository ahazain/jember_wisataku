import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;
import 'package:jember_wisataku/View/admin/kelola_wisata/read_wisata.dart';
import 'package:jember_wisataku/View/admin/nav_admin.dart';
import 'package:jember_wisataku/View/publik_guest/homepage.dart';
import 'package:jember_wisataku/View/publik_guest/nav_guest.dart';
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
  TextEditingController _jeniswisataController = TextEditingController();
  TextEditingController _gambarController = TextEditingController();
  TextEditingController _deskripsiController = TextEditingController();
  TextEditingController _alamatController = TextEditingController();

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
          MaterialPageRoute(builder: (context) => nav_guest()),
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
          "jenis_wisata_id": _jeniswisataController.text,
          "nama_wisata": _nameController.text,
          "gambar": _gambarController.text,
          "deskripsi": _deskripsiController.text,
          "alamat": _alamatController.text,
        }),
      );

      if (response.statusCode == 200) {
        return json.decode(response.body);
      } else {
        throw Exception('Failed to update data wisata');
      }
    } catch (e) {
      print('Error updating wisata: $e');
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
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Wisata'),
      ),
      body: Form(
        key: _formKey,
        child: Column(
          children: [
            TextFormField(
              controller: _nameController..text = widget.wisata['nama_wisata'],
              decoration: InputDecoration(labelText: "Nama Wisata"),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return "Data tidak boleh kosong";
                }
                return null;
              },
            ),
            TextFormField(
              controller: _jeniswisataController
                ..text = widget.wisata['jenis_wisata_id'].toString(),
              decoration: InputDecoration(labelText: "Jenis Wisata"),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return "Data tidak boleh kosong";
                }
                return null;
              },
            ),
            TextFormField(
              controller: _gambarController..text = widget.wisata['gambar'],
              decoration: InputDecoration(labelText: "Gambar"),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return "Data tidak boleh kosong";
                }
                return null;
              },
            ),
            TextFormField(
              controller: _deskripsiController
                ..text = widget.wisata['deskripsi'],
              decoration: InputDecoration(labelText: "Deskripsi"),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return "Data tidak boleh kosong";
                }
                return null;
              },
            ),
            TextFormField(
              controller: _alamatController..text = widget.wisata['alamat'],
              decoration: InputDecoration(labelText: "Alamat"),
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
                  updateWisata().then((value) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => NavAdmin()),
                    );
                  });
                }
              },
              child: Text('Update'),
            )
          ],
        ),
      ),
    );
  }
}
