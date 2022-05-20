import 'dart:async';
import 'package:alikardriver/View/AliKarOnBoarding/onboarding.dart';
import 'package:alikardriver/uses/cte.dart';
import 'package:flutter/material.dart';



class SplashScreen extends StatefulWidget{
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {


  @override
  void initState()
  {
    super.initState();
    startTime();
  }

  startTime() async
  {
    var duration = const Duration(seconds: 4);
    return Timer(duration, startNextScreen);
  }

  startNextScreen()
  {
    Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context)=> const OnBoarding()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF03A9F4),
      body: SafeArea(
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const SizedBox(height: 20,),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 50.0),
                      child: Image.asset(aliKarLogo,height: 114,width: 90,),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 50,)
            ],
          ),
        ),
      ),
    );
  }
}