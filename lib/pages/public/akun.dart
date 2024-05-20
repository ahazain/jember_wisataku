import 'dart:math';
import 'package:flutter/material.dart';
import 'package:jember_wisataku/pages/login.dart';
import 'package:jember_wisataku/pages/public/buttonnav.dart';
import 'package:jember_wisataku/widget/widget_support.dart';

class akun extends StatefulWidget {
  const akun({super.key});

  @override
  State<akun> createState() => _akunState();
}

class _akunState extends State<akun> {
  bool _isEditing = false;
  TextEditingController _nameController = TextEditingController();
  TextEditingController _emailController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _nameController.text = 'Surahki'; // Replace with actual user name
    _emailController.text =
        'surahki@example.com'; // Replace with actual user email
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    super.dispose();
  }

  void _toggleEdit() {
    setState(() {
      _isEditing = !_isEditing;
    });
  }

  void _logout() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => login(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(height: 20),
              _isEditing
                  ? TextFormField(
                      controller: _nameController,
                      decoration: InputDecoration(labelText: 'Nama'),
                    )
                  : Text(
                      _nameController.text,
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
              SizedBox(height: 10),
              _isEditing
                  ? TextFormField(
                      controller: _emailController,
                      decoration: InputDecoration(labelText: 'Email'),
                    )
                  : Text(
                      _emailController.text,
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.grey[700],
                      ),
                    ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: _toggleEdit,
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all<Color>(
                      Color.fromARGB(255, 0, 175, 44)),
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                  ),
                ),
                child: Text(
                  _isEditing ? 'Simpan' : 'Edit',
                  style: AppWidget.head4TextFieldStyle(),
                ),
              ),
              SizedBox(height: 10),
              ElevatedButton(
                onPressed: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => buttonNav(),
                    ),
                  );
                },
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all<Color>(
                      Color.fromARGB(255, 180, 33, 28)),
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                  ),
                ),
                child: Text(
                  "Keluar",
                  style: AppWidget.head4TextFieldStyle(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
