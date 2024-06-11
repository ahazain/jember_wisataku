import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;
import 'package:jember_wisataku/View/admin/kelola_wisata/read_wisata.dart';
import 'package:jember_wisataku/NavigasiBar/nav_admin.dart';
import 'package:jember_wisataku/View/publik_guest/homepage.dart';
import 'package:jember_wisataku/NavigasiBar/nav_guest.dart';
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

  @override
  void initState() {
    super.initState();
    _nameController.text = widget.wisata['nama_acara'];
    _gambarController.text = widget.wisata['gambar'];
    _deskripsiController.text = widget.wisata['deskripsi'];
  }

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

    _gambarController.dispose();
    _deskripsiController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Acara Tahunan'),
        automaticallyImplyLeading: false,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
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
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    updateEvent().then((value) {
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
    );
  }
}
