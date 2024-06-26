import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:to_do_app/ui/register/register_page.dart';

import '../login/login_page.dart';

class WelcomePage extends StatelessWidget {
  static const route = '/welcome_page';
  final bool isFirstTime;
  const WelcomePage({super.key, this.isFirstTime = false});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
          automaticallyImplyLeading: false, // add this line
          backgroundColor: Colors.black,
          leading: !isFirstTime
              ? null
              : IconButton(
                  onPressed: () {
                    if (Navigator.canPop(context)) {
                      Navigator.pop(context);
                    }
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
                    _buildLoginButton(context),
                    _buildRegisterButton(context),
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
    return Text(
      "welcome_title".tr(),
      textAlign: TextAlign.center,
      style: const TextStyle(
        color: Colors.white,
        fontSize: 32,
        fontWeight: FontWeight.bold,
      ),
    );
  }

  Widget _buildTextDescription() {
    return Container(
      margin: const EdgeInsets.only(top: 25, left: 20, right: 20),
      child: Text(
        "welcome_description".tr(),
        textAlign: TextAlign.center,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 16,
        ),
      ),
    );
  }

  Widget _buildLoginButton(BuildContext context) {
    return Container(
        margin: const EdgeInsets.only(left: 20, right: 20, bottom: 10),
        height: 48,
        width: double.infinity,
        child: ElevatedButton(
          onPressed: () {
            Navigator.of(context).pushNamed(LoginPage.route);
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

  Widget _buildRegisterButton(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(left: 20, right: 20, bottom: 20),
      height: 48,
      width: double.infinity,
      child: ElevatedButton(
        onPressed: () {
          Navigator.of(context).pushNamed(RegisterPage.route);
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

  Widget _buildChangeLanguageButton(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(left: 20, right: 20, bottom: 20),
      height: 48,
      width: double.infinity,
      child: ElevatedButton(
        onPressed: () {
          FirebaseAuth.instance.signOut();
          // change language
          final currentLocale = context.locale;
          if (currentLocale == const Locale('en')) {
            context.setLocale(const Locale('vi'));
          } else {
            context.setLocale(const Locale('en'));
          }
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
          'Change language',
          style: TextStyle(color: Colors.white),
        ),
      ),
    );
  }
}
