import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:novaya/home_page.dart';
void main(List<String> args) {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: !kReleaseMode,
      home: CameraPage(),
    );
  }
}