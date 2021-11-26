// import 'package:bottom_navy_bar/bottom_navy_bar.dart';
import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';
import 'package:movies_app/Screens/home.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  MyApp({Key? key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      themeMode: ThemeMode.dark,
      darkTheme:
          ThemeData(primarySwatch: Colors.teal, brightness: Brightness.dark),
      title: "Movie App",
      home: const Home(),
      routes: {
        "/home":(context)=> const Home()
      },
    );
  }
}
