import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:task_manager/screens/login_screen.dart';
import '../models/user.dart';
import '../services/database_helper.dart';

class ProfilePage extends StatelessWidget {
  final User user;

  ProfilePage({required this.user});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircleAvatar(
              radius: 50,
              backgroundImage: NetworkImage(user.image),
            ),
            SizedBox(height: 20),
            Text(
              'Username: ${user.username}',
              style: TextStyle(fontSize: 18),
            ),
            Text(
              'Email: ${user.email}',
              style: TextStyle(fontSize: 18),
            ),
            Text(
              'First Name: ${user.firstName}',
              style: TextStyle(fontSize: 18),
            ),
            Text(
              'Last Name: ${user.lastName}',
              style: TextStyle(fontSize: 18),
            ),
            Text(
              'Gender: ${user.gender}',
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                await DatabaseHelper().deleteUser();
                final prefs = await SharedPreferences.getInstance();
                await prefs.setBool('isLoggedIn', false);
                Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => LoginScreen(),));
              },
              child: Text('Logout'),
            ),
          ],
        ),
      ),
    );
  }
}
