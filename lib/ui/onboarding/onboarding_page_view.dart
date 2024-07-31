// Parent class for navigation between onboarding pages
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:to_do_app/ui/welcome/welcome_page.dart';

import '../../utils/enums/onboarding_page_position.dart';
import 'onboarding_child_page.dart';

class OnboardingPageView extends StatefulWidget {
  const OnboardingPageView({super.key});
  static const route = '/onboarding_page_view';

  @override
  State<OnboardingPageView> createState() => _OnboardingPageViewState();
}

class _OnboardingPageViewState extends State<OnboardingPageView> {
  // to control the page view, we need to create a PageController
  final PageController _pageController = PageController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: PageView(
        controller: _pageController,
        // remove swipe gesture
        physics: const NeverScrollableScrollPhysics(),
        // we will use call back function to change the page
        // when the user press the button
        children: [
          // Like view pager in Android
          // child pages
          OnboardingChildPage(
            onboardingPagePosition: OnboardingPagePosition.page1,
            onSkipPressed: () {
              _onSkipPressed();
            },
            onNextPressed: () {
              _pageController.jumpToPage(1);
            },
            onPreviousPressed: () {
              print('Previous');
            },
          ),
          OnboardingChildPage(
            onboardingPagePosition: OnboardingPagePosition.page2,
            onSkipPressed: () {
              _onSkipPressed();
            },
            onNextPressed: () {
              _pageController.jumpToPage(2);
            },
            onPreviousPressed: () {
              _pageController.jumpToPage(0);
            },
          ),
          OnboardingChildPage(
            onboardingPagePosition: OnboardingPagePosition.page3,
            onSkipPressed: () {
              _onSkipPressed();
            },
            onNextPressed: () {
              _makeOnboardingFinished();
              Navigator.of(context).pushNamed(WelcomePage.route, arguments: true);
            },
            onPreviousPressed: () {
              _pageController.jumpToPage(1);
            },
          ),
        ],
      ),
    );
  }

  Future<void> _makeOnboardingFinished() async {
    try {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setBool('key_onboarding_finished', true);
    } catch (e) {
      print(e);
      return;
    }
  }

  void _onSkipPressed() {
    print('Skip');
    _makeOnboardingFinished();
    Navigator.of(context).pushNamed(WelcomePage.route, arguments: true);
  }
}
