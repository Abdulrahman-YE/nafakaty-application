import 'package:flutter/material.dart';
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
      theme: ThemeData(
        brightness: Brightness.light,
        primarySwatch: Colors.blue,
      ),
      home: const Directionality(
        textDirection: TextDirection.rtl,
        child: WelcomeScreen(),
      ),
      routes: routesMap,
    );
  }
}
