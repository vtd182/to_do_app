import 'package:flutter/cupertino.dart';
import 'package:to_do_app/ui/onboarding/onboarding_page_view.dart';
import 'package:to_do_app/ui/welcome/welcome_page.dart';

final Map<String, WidgetBuilder> routes = {
  WelcomePage.route: (context) => const WelcomePage(),
  OnboardingPageView.route: (context) => const OnboardingPageView(),
};
