// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
// import 'dart:convert';

// class RatingManagement extends StatefulWidget {
//   final int wisataId;

//   const RatingManagement({Key? key, required this.wisataId}) : super(key: key);

//   @override
//   _RatingManagementState createState() => _RatingManagementState();
// }

// class _RatingManagementState extends State<RatingManagement> {
//   final _formKey = GlobalKey<FormState>();
//   int _ratingValue = 1;

//   Future<void> _submitRating() async {
//     if (_formKey.currentState!.validate()) {
//       final response = await http.post(
//         Uri.parse(
//             'http://127.0.0.1:8000/api/wisata/${widget.wisataId}/ratings'),
//         headers: {
//           'Content-Type': 'application/json',
//         },
//         body: json.encode({'rating_value': _ratingValue}),
//       );

//       if (response.statusCode == 201) {
//         ScaffoldMessenger.of(context).showSnackBar(SnackBar(
//           content: Text('Rating berhasil ditambahkan'),
//         ));
//       } else {
//         ScaffoldMessenger.of(context).showSnackBar(SnackBar(
//           content: Text('Gagal menambahkan rating'),
//         ));
//       }
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Form(
//       key: _formKey,
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           DropdownButtonFormField<int>(
//             value: _ratingValue,
//             onChanged: (int? newValue) {
//               setState(() {
//                 _ratingValue = newValue!;
//               });
//             },
//             items: [1, 2, 3, 4, 5].map((int value) {
//               return DropdownMenuItem<int>(
//                 value: value,
//                 child: Text(value.toString()),
//               );
//             }).toList(),
//             decoration: InputDecoration(labelText: 'Rating'),
//             validator: (value) {
//               if (value == null) {
//                 return 'Please select a rating';
//               }
//               return null;
//             },
//           ),
//           SizedBox(height: 16.0),
//           ElevatedButton(
//             onPressed: _submitRating,
//             child: Text('Submit'),
//           ),
//         ],
//       ),
//     );
//   }
// }
