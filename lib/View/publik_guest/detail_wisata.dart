import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:jember_wisataku/widget/widget_support.dart';
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:jember_wisataku/Maps/maps.dart';
import 'package:jember_wisataku/View/publik_guest/nav_guest.dart';

class DetailWisata extends StatefulWidget {
  final Map<String, dynamic> attraction;

  const DetailWisata({Key? key, required this.attraction}) : super(key: key);

  @override
  State<DetailWisata> createState() => _DetailWisataState();
}

class _DetailWisataState extends State<DetailWisata> {
  List<int> ratings = [];
  double averageRating = 0.0;
  int userRatingValue = 0;

  @override
  void initState() {
    super.initState();
    fetchRatings();
  }

  void fetchRatings() async {
    try {
      final response = await http.get(
        Uri.parse(
            'https://jemberwisataapi-production.up.railway.app/api/wisata/${widget.attraction['id']}/ratings'),
      );
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        setState(() {
          ratings = List<int>.from(
              data['data'].map((rating) => rating['rating_value']));
          averageRating = ratings.isEmpty
              ? 0.0
              : ratings.reduce((a, b) => a + b) / ratings.length;
        });
      } else {
        throw Exception('Failed to fetch ratings');
      }
    } catch (e) {
      // Handle error
      print('Error fetching ratings: $e');
    }
  }

  void addRating(int ratingValue) async {
    final url =
        'https://jemberwisataapi-production.up.railway.app/api/wisata/${widget.attraction['id']}/ratings';

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

      final response = await http.post(
        Uri.parse(url),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer $accessToken',
        },
        body: jsonEncode(<String, int>{'rating_value': ratingValue}),
      );

      if (response.statusCode == 201 || response.statusCode == 200) {
        print('BERHASIL MEMBERI RATING');
        fetchRatings();
      } else {
        throw Exception('Failed to add or update rating');
      }
    } catch (e) {
      print('Error adding or updating rating: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    final attraction = widget.attraction;

    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.all(40.0),
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
                  attraction['nama_wisata'] ?? '',
                  style: AppWidget.bold2TextFieldStyle(),
                ),
                SizedBox(height: 10),
                Text(
                  attraction['deskripsi'] ?? '',
                  style: TextStyle(fontSize: 16.0),
                  textAlign: TextAlign.justify,
                ),
                SizedBox(height: 20.0),
              ]),
              SizedBox(height: 20.0),
              Container(
                margin: EdgeInsets.all(20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      margin: EdgeInsets.symmetric(vertical: 10.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            children: [
                              RatingWidget(
                                  rating: averageRating.round(), size: 20),
                              SizedBox(height: 5.0),
                              Text(
                                averageRating.toStringAsFixed(1),
                                style: TextStyle(
                                    fontSize: 16.0,
                                    fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                          ElevatedButton(
                            onPressed: () {
                              showDialog(
                                context: context,
                                builder: (context) {
                                  int selectedRating = userRatingValue;
                                  return AlertDialog(
                                    title: Text('Beri Rating'),
                                    content: StatefulBuilder(
                                      builder: (context, setState) {
                                        return Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: List.generate(5, (index) {
                                            return IconButton(
                                              icon: Icon(
                                                index < selectedRating
                                                    ? Icons.star
                                                    : Icons.star_border,
                                                color: Colors.amber,
                                              ),
                                              onPressed: () {
                                                setState(() {
                                                  selectedRating = index + 1;
                                                });
                                              },
                                            );
                                          }),
                                        );
                                      },
                                    ),
                                    actions: [
                                      TextButton(
                                        onPressed: () {
                                          Navigator.pop(context);
                                        },
                                        child: Text('Batal'),
                                      ),
                                      TextButton(
                                        onPressed: () {
                                          addRating(selectedRating);
                                          Navigator.pop(context);
                                        },
                                        child: Text('Kirim'),
                                      ),
                                    ],
                                  );
                                },
                              );
                            },
                            child: Text('Beri Rating'),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 10),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => Maps(attraction: attraction),
                          ),
                        );
                      },
                      child: Text('Lihat di Peta'),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class RatingWidget extends StatelessWidget {
  final int rating;
  final double size;

  const RatingWidget({Key? key, required this.rating, required this.size})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(5, (index) {
        return Icon(
          index < rating ? Icons.star : Icons.star_border,
          size: size,
          color: Colors.amber,
        );
      }),
    );
  }
}
