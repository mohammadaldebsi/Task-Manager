import 'package:flutter/material.dart';
import 'package:task_manager/screens/profile.dart';
import 'package:task_manager/screens/task_list_screen.dart';
import '../models/user.dart';

import '../services/database_helper.dart'; // Import DatabaseHelper

class NavigationBarView extends StatefulWidget {
  @override
  _NavigationBarState createState() => _NavigationBarState();
}

class _NavigationBarState extends State<NavigationBarView> {
  int _selectedIndex = 0;
  late User _user;

  @override
  void initState() {
    super.initState();
    _loadUser();
  }

  void _loadUser() async {
    DatabaseHelper databaseHelper = DatabaseHelper();
    User? user = await databaseHelper.getUserFromLocalDatabase();
    if (user != null) {
      setState(() {
        _user = user;
      });
    }
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> _widgetOptions = <Widget>[
      TaskListScreen(user: _user,),
 ProfilePage(user: _user) 
    ];

    return Scaffold(
      body: _widgetOptions.elementAt(_selectedIndex),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.assignment),
            label: 'Tasks',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
    );
  }
}
