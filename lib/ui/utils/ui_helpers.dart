import 'package:flutter/material.dart';

class SizeConfig {
  static MediaQueryData? _mediaQueryData;
  static double? screenWidth;
  static double? screenHeight;
  static double? blockSizeHorizontal;
  static double? blockSizeVertical;

  static double? _safeAreaHorizontal;
  static double? _safeAreaVertical;
  static double? safeBlockHorizontal;
  static double? safeBlockVertical;
  static Widget horizontalSpaceSmall = SizedBox(width: 10.0);
  static Widget horizontalSpaceRegular = SizedBox(width: 18.0);
  static Widget horizontalSpaceMedium = SizedBox(width: 25.0);
  static Widget horizontalSpaceLarge = SizedBox(width: 50.0);

// Vertical Spacing
  static Widget verticalSpaceTiny = SizedBox(height: 5.0);
  static Widget verticalSpaceSmall = SizedBox(height: 10.0);
  static Widget verticalSpaceRegular = SizedBox(height: 18.0);
  static Widget verticalSpaceMedium = SizedBox(height: 25);
  static Widget verticalSpaceLarge = SizedBox(height: 50.0);
  static Widget verticalSpaceMassive = SizedBox(height: 120.0);

  void init(BuildContext context) {
    _mediaQueryData = MediaQuery.of(context);
    screenWidth = _mediaQueryData!.size.width;
    screenHeight = _mediaQueryData!.size.height;
    blockSizeHorizontal = screenWidth! / 100;
    blockSizeVertical = screenHeight! / 100;

    _safeAreaHorizontal =
        _mediaQueryData!.padding.left + _mediaQueryData!.padding.right;
    _safeAreaVertical =
        _mediaQueryData!.padding.top + _mediaQueryData!.padding.bottom;
    safeBlockHorizontal = (screenWidth! - _safeAreaHorizontal!) / 100;
    safeBlockVertical = (screenHeight! - _safeAreaVertical!) / 100;

    horizontalSpaceSmall = SizedBox(
      width: blockSizeHorizontal! * 1,
    );

    horizontalSpaceMedium = SizedBox(
      width: blockSizeHorizontal! * 2,
    );
    horizontalSpaceRegular = SizedBox(
      width: blockSizeHorizontal! * 3.5,
    );
    horizontalSpaceLarge = SizedBox(
      width: blockSizeHorizontal! * 5,
    );

    verticalSpaceTiny = SizedBox(height: blockSizeVertical! * 1);
    verticalSpaceSmall = SizedBox(height: blockSizeVertical! * 2.5);
    verticalSpaceMedium = SizedBox(height: blockSizeVertical! * 4);
    verticalSpaceLarge = SizedBox(height: blockSizeVertical! * 7);
    verticalSpaceMassive = SizedBox(height: blockSizeVertical! * 10);
    debugPrint(verticalSpaceMassive.toString());
  }
}
