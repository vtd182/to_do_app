enum OnboardingPagePosition {
  page1,
  page2,
  page3,
}

extension OnboardingPagePositionExtension on OnboardingPagePosition {
  String onboardingPageImage() {
    switch (this) {
      case OnboardingPagePosition.page1:
        return 'assets/images/icon_onboarding_1.png';
      case OnboardingPagePosition.page2:
        return 'assets/images/icon_onboarding_2.png';
      case OnboardingPagePosition.page3:
        return 'assets/images/icon_onboarding_3.png';
    }
  }

  String onboardingPageTitle() {
    switch (this) {
      case OnboardingPagePosition.page1:
        return 'Welcome to UpToDo';
      case OnboardingPagePosition.page2:
        return 'Organize your tasks';
      case OnboardingPagePosition.page3:
        return 'Get things done';
    }
  }

  String onboardingPageDescription() {
    switch (this) {
      case OnboardingPagePosition.page1:
        return 'UpToDo helps you to organize your tasks and get things done.';
      case OnboardingPagePosition.page2:
        return 'Create tasks, set deadlines, and track your progress.';
      case OnboardingPagePosition.page3:
        return 'Focus on what matters and get things done.';
    }
  }
}
