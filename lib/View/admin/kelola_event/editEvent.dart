import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;
import 'package:jember_wisataku/View/admin/kelola_wisata/read_wisata.dart';
import 'package:jember_wisataku/View/admin/nav_admin.dart';
import 'package:jember_wisataku/View/publik_guest/homepage.dart';
import 'package:jember_wisataku/View/publik_guest/nav_guest.dart';
import 'package:shared_preferences/shared_preferences.dart';

class EditEvent extends StatefulWidget {
  final Map<String, dynamic> wisata;

  const EditEvent({Key? key, required this.wisata}) : super(key: key);

  @override
  State<EditEvent> createState() => _EditEventState();
}

class _EditEventState extends State<EditEvent> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController _nameController = TextEditingController();

  TextEditingController _gambarController = TextEditingController();
  TextEditingController _deskripsiController = TextEditingController();

  Future updateEvent() async {
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
            'https://jemberwisataapi-production.up.railway.app/api/event/' +
                widget.wisata['id'].toString()),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer $accessToken', // Sertakan Bearer Token
        },
        body: jsonEncode(<String, dynamic>{
          "nama_acara": _nameController.text,
          "gambar": _gambarController.text,
          "deskripsi": _deskripsiController.text,
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

    _gambarController.dispose();
    _deskripsiController.dispose();

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
              controller: _nameController..text = widget.wisata['nama_acara'],
              decoration: InputDecoration(labelText: "Nama Wisata"),
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
            SizedBox(
              height: 25,
            ),
            ElevatedButton(
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  updateEvent().then((value) {
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
