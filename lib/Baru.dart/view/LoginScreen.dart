// // lib/screens/login_screen.dart
// import 'package:flutter/material.dart';
// import 'package:jember_wisataku/Baru.dart/service/auth_service.dart';
// import 'package:jember_wisataku/Baru.dart/view/HomeScrenn.dart';

// class LoginScreen extends StatefulWidget {
//   @override
//   _LoginScreenState createState() => _LoginScreenState();
// }

// class _LoginScreenState extends State<LoginScreen> {
//   final TextEditingController _emailController = TextEditingController();
//   final TextEditingController _passwordController = TextEditingController();
//   final ApiService _apiService = ApiService();

//   void _login() async {
//     final response = await _apiService.login(
//       _emailController.text,
//       _passwordController.text,
//     );
//     if (response.statusCode == 200) {
//       // Navigator.pushReplacement(
//       //   context,
//       //   MaterialPageRoute(builder: (context) => HomeScreen()),
//       // );
//     } else {
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(content: Text('Login failed')),
//       );
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text('Login')),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           children: [
//             TextField(
//               controller: _emailController,
//               decoration: InputDecoration(labelText: 'Email'),
//             ),
//             TextField(
//               controller: _passwordController,
//               decoration: InputDecoration(labelText: 'Password'),
//               obscureText: true,
//             ),
//             ElevatedButton(
//               onPressed: _login,
//               child: Text('Login'),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }