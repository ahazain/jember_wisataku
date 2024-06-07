// import 'dart:async';
// import 'dart:convert';
// import 'package:flutter/material.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';
// import 'package:http/http.dart' as http;
// import 'package:location/location.dart' as loc;
// import 'package:jember_wisataku/Percobaan/api_keys.dart'; // Sesuaikan dengan lokasi file Anda
// import 'package:permission_handler/permission_handler.dart';

// class Maps extends StatefulWidget {
//   const Maps({Key? key}) : super(key: key);

//   @override
//   State<Maps> createState() => _MapsState();
// }

// class _MapsState extends State<Maps> {
//   loc.Location _locationController = loc.Location();
//   final Completer<GoogleMapController> _mapController =
//       Completer<GoogleMapController>();

//   static const LatLng _patrang = LatLng(-8.077747181216393, 113.69101597450369);
//   static const LatLng _pGooglePlex =
//       LatLng(-8.104701843458363, 113.70691997903269);
//   LatLng? _currentP;

//   Map<PolylineId, Polyline> polylines = {};

//   @override
//   void initState() {
//     super.initState();
//     _getLocationUpdate().then((_) {
//       getPolylinePoints().then((coordinates) {
//         if (coordinates.isNotEmpty) {
//           generatePolyLineFromPoints(coordinates);
//         } else {
//           ScaffoldMessenger.of(context).showSnackBar(SnackBar(
//               content: Text('Failed to retrieve polyline coordinates')));
//         }
//       });
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: _currentP == null
//           ? const Center(
//               child: Text('Loading..'),
//             )
//           : GoogleMap(
//               onMapCreated: (GoogleMapController controller) {
//                 _mapController.complete(controller);
//               },
//               initialCameraPosition:
//                   CameraPosition(target: _pGooglePlex, zoom: 13),
//               markers: _createMarkers(),
//               polylines: Set<Polyline>.of(polylines.values),
//             ),
//     );
//   }

//   Set<Marker> _createMarkers() {
//     Set<Marker> markers = {
//       Marker(
//           markerId: MarkerId("sourceLocation"),
//           icon: BitmapDescriptor.defaultMarker,
//           position: _pGooglePlex),
//       Marker(
//           markerId: MarkerId("_Tujuan"),
//           icon: BitmapDescriptor.defaultMarker,
//           position: _patrang),
//     };
//     if (_currentP != null) {
//       markers.add(
//         Marker(
//           markerId: MarkerId("_currentLocation"),
//           icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue),
//           position: _currentP!,
//         ),
//       );
//     }
//     return markers;
//   }

//   Future<void> _cameraToPosition(LatLng pos) async {
//     final GoogleMapController controller = await _mapController.future;
//     CameraPosition newCameraPosition = CameraPosition(
//       target: pos,
//       zoom: 13,
//     );
//     await controller
//         .animateCamera(CameraUpdate.newCameraPosition(newCameraPosition));
//   }

//   Future<void> _getLocationUpdate() async {
//     bool _serviceEnabled;
//     loc.PermissionStatus _permissionGranted;

//     _serviceEnabled = await _locationController.serviceEnabled();
//     if (!_serviceEnabled) {
//       _serviceEnabled = await _locationController.requestService();
//       if (!_serviceEnabled) {
//         return;
//       }
//     }

//     _permissionGranted = await _locationController.hasPermission();
//     if (_permissionGranted == loc.PermissionStatus.denied) {
//       _permissionGranted = await _locationController.requestPermission();
//       if (_permissionGranted != loc.PermissionStatus.granted) {
//         ScaffoldMessenger.of(context).showSnackBar(SnackBar(
//             content: Text('Location permission is required for this app')));
//         return;
//       }
//     }

//     _locationController.onLocationChanged
//         .listen((loc.LocationData currentLocation) {
//       if (currentLocation.latitude != null &&
//           currentLocation.longitude != null) {
//         setState(() {
//           _currentP =
//               LatLng(currentLocation.latitude!, currentLocation.longitude!);
//           _cameraToPosition(_currentP!);
//         });
//       }
//     });
//   }

//   Future<List<LatLng>> getPolylinePoints() async {
//     List<LatLng> polylineCoordinates = [];
//     final response = await http.get(
//       Uri.parse(
//           'https://api.openrouteservice.org/v2/directions/driving-car?api_key=$_orsApiKey&start=${_pGooglePlex.longitude},${_pGooglePlex.latitude}&end=${_patrang.longitude},${_patrang.latitude}'),
//     );

//     if (response.statusCode == 200) {
//       final data = json.decode(response.body);
//       final List coordinates = data['routes'][0]['geometry']['coordinates'];

//       coordinates.forEach((coordinate) {
//         polylineCoordinates.add(LatLng(coordinate[1], coordinate[0]));
//       });
//     } else {
//       print('Failed to load polyline coordinates: ${response.reasonPhrase}');
//       print('Response body: ${response.body}');
//     }
//     return polylineCoordinates;
//   }

//   void generatePolyLineFromPoints(List<LatLng> polylineCoordinates) async {
//     PolylineId id = PolylineId('poly');
//     Polyline polyline = Polyline(
//       polylineId: id,
//       color: Colors.black,
//       points: polylineCoordinates,
//       width: 8,
//     );
//     setState(() {
//       polylines[id] = polyline;
//     });
//   }
// }
