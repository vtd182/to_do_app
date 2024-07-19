// child page of onboarding page view
// TODO: Chia man hinh theo ti le hien thi
import 'package:flutter/material.dart';
import 'package:to_do_app/utils/enums/onboarding_page_position.dart';

import '../../constants/constants.dart';

class OnboardingChildPage extends StatelessWidget {
  final OnboardingPagePosition onboardingPagePosition;
  final VoidCallback onSkipPressed;
  final VoidCallback onNextPressed;
  final VoidCallback onPreviousPressed;

  const OnboardingChildPage({
    super.key,
    required this.onboardingPagePosition,
    required this.onSkipPressed,
    required this.onNextPressed,
    required this.onPreviousPressed,
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.black,
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            _buildSkipButton(),
            _buildOnboardingImage(),
            _buildOnboardingPageControl(),
            _buildOnboardingTitleAndDescription(),
            Expanded(
              child: Align(
                alignment: Alignment.bottomCenter,
                child: _buildOnboardingNextAndPreviousButton(),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSkipButton() {
    return Container(
        alignment: Alignment.centerLeft,
        margin: const EdgeInsets.only(top: 10),
        child: TextButton(
          onPressed: () {
            onSkipPressed.call();
          },
          child: Text(
            'SKIP',
            style: TextStyle(
              fontSize: 16,
              fontFamily: 'Late',
              color: Colors.white.withOpacity(0.5),
            ),
          ),
        ));
  }

  Widget _buildOnboardingImage() {
    return Container(
      margin: const EdgeInsets.only(top: 50),
      child: Image(
        image: AssetImage(onboardingPagePosition.onboardingPageImage()),
        fit: BoxFit.contain,
        width: 300,
        height: 300,
      ),
    );
  }

  Widget _buildOnboardingPageControl() {
    double width = 20;
    double height = 3;
    return Container(
        margin: const EdgeInsets.only(top: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              margin: const EdgeInsets.only(right: 5),
              width: width,
              height: height,
              decoration: BoxDecoration(
                color: onboardingPagePosition == OnboardingPagePosition.page1
                    ? Colors.white
                    : Colors.white.withOpacity(0.5),
                shape: BoxShape.rectangle,
              ),
            ),
            Container(
              margin: const EdgeInsets.only(right: 5),
              width: width,
              height: height,
              decoration: BoxDecoration(
                color: onboardingPagePosition == OnboardingPagePosition.page2
                    ? Colors.white
                    : Colors.white.withOpacity(0.5),
                shape: BoxShape.rectangle,
              ),
            ),
            Container(
              margin: const EdgeInsets.only(right: 5),
              width: width,
              height: height,
              decoration: BoxDecoration(
                color: onboardingPagePosition == OnboardingPagePosition.page3
                    ? Colors.white
                    : Colors.white.withOpacity(0.5),
                shape: BoxShape.rectangle,
              ),
            ),
          ],
        ));
  }

  Widget _buildOnboardingTitleAndDescription() {
    return Container(
      margin: const EdgeInsets.only(top: 50),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            onboardingPagePosition.onboardingPageTitle(),
            style: const TextStyle(
              fontSize: 24,
              fontFamily: 'Late',
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
          Container(
            margin: const EdgeInsets.only(top: 10, right: 10, left: 10),
            child: Text(
              onboardingPagePosition.onboardingPageDescription(),
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 16,
                fontFamily: 'Late',
                color: Colors.white.withOpacity(0.5),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildOnboardingNextAndPreviousButton() {
    return Container(
      margin: const EdgeInsets.only(bottom: 20, left: 20, right: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          TextButton(
            onPressed: () {
              onPreviousPressed.call();
            },
            child: Text(
              'BACK',
              style: TextStyle(
                fontSize: 16,
                fontFamily: 'Late',
                color: Colors.white.withOpacity(0.5),
              ),
            ),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(2),
              ),
              backgroundColor: Color(Constants.primaryColor),
            ),
            onPressed: () {
              onNextPressed.call();
            },
            child: Text(
              onboardingPagePosition == OnboardingPagePosition.page3
                  ? 'GET STARTED'
                  : 'NEXT',
              style: TextStyle(
                fontSize: 16,
                fontFamily: 'Late',
                color: Colors.white.withOpacity(0.5),
              ),
            ),
          )
        ],
      ),
    );
  }
}
