import 'package:flutter/material.dart';

class DetailWisata extends StatefulWidget {
  const DetailWisata({Key? key}) : super(key: key);

  @override
  _DetailWisataFormState createState() => _DetailWisataFormState();
}

class _DetailWisataFormState extends State<DetailWisata> {
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
        backgroundColor: Colors.green,
      ),
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextFormField(
                  decoration: const InputDecoration(
                    labelText: 'Nama Tempat',
                  ),
                  onSaved: (value) {
                    namaTempat = value ?? '';
                  },
                ),
                TextFormField(
                  decoration: const InputDecoration(
                    labelText: 'Kategori',
                  ),
                  onSaved: (value) {
                    kategori = value ?? '';
                  },
                ),
                TextFormField(
                  decoration: const InputDecoration(
                    labelText: 'URL Foto',
                  ),
                  onSaved: (value) {
                    foto = value ?? '';
                  },
                ),
                TextFormField(
                  decoration: const InputDecoration(
                    labelText: 'Deskripsi',
                  ),
                  onSaved: (value) {
                    deskripsi = value ?? '';
                  },
                ),
                TextFormField(
                  decoration: const InputDecoration(
                    labelText: 'Maps URL',
                  ),
                  onSaved: (value) {
                    maps = value ?? '';
                  },
                ),
                TextFormField(
                  decoration: const InputDecoration(
                    labelText: 'Jam Operasional',
                  ),
                  onSaved: (value) {
                    jamOperasional = value ?? '';
                  },
                ),
                TextFormField(
                  decoration: const InputDecoration(
                    labelText: 'Harga Tiket',
                  ),
                  onSaved: (value) {
                    hargaTiket = value ?? '';
                  },
                ),
                TextFormField(
                  decoration: const InputDecoration(
                    labelText: 'Menu',
                  ),
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
                        backgroundColor: Colors.green,
                        minimumSize: const Size(100, 50),
                      ),
                      child: const Text('Simpan',
                          style: TextStyle(color: Colors.black)),
                    ),
                    const SizedBox(height: 10),
                    ElevatedButton(
                      onPressed: () {
                        // Logika apabila batal
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.red,
                        minimumSize: const Size(500, 50),
                      ),
                      child: const Text('Batal',
                          style: TextStyle(color: Colors.black)),
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
}
