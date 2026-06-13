import 'package:flutter/material.dart';
import 'pages/auth_page.dart';

void main() {
  runApp(const ElfyApp());
}

class ElfyApp extends StatelessWidget {
  const ElfyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Elfy Costura',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        scaffoldBackgroundColor: const Color(0xFFFAF8F5),
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.white,
          foregroundColor: Colors.black,
          elevation: 0,
        ),
      ),
      home: const AuthFormPage(),
    );
  }
}