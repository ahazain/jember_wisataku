import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:jember_wisataku/NavigasiBar/nav_admin.dart';
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
  TextEditingController _latitudeController = TextEditingController();
  TextEditingController _longitudeController = TextEditingController();
  int? _selectedJenisWisata;

  @override
  void initState() {
    super.initState();
    _nameController.text = widget.wisata['nama_wisata'];
    _selectedJenisWisata = widget.wisata['jenis_wisata_id'] is int
        ? widget.wisata['jenis_wisata_id']
        : int.tryParse(widget.wisata['jenis_wisata_id'].toString());
    _gambarController.text = widget.wisata['gambar'];
    _deskripsiController.text = widget.wisata['deskripsi'];
    _alamatController.text = widget.wisata['alamat'];
    _latitudeController.text = widget.wisata['latitude']?.toString() ?? '';
    _longitudeController.text = widget.wisata['longitude']?.toString() ?? '';
  }

  Future updateWisata() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? accessToken = prefs.getString('access_token');

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
          'Authorization': 'Bearer $accessToken',
        },
        body: jsonEncode(<String, dynamic>{
          "jenis_wisata_id": _selectedJenisWisata,
          "nama_wisata": _nameController.text,
          "gambar": _gambarController.text,
          "deskripsi": _deskripsiController.text,
          "alamat": _alamatController.text,
          "latitude": double.tryParse(_latitudeController.text),
          "longitude": double.tryParse(_longitudeController.text),
        }),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
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
        print('Failed: ${response.statusCode}');
        print('Response body: ${response.body}');
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
    _alamatController.dispose();
    _latitudeController.dispose();
    _longitudeController.dispose();
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
                    _selectedJenisWisata = value;
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
                  } else if (double.tryParse(value) == null) {
                    return "Data harus berupa angka";
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
                  } else if (double.tryParse(value) == null) {
                    return "Data harus berupa angka";
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
                        MaterialPageRoute(builder: (context) => NavAdmin()),
                      );
                    });
                  }
                },
                child: Text('Update'),
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
