import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart'; // Import SharedPreferences
import 'package:task_manager/screens/navigation_bar.dart';
import 'blocs/task/task_bloc.dart';
import 'repositories/task_repository.dart';
import 'screens/login_screen.dart';
import 'screens/task_list_screen.dart';
import 'screens/add_edit_task_screen.dart';
import 'services/auth_service.dart';
import 'theme.dart';

void main() {
  runApp(TaskManagerApp());
}

class TaskManagerApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<AuthService>(create: (_) => AuthService()),
        Provider<TaskRepository>(create: (_) => TaskRepository()),
      ],
      child: BlocProvider(
        create: (context) => TaskBloc(context.read<TaskRepository>()),
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Task Manager',
          theme: appTheme,
          home: FutureBuilder<bool>(
            future: _checkLoginStatus(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                final bool isLoggedIn = snapshot.data ?? false;
                return isLoggedIn ? NavigationBarView() : LoginScreen();
              } else {
                return Scaffold(
                  body: Center(child: CircularProgressIndicator()),
                );
              }
            },
          ),
        ),
      ),
    );
  }

  // Function to check login status using SharedPreferences
  Future<bool> _checkLoginStatus() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool('isLoggedIn') ?? false;
  }
}