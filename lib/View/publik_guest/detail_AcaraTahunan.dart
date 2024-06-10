import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:jember_wisataku/Maps/maps.dart';
import 'package:jember_wisataku/NavigasiBar/nav_guest.dart';

class Detail_Acara extends StatefulWidget {
  final Map<String, dynamic> attraction;

  const Detail_Acara({Key? key, required this.attraction}) : super(key: key);

  @override
  State<Detail_Acara> createState() => _Detail_AcaraState();
}

class _Detail_AcaraState extends State<Detail_Acara> {
  @override
  Widget build(BuildContext context) {
    final attraction = widget.attraction;

    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Icon(Icons.arrow_back_ios_new_outlined,
                    color: Colors.black),
              ),
              SizedBox(height: 20.0),
              Center(
                child: Image.network(
                  attraction['gambar'] ?? '',
                  height: 200,
                ),
              ),
              SizedBox(height: 20.0),
              Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
                Text(
                  attraction['nama_acara'] ?? '',
                  style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 10),
                Text(
                  attraction['deskripsi'] ?? '',
                  style: TextStyle(fontSize: 16.0),
                  textAlign: TextAlign.justify,
                ),
                SizedBox(height: 20.0),
              ]),
            ],
          ),
        ),
      ),
    );
  }
}
