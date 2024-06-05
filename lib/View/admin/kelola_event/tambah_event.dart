import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:jember_wisataku/View/admin/kelola_wisata/read_wisata.dart';
import 'package:jember_wisataku/View/admin/nav_admin.dart';
import 'package:jember_wisataku/View/publik_guest/homepage.dart';

class tambahEvent extends StatefulWidget {
  const tambahEvent({super.key});

  @override
  State<tambahEvent> createState() => _tambahEventState();
}

class _tambahEventState extends State<tambahEvent> {
  int currentTabIndex = 1;
  final _formKey = GlobalKey<FormState>();
  TextEditingController _nameController = TextEditingController();
  TextEditingController _gambarController = TextEditingController();
  TextEditingController _deskripsiController = TextEditingController();

  Future saveWisata() async {
    try {
      final response = await http.post(
        Uri.parse('http://10.0.2.2:8000/api/event'),
        body: {
          "nama_acara": _nameController.text,
          "gambar": _gambarController.text,
          "deskripsi": _deskripsiController.text,
        },
      );
      if (response.statusCode == 200) {
        return json.decode(response.body);
      }
    } catch (e) {
      print(e);
      return null;
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _gambarController.dispose();
    _deskripsiController.dispose();
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
              decoration: InputDecoration(labelText: "Nama Acara"),
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
            SizedBox(
              height: 25,
            ),
            ElevatedButton(
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  saveWisata().then((value) {
                    if (value != null) {
                      setState(() {
                        currentTabIndex = 1;
                      });
                      Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(
                          builder: (BuildContext context) => NavAdmin(),
                        ),
                        (route) => false,
                      );
                    } else {
                      // Gagal menyimpan data, lakukan sesuatu seperti menampilkan pesan kesalahan
                    }
                  });
                }
              },
              child: Text('Save'),
            ),
          ],
        ),
      ),
    );
  }
}
