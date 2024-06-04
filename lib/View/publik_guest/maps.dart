// import 'package:flutter/material.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';
// import 'package:geolocator/geolocator.dart';
// import 'package:flutter_polyline_points/flutter_polyline_points.dart';

// class MapsPage extends StatefulWidget {
//   final double destinationLatitude;
//   final double destinationLongitude;

//   const MapsPage({
//     Key? key,
//     required this.destinationLatitude,
//     required this.destinationLongitude,
//   }) : super(key: key);

//   @override
//   _MapsPageState createState() => _MapsPageState();
// }

// class _MapsPageState extends State<MapsPage> {
//   late GoogleMapController mapController;

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Maps'),
//       ),
//       body: GoogleMap(
//         onMapCreated: _onMapCreated,
//         initialCameraPosition: CameraPosition(
//           target:
//               LatLng(widget.destinationLatitude, widget.destinationLongitude),
//           zoom: 12,
//         ),
//         markers: {
//           Marker(
//             markerId: MarkerId('Destination'),
//             position:
//                 LatLng(widget.destinationLatitude, widget.destinationLongitude),
//             infoWindow: InfoWindow(title: 'Destination'),
//           ),
//         },
//       ),
//     );
//   }

//   void _onMapCreated(GoogleMapController controller) {
//     setState(() {
//       mapController = controller;
//     });
//   }
// }
