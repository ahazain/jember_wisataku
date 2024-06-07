import 'package:flutter/material.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:geolocator/geolocator.dart';
import 'package:permission_handler/permission_handler.dart';
import 'dart:convert';

class DetailWisata extends StatefulWidget {
  final Map<String, dynamic> attraction;

  const DetailWisata({Key? key, required this.attraction}) : super(key: key);

  @override
  State<DetailWisata> createState() => _DetailWisataState();
}

class _DetailWisataState extends State<DetailWisata> {
  List<int> ratings = [];
  double averageRating = 0.0;
  int userRatingId = -1;
  int userRatingValue = 0;
  double distance = 0.0;

  @override
  void initState() {
    super.initState();
    fetchRatings();
    _getCurrentLocation();
  }

  void fetchRatings() async {
    try {
      final response = await http.get(
        Uri.parse(
            'http://192.168.1.72:8000/api/wisata/${widget.attraction['id']}/ratings'),
      );
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        setState(() {
          ratings = List<int>.from(
              data['data'].map((rating) => rating['rating_value']));
          for (var rating in data['data']) {
            if (rating['user_id'] == 1) {
              userRatingId = rating['id'];
              userRatingValue = rating['rating_value'];
            }
          }
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

  void addOrUpdateRating(int ratingValue) async {
    final url = userRatingId == -1
        ? 'http://192.168.1.72:8000/api/wisata/${widget.attraction['id']}/ratings'
        : 'http://192.168.1.72:8000/api/wisata/${widget.attraction['id']}/ratings/$userRatingId';

    try {
      final response = await http.post(
        Uri.parse(url),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, int>{
          'rating_value': ratingValue,
        }),
      );

      if (response.statusCode == 201 || response.statusCode == 200) {
        fetchRatings();
      } else {
        throw Exception('Failed to add or update rating');
      }
    } catch (e) {
      print('Error adding or updating rating: $e');
    }
  }

  void _getCurrentLocation() async {
    try {
      bool serviceEnabled;
      LocationPermission permission;

      serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) {
        throw Exception('Location services are disabled');
      }

      permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          throw Exception('Location permission denied');
        }
      }

      if (permission == LocationPermission.deniedForever) {
        throw Exception('Location permissions are permanently denied');
      }

      var status = await Permission.location.request();
      if (status.isDenied) {
        throw Exception('Location permission denied');
      }

      final position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high);

      final attractionLatitude = double.parse(widget.attraction['latitude'] ??
          '0'); // Pastikan 'latitude' tidak null
      final attractionLongitude = double.parse(widget.attraction['longitude'] ??
          '0'); // Pastikan 'longitude' tidak null

      final distanceInMeters = Geolocator.distanceBetween(
        position.latitude,
        position.longitude,
        attractionLatitude,
        attractionLongitude,
      );

      setState(() {
        distance = distanceInMeters / 1000;
      });
    } catch (e) {
      print('Error getting current location: $e');
    }
  }

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
                  attraction['gambar'] ?? '', // Pastikan 'gambar' tidak null
                  height: 200,
                ),
              ),
              SizedBox(height: 10.0),
              Container(
                margin: EdgeInsets.symmetric(vertical: 10.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      children: [
                        RatingWidget(rating: averageRating.round(), size: 20),
                        SizedBox(height: 5.0),
                        Text(
                          averageRating.toStringAsFixed(1),
                          style: TextStyle(
                              fontSize: 16.0, fontWeight: FontWeight.bold),
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
                              title: Text(userRatingId == -1
                                  ? 'Beri Rating'
                                  : 'Perbarui Rating'),
                              content: StatefulBuilder(
                                builder: (context, setState) {
                                  return Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
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
                                    addOrUpdateRating(selectedRating);
                                    Navigator.pop(context);
                                  },
                                  child: Text('Kirim'),
                                ),
                              ],
                            );
                          },
                        );
                      },
                      child: Text(userRatingId == -1
                          ? 'Beri Rating'
                          : 'Perbarui Rating'),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 10.0),
              Container(
                margin: EdgeInsets.symmetric(vertical: 10.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text(
                      attraction['nama_wisata'] ??
                          '', // Pastikan 'nama_wisata' tidak null
                      style: TextStyle(
                          fontSize: 24.0, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 10),
                    Text(
                      attraction['deskripsi'] ??
                          '', // Pastikan 'deskripsi' tidak null
                      style: TextStyle(fontSize: 16.0),
                      textAlign: TextAlign.justify,
                    ),
                    SizedBox(height: 20.0),
                    Text(
                      "Informasi Tiket Masuk dan Biaya Parkir:",
                      style: TextStyle(
                          fontSize: 18.0, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 10),
                    RichText(
                      text: TextSpan(
                        style: TextStyle(fontSize: 16.0, color: Colors.black),
                        children: [
                          TextSpan(
                            text:
                                "• Tiket masuk Pantai Papuma di weekdays sebesar Rp. 18.000,- per orang.\n",
                          ),
                          TextSpan(
                            text:
                                "• Tiket masuk Pantai Papuma di weekend sebesar Rp. 25.000,- per orang.\n",
                          ),
                          TextSpan(
                            text:
                                "• Biaya parkir mobil sebesar Rp. 10.000,- per unit.\n",
                          ),
                          TextSpan(
                            text:
                                "• Biaya parkir motor sebesar Rp. 5.000,- per unit.\n",
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 20.0),
                    Text(
                      'Jarak dari Lokasi Anda:',
                      style: TextStyle(
                          fontSize: 18.0, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 10),
                    Text(
                      '${distance.toStringAsFixed(2)} km',
                      style: TextStyle(fontSize: 16.0),
                    ),
                    SizedBox(height: 20.0),
                    Text(
                      'Lihat di Peta:',
                      style: TextStyle(
                          fontSize: 18.0, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 10),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => MapsScreen(
                              attractionLatitude: double.parse(
                                  widget.attraction['latitude'] ??
                                      '0'), // Pastikan 'latitude' tidak null
                              attractionLongitude: double.parse(
                                  widget.attraction['longitude'] ??
                                      '0'), // Pastikan 'longitude' tidak null
                            ),
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

class MapsScreen extends StatefulWidget {
  final double attractionLatitude;
  final double attractionLongitude;

  const MapsScreen(
      {Key? key,
      required this.attractionLatitude,
      required this.attractionLongitude})
      : super(key: key);

  @override
  State<MapsScreen> createState() => _MapsScreenState();
}

class _MapsScreenState extends State<MapsScreen> {
  GoogleMapController? _controller;
  final Set<Marker> _markers = {};
  final Set<Polyline> _polylines = {};
  late LatLng _currentPosition;
  late LatLng _destinationPosition;

  @override
  void initState() {
    super.initState();
    _destinationPosition =
        LatLng(widget.attractionLatitude, widget.attractionLongitude);
    _getCurrentLocation();
  }

  void _getCurrentLocation() async {
    try {
      final position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high);

      setState(() {
        _currentPosition = LatLng(position.latitude, position.longitude);
        _markers.add(Marker(
          markerId: MarkerId('currentLocation'),
          position: _currentPosition,
        ));
        _markers.add(Marker(
          markerId: MarkerId('destination'),
          position: _destinationPosition,
        ));
        _drawRoute();
      });
    } catch (e) {
      print('Error getting current location: $e');
    }
  }

  void _drawRoute() async {
    try {
      PolylinePoints polylinePoints = PolylinePoints();
      PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
        'YOUR_API_KEY',
        PointLatLng(_currentPosition.latitude, _currentPosition.longitude),
        PointLatLng(
            _destinationPosition.latitude, _destinationPosition.longitude),
      );

      if (result.points.isNotEmpty) {
        List<LatLng> polylineCoordinates = [];
        for (var point in result.points) {
          polylineCoordinates.add(LatLng(point.latitude, point.longitude));
        }

        setState(() {
          _polylines.add(Polyline(
            polylineId: PolylineId('route'),
            points: polylineCoordinates,
            color: Colors.blue,
            width: 5,
          ));
        });
      } else {
        print('No points found');
      }
    } catch (e) {
      print('Error drawing route: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Peta Wisata'),
      ),
      body: GoogleMap(
        initialCameraPosition: CameraPosition(
          target: _destinationPosition,
          zoom: 14,
        ),
        markers: _markers,
        polylines: _polylines,
        onMapCreated: (GoogleMapController controller) {
          _controller = controller;
        },
      ),
    );
  }
}
