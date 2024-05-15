import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import '../register/register_page.dart';

class LoginPage extends StatefulWidget {
  static const route = '/login_page';
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
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
      body: SingleChildScrollView(
        child: Container(
          margin: const EdgeInsets.all(20),
          child: Column(
            children: [
              _buildTextTitle(),
              _buildFormLogin(),
              const SizedBox(height: 30),
              _buildFormPassword(),
              _buildLoginButton(),
              _buildOrSplitDivider(),
              _buildLoginWithGoogleButton(),
              _buildLoginWithAppleButton(),
              const SizedBox(height: 20),
              _buildDontHaveAccount(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextTitle() {
    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      alignment: Alignment.centerLeft,
      child: const Text(
        'LOGIN',
        style: TextStyle(
          color: Colors.white,
          fontSize: 40,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget _buildFormLogin() {
    return Form(
      child: Column(
        children: [
          Container(
            alignment: Alignment.centerLeft,
            child: const Text(
              'Username',
              style: TextStyle(
                color: Colors.white,
                fontSize: 16,
              ),
            ),
          ),
          Container(
            margin: const EdgeInsets.only(top: 10),
            child: TextFormField(
              style: const TextStyle(
                color: Colors.white,
              ),
              decoration: InputDecoration(
                hintText: 'Enter your password',
                hintStyle: TextStyle(
                  color: Colors.white.withOpacity(0.5),
                  fontSize: 16,
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(5),
                ),
                fillColor: Colors.grey.withOpacity(0.2),
                filled: true,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFormPassword() {
    return Form(
      child: Column(
        children: [
          Container(
            alignment: Alignment.centerLeft,
            child: const Text(
              'Password',
              style: TextStyle(
                color: Colors.white,
                fontSize: 16,
              ),
            ),
          ),
          Container(
            margin: const EdgeInsets.only(top: 10),
            child: TextFormField(
              obscureText: true,
              style: const TextStyle(
                color: Colors.white,
              ),
              decoration: InputDecoration(
                hintText: 'Enter your username',
                hintStyle: TextStyle(
                  color: Colors.white.withOpacity(0.5),
                  fontSize: 16,
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(5),
                ),
                fillColor: Colors.grey.withOpacity(0.2),
                filled: true,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLoginButton() {
    return Container(
        margin: const EdgeInsets.only(top: 50),
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
            'Login',
            style: TextStyle(color: Colors.white),
          ),
        ));
  }

  Widget _buildOrSplitDivider() {
    return Container(
      margin: const EdgeInsets.only(top: 20),
      child: Row(
        children: [
          Expanded(
            child: Container(
              margin: const EdgeInsets.only(right: 10),
              color: Colors.white.withOpacity(0.5),
              height: 1,
            ),
          ),
          Text(
            'OR',
            style: TextStyle(
              color: Colors.white.withOpacity(0.5),
            ),
          ),
          Expanded(
            child: Container(
              margin: const EdgeInsets.only(left: 10),
              color: Colors.white.withOpacity(0.5),
              height: 1,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLoginWithGoogleButton() {
    return Container(
        margin: const EdgeInsets.only(top: 20),
        height: 48,
        width: double.infinity,
        child: ElevatedButton(
          onPressed: () {
            print('Login with Google');
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
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                'assets/images/ic_google.png',
                width: 24,
                height: 24,
              ),
              const SizedBox(width: 10),
              const Text(
                'Login with Google',
                style: TextStyle(color: Colors.white),
              ),
            ],
          ),
        ));
  }

  Widget _buildLoginWithAppleButton() {
    return Container(
      margin: const EdgeInsets.only(top: 20),
      height: 48,
      width: double.infinity,
      child: ElevatedButton(
        onPressed: () {
          print('Login with Apple');
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
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/images/ic_apple.png',
              width: 24,
              height: 24,
            ),
            const SizedBox(width: 10),
            const Text(
              'Login with Apple',
              style: TextStyle(color: Colors.white),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDontHaveAccount() {
    return RichText(
        text: TextSpan(
      text: 'Don\'t have an account? ',
      style: TextStyle(
        color: Colors.white.withOpacity(0.5),
      ),
      children: [
        TextSpan(
          text: 'Register',
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
          recognizer: TapGestureRecognizer()
            ..onTap = () {
              Navigator.of(context).pushNamed(RegisterPage.route);
            },
        ),
      ],
    ));
  }
}
