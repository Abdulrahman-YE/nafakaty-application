import 'package:flutter/material.dart';
import 'package:nafakaty_app/ui/utils/ui_helpers.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  static const String routeName = '/login';

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  String? _email;
  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();
  String? _password;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('تسجيل الدخول'),
        centerTitle: true,
      ),
      body: Directionality(
        textDirection: TextDirection.rtl,
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(28.0),
            child: SingleChildScrollView(
              child: Card(
                child: Form(
                  child: Padding(
                    padding: const EdgeInsets.all(28.0),
                    child: Column(
                      children: [
                        TextFormField(
                          decoration: InputDecoration(
                            label: const Text('البريد الالكتروني'),
                          ),
                        ),
                        SizeConfig.verticalSpaceMedium,
                        TextFormField(
                          decoration: InputDecoration(label: Text('كلمة المرور')),
                        ),
                        SizeConfig.verticalSpaceMedium,
                        ElevatedButton(
                            onPressed: () => {}, child: Text('تسجيل الدخول'))
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
