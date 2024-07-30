import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:to_do_app/ui/welcome/welcome_page.dart';

import '../onboarding/onboarding_page_view.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  Future<void> _checkAppState(BuildContext context) async {
    // check if the key 'key_onboarding_finished' is exist
    final isOnboardingFinished = await _isOnboardingFinished();
    if (!context.mounted) return;
    if (isOnboardingFinished) {
      // if the key is exist, navigate to the main page
      redirectToWelcomePage();
    } else {
      // if the key is not exist, navigate to the onboarding page view
      redirectToOnboardingPageView();
    }
  }

  Future<bool> _isOnboardingFinished() async {
    try {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      final result = prefs.getBool('key_onboarding_finished');
      return result ?? false;
    } catch (e) {
      return false;
    }
  }

  @override
  void initState() {
    super.initState();
  }

  void redirectToOnboardingPageView() async {
    await Future.delayed(const Duration(seconds: 3));
    if (!mounted) return;
    Navigator.of(context).pushNamed(OnboardingPageView.route);
  }

  void redirectToWelcomePage() async {
    await Future.delayed(const Duration(seconds: 3));
    if (!mounted) return;
    Navigator.of(context).pushNamed(WelcomePage.route, arguments: false);
  }

  @override
  Widget build(BuildContext context) {
    _checkAppState(context);
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
      'To-Do App',
      style: TextStyle(
        color: Colors.white,
        fontSize: 40,
        fontWeight: FontWeight.bold,
      ),
    ),
  );
}
