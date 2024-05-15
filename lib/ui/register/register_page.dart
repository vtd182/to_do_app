import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import '../login/login_page.dart';

class RegisterPage extends StatefulWidget {
  static const route = '/register_page';
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
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
              _buildFormRegister(),
              const SizedBox(height: 30),
              _buildFormPassword(),
              const SizedBox(height: 30),
              _buildFormConfirmPassword(),
              _buildRegisterButton(),
              _buildOrSplitDivider(),
              _buildRegisterWithGoogleButton(),
              _buildRegisterWithAppleButton(),
              const SizedBox(height: 20),
              _buildHaveAnAccount(),
              const SizedBox(height: 30),
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
        'REGISTER',
        style: TextStyle(
          color: Colors.white,
          fontSize: 40,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget _buildFormRegister() {
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

  Widget _buildFormConfirmPassword() {
    return Form(
      child: Column(
        children: [
          Container(
            alignment: Alignment.centerLeft,
            child: const Text(
              'Confirm Password',
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
                hintText: 'Confirm password',
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

  Widget _buildRegisterButton() {
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
            'Create Account',
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

  Widget _buildRegisterWithGoogleButton() {
    return Container(
        margin: const EdgeInsets.only(top: 20),
        height: 48,
        width: double.infinity,
        child: ElevatedButton(
          onPressed: () {
            print('Register with Google');
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
            'Register with Google',
            style: TextStyle(color: Colors.white),
          ),
        ));
  }

  Widget _buildRegisterWithAppleButton() {
    return Container(
        margin: const EdgeInsets.only(top: 20),
        height: 48,
        width: double.infinity,
        child: ElevatedButton(
          onPressed: () {
            print('Register with Apple');
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
            'Register with Apple',
            style: TextStyle(color: Colors.white),
          ),
        ));
  }

  Widget _buildHaveAnAccount() {
    return RichText(
        text: TextSpan(
      text: 'Already have an account? ',
      style: TextStyle(
        color: Colors.white.withOpacity(0.5),
      ),
      children: [
        TextSpan(
          text: 'Login',
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
          recognizer: TapGestureRecognizer()
            ..onTap = () {
              Navigator.of(context).pushNamed(LoginPage.route);
            },
        ),
      ],
    ));
  }
}
