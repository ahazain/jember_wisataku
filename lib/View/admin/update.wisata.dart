import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class UpdateWisata extends StatefulWidget {
  final Map<String, dynamic> wisata;

  const UpdateWisata({Key? key, required this.wisata}) : super(key: key);

  @override
  _UpdateWisataState createState() => _UpdateWisataState();
}

class _UpdateWisataState extends State<UpdateWisata> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _nameController;
  late TextEditingController _gambarController;
  late TextEditingController _jeniswisataController;
  late TextEditingController _deskripsiController;
  late TextEditingController _alamatController;
  late TextEditingController _idWisataController;

  @override
  void initState() {
    super.initState();
    _idWisataController = TextEditingController(text: widget.wisata['id']);
    _nameController = TextEditingController(text: widget.wisata['nama_wisata']);
    _gambarController = TextEditingController(text: widget.wisata['gambar']);
    _jeniswisataController = TextEditingController(
        text: widget.wisata['jenis_wisata_id'].toString());
    _deskripsiController =
        TextEditingController(text: widget.wisata['deskripsi']);
    _alamatController = TextEditingController(text: widget.wisata['alamat']);
  }

  Future<void> _updateWisata() async {
    if (_formKey.currentState!.validate()) {
      final response = await http.put(
        Uri.parse('http://127.0.0.1:8000/api/wisata/${widget.wisata['id']}'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode({
          'nama_wisata': _nameController.text,
          'gambar': _gambarController.text,
          'jenis_wisata_id': int.parse(_jeniswisataController.text),
          'deskripsi': _deskripsiController.text,
          'alamat': _alamatController.text,
        }),
      );

      print('Status code: ${response.statusCode}');
      print('Response body: ${response.body}');

      if (response.statusCode == 200) {
        Navigator.pop(context, json.decode(response.body));
      } else {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text('Failed to update wisata')));
      }
    }
  }

  @override
  void dispose() {
    _idWisataController.dispose();
    _nameController.dispose();
    // _jeniswisataController.dispose();
    _gambarController.dispose();
    _deskripsiController.dispose();
    _alamatController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Update Wisata')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: <Widget>[
              TextFormField(
                controller: _nameController,
                decoration: InputDecoration(labelText: 'Nama Wisata'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Nama Wisata is required';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _gambarController,
                decoration: InputDecoration(labelText: 'Gambar URL'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Nama Wisata is required';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _jeniswisataController,
                decoration: InputDecoration(labelText: 'Jenis Wisata ID'),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Nama Wisata is required';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _deskripsiController,
                decoration: InputDecoration(labelText: 'Deskripsi'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Nama Wisata is required';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _alamatController,
                decoration: InputDecoration(labelText: 'Alamat'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Nama Wisata is required';
                  }
                  return null;
                },
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: _updateWisata,
                child: Text('Update Wisata'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
