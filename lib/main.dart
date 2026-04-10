import 'package:flutter/material.dart';
import 'home_page.dart';

void main() {
  runApp(const WorkHoursApp());
}

class WorkHoursApp extends StatelessWidget {
  const WorkHoursApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Work Hours Parser',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF2563EB),
        ),
        useMaterial3: true,
        fontFamily: 'Roboto',
      ),
      home: const HomePage(),
    );
  }
}
