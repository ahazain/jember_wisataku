import "dart:math";

import "package:flutter/material.dart";
import "package:jember_wisataku/pages/login.dart";

class akun extends StatefulWidget {
  const akun({super.key});

  @override
  State<akun> createState() => _akunState();
}

class _akunState extends State<akun> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircleAvatar(
              radius: 50,
              // Ganti dengan gambar profil Anda
              backgroundImage: AssetImage(''),
            ),
            SizedBox(height: 20),
            Text(
              'Surahki', // Ganti dengan nama pengguna Anda
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => login(),
                  ),
                );
              },
              child: Text('keluar'),
            ),
          ],
        ),
      ),
    );
  }
}
