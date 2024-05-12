import 'package:flutter/material.dart';

class WelcomePage extends StatelessWidget {
  static const route = '/welcome_page';
  const WelcomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
          backgroundColor: Colors.black,
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(
              Icons.arrow_back,
              color: Colors.white,
            ),
          ),
        ),
        body: Column(
          children: [
            _buildTextAndDescription(),
            Expanded(
              child: Align(
                alignment: Alignment.bottomCenter,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    _buildLoginButton(),
                    _buildRegisterButton(),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTextAndDescription() {
    return Container(
      margin: const EdgeInsets.only(top: 50),
      child: Column(
        children: [
          _buildTextWelcome(),
          _buildTextDescription(),
        ],
      ),
    );
  }

  Widget _buildTextWelcome() {
    return const Text(
      'Welcome to UpToDo',
      style: TextStyle(
        color: Colors.white,
        fontSize: 32,
        fontWeight: FontWeight.bold,
      ),
    );
  }

  Widget _buildTextDescription() {
    return Container(
      margin: const EdgeInsets.only(top: 10),
      child: const Text(
        'The best place to manage your daily tasks',
        style: TextStyle(
          color: Colors.white,
          fontSize: 16,
        ),
      ),
    );
  }

  Widget _buildLoginButton() {
    return Container(
        margin: const EdgeInsets.only(left: 20, right: 20, bottom: 10),
        height: 48,
        width: double.infinity,
        child: ElevatedButton(
          onPressed: () {
            print('Login');
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.deepPurple,
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(4)),
            ),
          ),
          child: const Text(
            'LOGIN',
            style: TextStyle(color: Colors.white),
          ),
        ));
  }

  Widget _buildRegisterButton() {
    return Container(
      margin: const EdgeInsets.only(left: 20, right: 20, bottom: 20),
      height: 48,
      width: double.infinity,
      child: ElevatedButton(
        onPressed: () {
          print('Register');
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.transparent,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(4)),
            side: BorderSide(
              color: Colors.deepPurple,
              width: 1,
            ),
          ),
        ),
        child: const Text(
          'CREATE ACCOUNT',
          style: TextStyle(color: Colors.white),
        ),
      ),
    );
  }
}
