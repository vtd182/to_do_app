import 'package:flutter/material.dart';
import 'package:to_do_app/routes.dart';
import 'package:to_do_app/ui/onboarding/onboarding_page_view.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'My To-Do App',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      routes: routes,
      home: const OnboardingPageView(),
      debugShowCheckedModeBanner: false,
    );
  }
}
