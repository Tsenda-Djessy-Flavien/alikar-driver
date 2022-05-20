import 'package:alikardriver/Model/UserModel/TestInfoModel.dart';
import 'package:alikardriver/View/AliKarsplashSccreen/spashscreen.dart';
import 'package:alikardriver/View/DriveCompletInfo/CompletInfo.dart';
import 'package:alikardriver/View/DriverLogin/driverloginpage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:alikardriver/View/AliKarOnBoarding/onboarding.dart';
import 'package:alikardriver/View/DriverTestInfo/drivertestinfopage.dart';

void goTo(BuildContext context, Widget page) =>
    Navigator.of(context).push(MaterialPageRoute(builder: (context) => page));

void goBack(BuildContext context) => Navigator.of(context).pop();

void goBackMaybe(BuildContext context) => Navigator.of(context).maybePop();

void goToReplace(BuildContext context, Widget page) =>
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => page));

void goToCompleteInfoDrive(ctx) {
  final route = MaterialPageRoute(builder: (ctx) => CompleteInfoDrive());
  Navigator.push(ctx, route);
}

// back button
// void goToLoginScreen(context) {
//   final route = MaterialPageRoute(builder: (context) => LoginScreen());
//   Navigator.push(context, route);
// }

// void goToOnBoarding(context) {
//   final route = MaterialPageRoute(builder: (context) => const OnBoarding());
//   Navigator.push(context, route);
// }

// void goToTestInfoPage(context) {
//   final route = MaterialPageRoute(builder: (context) => const TestInfoPage());
//   Navigator.push(context, route);
// }
