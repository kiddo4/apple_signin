import 'package:apple_signin/firebase_options.dart';
import 'package:apple_signin/screens/home_screen.dart';
import 'package:apple_signin/screens/login_screen.dart';
import 'package:apple_signin/service/auth_service.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final authService = AuthService();

    return MaterialApp(
      home: StreamBuilder(
          stream: authService.authStateChanges,
          builder: (context, snapshot) {
           
            if (snapshot.connectionState == ConnectionState.active) {
              final user = snapshot.data;
              if (user == null) {
                return const LoginScreen();
              } else {
                return const HomeScreen();
              }
            } else {
              return const Scaffold(
                body: Center(
                  child: CircularProgressIndicator(),
                ),
              );
            }
          }),
    );
  }
}
