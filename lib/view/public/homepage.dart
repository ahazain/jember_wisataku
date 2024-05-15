import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:http/http.dart' as http;

class homepage extends StatefulWidget {
  const homepage({super.key});

  @override
  State<homepage> createState() => _homepageState();
}

class _homepageState extends State<homepage> {
  List _listdata = [];

  Future _getdata() async {
    try {
      final respone = await http
          .get(Uri.parse('http://10.132.1.83/wisata_jember/backend/read.php'));
      if (respone.statusCode == 200) {
        print(respone.body);
        final data = jsonDecode(respone.body);
        setState(() {
          _listdata = data;
        });
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  void initState() {
    _getdata();
    print(_listdata);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home!'),
      ),
      body: ListView.builder(
        itemCount: _listdata.length,
        itemBuilder: (context, index) {
          return Card(
            child: ListTile(
              title: Text(_listdata[index]['nama_wisata']),
              subtitle: Text(_listdata[index]['deskripsi']),
            ),
          );
        },
      ),
    );
  }
}
