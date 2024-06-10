import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:location/location.dart' as loc;
import 'package:jember_wisataku/Maps/api_keys.dart'; // Sesuaikan dengan lokasi file Anda
import 'package:permission_handler/permission_handler.dart';
import 'package:geolocator/geolocator.dart'; // To calculate distance

class Maps extends StatefulWidget {
  final Map<String, dynamic> attraction;

  const Maps({Key? key, required this.attraction}) : super(key: key);

  @override
  State<Maps> createState() => _MapsState();
}

class _MapsState extends State<Maps> {
  loc.Location _locationController = loc.Location();
  final Completer<GoogleMapController> _mapController =
      Completer<GoogleMapController>();

  LatLng? _currentP;
  double? _distanceInKm;

  Map<PolylineId, Polyline> polylines = {};

  @override
  void initState() {
    super.initState();
    _getLocationUpdate();
  }

  @override
  Widget build(BuildContext context) {
    final LatLng destination = LatLng(
      widget.attraction['latitude'],
      widget.attraction['longitude'],
    );

    return Scaffold(
      appBar: AppBar(
        title: _distanceInKm == null
            ? Text('Loading...')
            : Center(
                child:
                    Text('Distance: ${_distanceInKm!.toStringAsFixed(2)} km')),
      ),
      body: _currentP == null
          ? const Center(
              child: Text('Loading..'),
            )
          : GoogleMap(
              onMapCreated: (GoogleMapController controller) {
                _mapController.complete(controller);
              },
              initialCameraPosition:
                  CameraPosition(target: destination, zoom: 13),
              markers: _createMarkers(destination),
              polylines: Set<Polyline>.of(polylines.values),
            ),
    );
  }

  Set<Marker> _createMarkers(LatLng destination) {
    Set<Marker> markers = {
      Marker(
          markerId: MarkerId("destination"),
          icon: BitmapDescriptor.defaultMarker,
          position: destination),
    };
    if (_currentP != null) {
      markers.add(
        Marker(
          markerId: MarkerId("currentLocation"),
          icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue),
          position: _currentP!,
        ),
      );
    }
    return markers;
  }

  Future<void> _cameraToPosition(LatLng pos) async {
    final GoogleMapController controller = await _mapController.future;
    CameraPosition newCameraPosition = CameraPosition(
      target: pos,
      zoom: 13,
    );
    await controller
        .animateCamera(CameraUpdate.newCameraPosition(newCameraPosition));
  }

  Future<void> _getLocationUpdate() async {
    bool _serviceEnabled;
    loc.PermissionStatus _permissionGranted;

    _serviceEnabled = await _locationController.serviceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await _locationController.requestService();
      if (!_serviceEnabled) {
        return;
      }
    }

    _permissionGranted = await _locationController.hasPermission();
    if (_permissionGranted == loc.PermissionStatus.denied) {
      _permissionGranted = await _locationController.requestPermission();
      if (_permissionGranted != loc.PermissionStatus.granted) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text('Location permission is required for this app')));
        return;
      }
    }

    _locationController.onLocationChanged
        .listen((loc.LocationData currentLocation) async {
      if (currentLocation.latitude != null &&
          currentLocation.longitude != null) {
        final LatLng destination = LatLng(
          widget.attraction['latitude'],
          widget.attraction['longitude'],
        );

        setState(() {
          _currentP =
              LatLng(currentLocation.latitude!, currentLocation.longitude!);
          _cameraToPosition(_currentP!);
          _distanceInKm = _calculateDistance(_currentP!, destination);
        });

        final coordinates = await getPolylinePoints(_currentP!, destination);
        if (coordinates.isNotEmpty) {
          generatePolyLineFromPoints(coordinates);
        } else {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Text('Failed to retrieve polyline coordinates')));
        }
      }
    });
  }

  Future<List<LatLng>> getPolylinePoints(LatLng start, LatLng end) async {
    List<LatLng> polylineCoordinates = [];
    final String url =
        'https://api.openrouteservice.org/v2/directions/driving-car?api_key=$ORS_API_KEY&start=${start.longitude},${start.latitude}&end=${end.longitude},${end.latitude}';

    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final List coordinates = data['features'][0]['geometry']['coordinates'];

      coordinates.forEach((coordinate) {
        polylineCoordinates.add(LatLng(coordinate[1], coordinate[0]));
      });
    } else {
      print('Failed to load polyline coordinates: ${response.reasonPhrase}');
      print('Response body: ${response.body}');
    }
    return polylineCoordinates;
  }

  void generatePolyLineFromPoints(List<LatLng> polylineCoordinates) async {
    PolylineId id = PolylineId('poly');
    Polyline polyline = Polyline(
      polylineId: id,
      color: Colors.black,
      points: polylineCoordinates,
      width: 8,
    );
    setState(() {
      polylines[id] = polyline;
    });
  }

  double _calculateDistance(LatLng start, LatLng end) {
    return Geolocator.distanceBetween(
          start.latitude,
          start.longitude,
          end.latitude,
          end.longitude,
        ) /
        1000; // Convert to kilometers
  }
}
