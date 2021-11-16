import 'package:flutter/material.dart';
import 'package:nafakaty_app/ui/categories_screen.dart';
import 'package:nafakaty_app/ui/utils/app_theme.dart';
import 'package:nafakaty_app/ui/welcome_screen.dart';
import 'package:nafakaty_app/utils/routes.dart';

Future main() async {
  runApp(const App());
}

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'نفقاتي',
      debugShowCheckedModeBanner: false,
      theme: defaultTheme,
      home: const Directionality(
        textDirection: TextDirection.rtl,
        child: CatagoriesScreen(),
      ), 
      routes: routesMap,
    );
  }
}
