import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:to_do_app/app/language_cubit.dart';
import 'package:to_do_app/domain/authentication_repository/authentication_repository.dart';
import 'package:to_do_app/domain/data_source/firebase_auth_service.dart';
import 'package:to_do_app/domain/data_source/firebase_service.dart';
import 'package:to_do_app/routes.dart';
import 'package:to_do_app/ui/home/bloc/home_page_cubit.dart';
import 'package:to_do_app/ui/main/main_page.dart';
import 'package:to_do_app/ui/splash/splash.dart';
import 'package:to_do_app/ui/welcome/welcome_page.dart';
import 'package:to_do_app/utils/enums/authentication_status.dart';

import 'app/app_cubit.dart';
import 'constants/constants.dart';
import 'domain/data_source/firebase_user_service.dart';

void main() async {
  // init easy localization
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  await Firebase.initializeApp();

  runApp(EasyLocalization(
    supportedLocales: const [Locale('en'), Locale('vi')],
    path: 'assets/translations',
    fallbackLocale: const Locale('en'),
    child: const App(),
  ));
}

class App extends StatefulWidget {
  const App({super.key});

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  late final AuthenticationRepository authenticationRepository;
  late final FirebaseAuthService firebaseAuthService;
  late final FirebaseService firebaseService;
  late final FirebaseUserService firebaseUserService;

  @override
  void initState() {
    super.initState();
    firebaseAuthService = FirebaseAuthService();
    authenticationRepository = AuthenticationRepositoryImpl(
      firebaseAuthService: firebaseAuthService,
    );
    firebaseService = FirebaseService();
    firebaseUserService = FirebaseUserService();
  }

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider<AuthenticationRepository>(
          create: (context) => authenticationRepository,
        ),
        RepositoryProvider<FirebaseService>(
          create: (context) => firebaseService,
        ),
        RepositoryProvider<FirebaseUserService>(
          create: (context) => firebaseUserService,
        ),
        RepositoryProvider<HomePageCubit>(
          create: (context) {
            return HomePageCubit(
              firebaseService: firebaseService,
            );
          },
        ),
        RepositoryProvider<LanguageCubit>(
          create: (context) {
            return LanguageCubit();
          },
        ),
      ],
      child: BlocProvider(
        create: (BuildContext context) {
          return AppCubit(
            authenticationRepository: authenticationRepository,
          );
        },
        child: const MyApp(),
      ),
    );
  }
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final _navigatorKey = GlobalKey<NavigatorState>();
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'My To-Do App',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Color(Constants.primaryColor)),
        useMaterial3: true,
        fontFamily: 'Lato',
      ),
      navigatorKey: _navigatorKey,
      localizationsDelegates: context.localizationDelegates,
      locale: context.locale,
      supportedLocales: context.supportedLocales,
      routes: routes,
      builder: (context, child) {
        return BlocListener<AppCubit, AppState>(
          listener: (context, state) async {
            switch (state.status) {
              case AuthenticationStatus.authenticated:
                _navigatorKey.currentState?.pushNamedAndRemoveUntil(MainPage.route, (route) => false);
                break;
              case AuthenticationStatus.unauthenticated:
                bool isOnboardingFinished = await _isOnboardingFinished();
                if (isOnboardingFinished) {
                  _navigatorKey.currentState
                      ?.pushNamedAndRemoveUntil(WelcomePage.route, (route) => false, arguments: false);
                }
                break;
              case AuthenticationStatus.unknown:
                break;
            }
          },
          child: child,
        );
      },
      onGenerateRoute: (_) => MaterialPageRoute(builder: (context) => const SplashScreen()),
      debugShowCheckedModeBanner: false,
    );
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
}
