import 'package:flutter/widgets.dart';
import 'package:nafakaty_app/ui/login_screen.dart';
import 'package:nafakaty_app/ui/welcome_screen.dart';

final Map<String, WidgetBuilder> routesMap = {
  WelcomeScreen.routeName: (context) => const WelcomeScreen(),
  LoginScreen.routeName: (context) => const LoginScreen()
};
