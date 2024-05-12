import 'package:flutter/material.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: _buildBodyPage(),
    );
  }
}

Widget _buildBodyPage() {
  return SafeArea(
    child: Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          _buildIconPlash(),
          _buildTextSplash(),
        ],
      ),
    ),
  );
}

Widget _buildIconPlash() {
  return const Image(
    image: AssetImage('assets/images/ic_splash.png'),
    fit: BoxFit.contain,
    width: 120,
    height: 120,
  );
}

Widget _buildTextSplash() {
  return Container(
    margin: const EdgeInsets.only(top: 10),
    child: const Text(
      'UpToDo',
      style: TextStyle(
        color: Colors.white,
        fontSize: 40,
        fontWeight: FontWeight.bold,
      ),
    ),
  );
}
