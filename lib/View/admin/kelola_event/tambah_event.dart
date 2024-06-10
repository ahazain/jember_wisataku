import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;
import 'package:jember_wisataku/View/admin/nav_admin.dart';
import 'package:shared_preferences/shared_preferences.dart';

class tambah_event extends StatefulWidget {
  const tambah_event({Key? key});

  @override
  State<tambah_event> createState() => _tambah_eventState();
}

class _tambah_eventState extends State<tambah_event> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController _nameController = TextEditingController();
  TextEditingController _gambarController = TextEditingController();
  TextEditingController _deskripsiController = TextEditingController();

  Future saveEvent() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? accessToken = prefs.getString('access_token');

      if (accessToken == null || accessToken.isEmpty) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => NavAdmin()),
        );
        return;
      }

      final response = await http.post(
        Uri.parse(
            'https://jemberwisataapi-production.up.railway.app/api/event'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer $accessToken',
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
        throw Exception('Failed to save data event');
      }
    } catch (e) {
      print('Error saving event: $e');
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
        title: Text('Tambah Acara Tahunan'),
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
                  labelText: "Nama Acara",
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
              SizedBox(height: 25),
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        saveEvent().then((value) {
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
                    child: Text('Save'),
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
            ],
          ),
        ),
      ),
    );
  }
}
