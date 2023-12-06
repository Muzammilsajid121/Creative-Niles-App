import 'package:creative_teenpatti/UI/change_screen.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Teen patti master',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,

        textTheme: TextTheme(
          bodyMedium: GoogleFonts.lato(
              fontSize: 18, color: Colors.white, fontWeight: FontWeight.w600),
        ),
        appBarTheme:const AppBarTheme(color: Colors.purpleAccent,),
        scaffoldBackgroundColor: Colors.purple
      ),
      home: const ChangeScreen(),
    );
  }
}
