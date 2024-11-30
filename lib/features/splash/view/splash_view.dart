import 'package:flutter/material.dart';

class SplashView extends StatelessWidget {
  const SplashView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF1c144a),
      body: Center(child: Image.asset('assets/images/logo.jpg')),
    );
  }
}
