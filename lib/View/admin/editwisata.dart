import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:jember_wisataku/View/admin/HomeAdminku.dart';
import 'package:jember_wisataku/View/admin/home_admin.dart';
import 'package:jember_wisataku/View/publik_guest/homepage.dart';

class editData extends StatefulWidget {
  final Map<String, dynamic> attraction;

  const editData({Key? key, required this.attraction}) : super(key: key);

  @override
  State<editData> createState() => _editDataState();
}

class _editDataState extends State<editData> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController _nameController = TextEditingController();
  TextEditingController _jeniswisataController = TextEditingController();
  TextEditingController _gambarController = TextEditingController();
  TextEditingController _deskripsiController = TextEditingController();
  TextEditingController _alamatController = TextEditingController();

  Future saveWisata() async {
    try {
      final response = await http.put(
        Uri.parse('http://127.0.0.1:8000/api/wisata' +
            widget.attraction['id'].toString()),
        body: {
          "jenis_wisata_id": _jeniswisataController.text,
          "nama_wisata": _nameController.text,
          "gambar": _gambarController.text,
          "deskripsi": _deskripsiController.text,
          "alamat": _alamatController.text,
        },
      );
      if (response.statusCode == 200) {
        return json.decode(response.body);
      } else {
        throw Exception('Gagal menyimpan wisata');
      }
    } catch (e) {
      print(e);
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
        title: Text('Tambah Wisata'),
      ),
      body: Form(
        key: _formKey,
        child: Column(
          children: [
            TextFormField(
              controller: _nameController
                ..value = TextEditingValue(
                    text: widget.attraction['nama_wisata'] ?? ''),
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
                ..value = TextEditingValue(
                    text: widget.attraction['jenis_wisata_id'] ?? ''),
              decoration: InputDecoration(labelText: "Jenis Wisata"),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return "Data tidak boleh kosong";
                }
                return null;
              },
            ),
            TextFormField(
              controller: _gambarController
                ..value =
                    TextEditingValue(text: widget.attraction['gambar'] ?? ''),
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
                ..value = TextEditingValue(
                    text: widget.attraction['deskripsi'] ?? ''),
              decoration: InputDecoration(labelText: "Deskripsi"),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return "Data tidak boleh kosong";
                }
                return null;
              },
            ),
            TextFormField(
              controller: _alamatController
                ..value =
                    TextEditingValue(text: widget.attraction['alamat'] ?? ''),
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
                  saveWisata().then((value) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => HomeAdminKu()),
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
