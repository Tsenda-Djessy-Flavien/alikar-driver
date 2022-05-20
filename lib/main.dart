import 'package:alikardriver/Controller/AppController/clienttracking.dart';
import 'package:alikardriver/Controller/AppController/trackingController.dart';
import 'package:alikardriver/Data/Networking/help.dart';
import 'package:alikardriver/uses/cte.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'Controller/AppController/appcontroller.dart';
import 'View/AliKarsplashSccreen/spashscreen.dart';



void main() async
{

  WidgetsFlutterBinding.ensureInitialized();
  await GetStorage.init();
  await DioHelper.init();
  storage.remove("token");
  if (storage.read("OnboardingValue") == null) storage.write("OnboardingValue", false);

  if (storage.read("token") == null) storage.write("token", "token");


  onBoardingValue = storage.read("OnboardingValue");
  token = storage.read("token");


  runApp( MyApp());
}

class MyApp extends StatelessWidget
{
   MyApp({Key? key}) : super(key: key);
  final appController = Get.put(AppController());
  final trackingController = Get.put(TrackingController());

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'AliKar Driver',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        fontFamily: "OpenSans"
      ),
      home:  SplashScreen() ,
    );
  }
}

//TrackingPage