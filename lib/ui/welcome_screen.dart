import 'package:flutter/material.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:nafakaty_app/ui/login_screen.dart';
import 'package:nafakaty_app/ui/utils/ui_helpers.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({Key? key}) : super(key: key);

  static const routeName = '/welcome';

  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  @override
  void initState() {
    super.initState();
  }

  void _onIntroEnd(context) {
    Navigator.of(context).pushReplacementNamed(LoginScreen.routeName);
  }

  Widget _buildImage(String assetName, double width, double height) {
    return Image.asset('assets/img/$assetName', width: width, height: height);
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return IntroductionScreen(
        pages: [
          PageViewModel(
              title: 'اهلا بك',
              body: 'يقدم لك تطبيق نفقات طريقة سهله لادارة اموالك ',
              image: _buildImage(
                  'logo.png',
                  (SizeConfig.blockSizeHorizontal! * 80),
                  (SizeConfig.safeBlockVertical! * 40))),
          PageViewModel(
              title: 'تتبع اموالك',
              body:
                  'نفقات يمكنك أن تتبع ما تنفق من اموال و كذالك مدخولك الشخصي ',
              image: _buildImage(
                  'logo.png',
                  (SizeConfig.blockSizeHorizontal! * 80),
                  (SizeConfig.safeBlockVertical! * 40))),
          PageViewModel(
              title: ' لنبدا العمل',
              body: 'ابدا بتتبع اموالك بكل سهولة',
              image: _buildImage(
                  'logo.png',
                  (SizeConfig.blockSizeHorizontal! * 80),
                  (SizeConfig.safeBlockVertical! * 40)),
              footer: ElevatedButton(
                child: const Text('هيا!'),
                onPressed: () => _onIntroEnd(context),
              ))
        ],
        showDoneButton: false,
        showSkipButton: true,
        skip: const Text('تخطي'),
        next: const Icon(Icons.arrow_forward),
        dotsDecorator: const DotsDecorator(
          size: Size(10.0, 10.0),
          color: Color(0xFFBDBDBD),
          activeSize: Size(22.0, 10.0),
          activeShape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(25.0)),
          ),
        ));
  }
}
