import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:to_do_app/routes.dart';
import 'package:to_do_app/ui/splash/splash.dart';

void main() async {
  // init easy localization
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  runApp(EasyLocalization(
    supportedLocales: const [Locale('en'), Locale('vi')],
    path: 'assets/translations',
    fallbackLocale: const Locale('en'),
    child: const MyApp(),
  ));
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
      localizationsDelegates: context.localizationDelegates,
      locale: context.locale,
      supportedLocales: context.supportedLocales,
      routes: routes,
      home: const SplashScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}
