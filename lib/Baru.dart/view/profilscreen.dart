// import 'dart:convert';
// import 'package:flutter/material.dart';
// import 'package:jember_wisataku/Baru.dart/service/auth_service.dart';

// class ProfileScreen extends StatefulWidget {
//   @override
//   _ProfileScreenState createState() => _ProfileScreenState();
// }

// class _ProfileScreenState extends State<ProfileScreen> {
//   final TextEditingController _nameController = TextEditingController();
//   final TextEditingController _emailController = TextEditingController();
//   final TextEditingController _passwordController = TextEditingController();
//   final ApiService _apiService = ApiService();

//   @override
//   void initState() {
//     super.initState();
//     _loadUserData();
//   }

//   void _loadUserData() async {
//     final response = await _apiService.me();
//     if (response.statusCode == 200) {
//       final responseData = json.decode(response.body);
//       setState(() {
//         _nameController.text = responseData['name'];
//         // _emailController.text = responseData['email'];
//       });
//     } else {
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(content: Text('Failed to load user data')),
//       );
//     }
//   }

//   void _updateProfile() async {
//     final response = await _apiService.updateProfile(
//       _nameController.text,
//       _emailController.text,
//       _passwordController.text.isNotEmpty ? _passwordController.text : null,
//     );

//     if (response.statusCode == 200) {
//       final responseData = json.decode(response.body);
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(content: Text(responseData['message'])),
//       );
//     } else {
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(content: Text('Update profile failed')),
//       );
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text('Update Profile')),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           children: [
//             TextFormField(
//               controller: _nameController,
//               decoration: InputDecoration(labelText: 'Name'),
//             ),
//             TextFormField(
//               controller: _emailController,
//               decoration: InputDecoration(labelText: 'Email'),
//             ),
//             // TextFormField(
//             //   controller: _passwordController,
//             //   decoration: InputDecoration(labelText: 'Password'),
//             //   obscureText: true,
//             // ),
//             ElevatedButton(
//               onPressed: _updateProfile,
//               child: Text('Update Profile'),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
