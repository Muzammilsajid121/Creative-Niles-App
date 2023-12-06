import 'dart:async';
import 'package:creative_teenpatti/UI/home.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';


class ChangeScreen extends StatefulWidget {
  const ChangeScreen({super.key});

  @override
  State<ChangeScreen> createState() => _SplashState();
}

class _SplashState extends State<ChangeScreen> {
  @override
  void initState() {
    super.initState();
    startTimer();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      
      body: Padding(
        padding: const EdgeInsets.all(14.0),
        child: SizedBox(
          width: double.infinity,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
            const   Text(
                "Teen patti master",
                style: TextStyle(color: Colors.white, fontSize: 35,),
              ),
              LottieBuilder.asset(
                "images/cards.json",
                height: 100,
              ),
            ],
          ),
        ),
      ),
    );
  }


    void startTimer() async {
    Timer(const Duration(seconds: 3), () {
      navigateToWebAppScreen();
    });
  }

  void navigateToWebAppScreen() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
          builder: (context) => HomeScreen(
                onLoad: () {},
              )),
    );
  }

}