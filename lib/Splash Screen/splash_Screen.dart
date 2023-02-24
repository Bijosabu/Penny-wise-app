import 'package:flutter/material.dart';
import 'package:moneysaver/home/home_Screen.dart';
import 'package:lottie/lottie.dart';

class AnimatedSplashScreen extends StatefulWidget {
  const AnimatedSplashScreen({super.key});

  @override
  State<AnimatedSplashScreen> createState() => _AnimatedSplashScreenState();
}

class _AnimatedSplashScreenState extends State<AnimatedSplashScreen> {
  @override
  void initState() {
    Future.delayed(
      Duration(seconds: 4),
      () {
        Navigator.of(context).pushReplacement(MaterialPageRoute(
          builder: (context) {
            return HomeScreen();
          },
        ));
      },
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Lottie.asset(
            'assets/lottie/moneybag.json',
          ),
          const SizedBox(height: 16),
          // ignore: prefer_const_constructors
          Text(
            'Penny Wise',
            style: TextStyle(
              color: const Color(0xFF545AA2),
              fontSize: 26,
              fontFamily: 'Roboto',
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    ));
  }
}
