import 'dart:async';

import 'package:fluter_final_project/login.dart';
import 'package:fluter_final_project/signup.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class Welcome extends StatefulWidget {
  const Welcome({super.key});

  @override
  State<Welcome> createState() => _WelcomeState();
}
class _WelcomeState extends State<Welcome> {
  late Timer time;

  @override
  void initState() {
    super.initState();
    startTimer();
  }

  void startTimer() {
    time = Timer(  Duration(seconds: 8), navigateToSignUp);
  }

  void navigateToSignUp() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const login()),
    );
  }

  @override
  void dispose() {
    time.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          const SizedBox(height: 100),
          Text(
            "Welcome to Lottie",
            style: TextStyle(
              fontSize: 45,
              fontWeight: FontWeight.bold,
              color: Colors.purple,
              shadows: [
                Shadow(
                  blurRadius: 5.0,
                  color: Colors.black.withOpacity(0.3),
                  offset: const Offset(4.0, 4.0),
                ),
              ],
            ),
          ),
          const SizedBox(height: 50),
          Lottie.network(
            "https://lottie.host/425d7d3a-618a-4bf6-a059-8c078e22ce0b/At0L2hWX8n.json",
          ),
        ],
      ),
    );
  }
}
