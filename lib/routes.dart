import 'package:flutter/cupertino.dart';
import 'package:to_do_app/ui/category/create_or_edit_category.dart';
import 'package:to_do_app/ui/login/login_page.dart';
import 'package:to_do_app/ui/main/main_page.dart';
import 'package:to_do_app/ui/onboarding/onboarding_page_view.dart';
import 'package:to_do_app/ui/register/register_page.dart';
import 'package:to_do_app/ui/setting/setting_page.dart';
import 'package:to_do_app/ui/splash/splash.dart';
import 'package:to_do_app/ui/task_detail/task_detail_page.dart';
import 'package:to_do_app/ui/welcome/welcome_page.dart';

final Map<String, Widget Function(BuildContext)> routes = {
  SplashScreen.route: (context) => const SplashScreen(),
  WelcomePage.route: (context) => WelcomePage(isFirstTime: ModalRoute.of(context)!.settings.arguments as bool),
  OnboardingPageView.route: (context) => const OnboardingPageView(),
  LoginPage.route: (context) => const LoginPage(),
  RegisterPage.route: (context) => const RegisterPage(),
  MainPage.route: (context) => const MainPage(),
  SettingPage.route: (context) => const SettingPage(),
  CreateOrEditCategoryPage.route: (context) => CreateOrEditCategoryPage(
        categoryId: ModalRoute.of(context)?.settings.arguments as String?,
      ),
  TaskDetailPage.route: (context) => TaskDetailPage(
        taskId: ModalRoute.of(context)?.settings.arguments as String?,
      ),
};
