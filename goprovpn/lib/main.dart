import 'package:flutter/material.dart';
import 'pages/login.dart';
import 'pages/home.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        scaffoldBackgroundColor: const Color.fromARGB(
            255, 243, 234, 244), // Это задаст фоновый цвет для всех экранов
      ),
      debugShowCheckedModeBanner: false,
      routes: {
        'HomePage': (context) => HomePage(),
      },
      home: LoginPage(),
    );
  }
}
