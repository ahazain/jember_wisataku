import 'package:flutter/material.dart';

class input_wisata extends StatefulWidget {
  const input_wisata({Key? key}) : super(key: key);

  @override
  _input_wisataFormState createState() => _input_wisataFormState();
}

class _input_wisataFormState extends State<input_wisata> {
  final _formKey = GlobalKey<FormState>();

  String namaTempat = '';
  String kategori = '';
  String foto = '';
  String deskripsi = '';
  String maps = '';
  String jamOperasional = '';
  String hargaTiket = '';
  String menu = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Jember Wisata"),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 1,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildTextField(
                  labelText: 'Nama Tempat',
                  onSaved: (value) {
                    namaTempat = value ?? '';
                  },
                ),
                _buildTextField(
                  labelText: 'Kategori',
                  onSaved: (value) {
                    kategori = value ?? '';
                  },
                ),
                _buildTextField(
                  labelText: 'URL Foto',
                  onSaved: (value) {
                    foto = value ?? '';
                  },
                ),
                _buildTextField(
                  labelText: 'Deskripsi',
                  onSaved: (value) {
                    deskripsi = value ?? '';
                  },
                  maxLines: 5, // Makes the field larger for description
                ),
                _buildTextField(
                  labelText: 'URL Maps',
                  onSaved: (value) {
                    maps = value ?? '';
                  },
                ),
                _buildTextField(
                  labelText: 'Jam Operasional',
                  onSaved: (value) {
                    jamOperasional = value ?? '';
                  },
                ),
                _buildTextField(
                  labelText: 'Harga Tiket',
                  onSaved: (value) {
                    hargaTiket = value ?? '';
                  },
                ),
                _buildTextField(
                  labelText: 'Menu',
                  onSaved: (value) {
                    menu = value ?? '';
                  },
                ),
                const SizedBox(height: 20),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          _formKey.currentState!.save();
                          // You can now use the text field values for whatever you need
                          // For example, you could pass them to another widget or print them
                          print('Nama Tempat: $namaTempat');
                          print('Kategori: $kategori');
                          print('Foto: $foto');
                          print('Deskripsi: $deskripsi');
                          print('Maps: $maps');
                          print('Jam Operasional: $jamOperasional');
                          print('Harga Tiket: $hargaTiket');
                          print('Menu: $menu');
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color.fromARGB(255, 0, 220, 33),
                        minimumSize: const Size(double.infinity, 50),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20.0),
                        ),
                      ),
                      child: const Text(
                        'Simpan',
                        style: TextStyle(color: Colors.black),
                      ),
                    ),
                    const SizedBox(height: 10),
                    ElevatedButton(
                      onPressed: () {
                        // Logika apabila batal
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFFFF0000),
                        minimumSize: const Size(double.infinity, 50),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20.0),
                        ),
                      ),
                      child: const Text(
                        'Batal',
                        style: TextStyle(color: Colors.black),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTextField({
    required String labelText,
    required void Function(String?) onSaved,
    int maxLines = 1,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextFormField(
        decoration: InputDecoration(
          labelText: labelText,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
            borderSide: BorderSide.none,
          ),
          filled: true,
          fillColor: Colors.grey[300],
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 16.0, vertical: 20.0),
        ),
        onSaved: onSaved,
        maxLines: maxLines,
      ),
    );
  }
}
