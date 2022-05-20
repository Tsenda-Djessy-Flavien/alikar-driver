import 'package:alikardriver/View/DriverLogin/driverloginpage.dart';
import 'package:alikardriver/View/DriverRegister/driverregisterpage.dart';
import 'package:alikardriver/uses/componetes/obnboardingcomponts/widgetonboarding.dart';
import 'package:alikardriver/uses/componetes/registerlogincompontes/widgetregisterlogin.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'onboardingmodel.dart';


class OnBoarding extends StatefulWidget {
  const OnBoarding({Key? key}) : super(key: key);

  @override
  _OnBoardingState createState() => _OnBoardingState();
}

class _OnBoardingState extends State<OnBoarding> {
  //LocalizationController localizationController = Get.find();

@override
  Widget build(BuildContext context)
  {
    return Scaffold(

        body: Container(
          decoration:  const BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Color(0xff9addfa),
                    Color(0xff98dcfa),
                    Color(0xff72cff9),
                    Color(0xff03A9F4),
                  ]
              )),
          child: SafeArea(
            child: Column(
              //crossAxisAlignment: CrossAxisAlignment.center,
            //  mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(height: 7),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Column(children: [
                      Expanded(
                        child: PageView.builder(
                            onPageChanged: (index) {
                              setState(() => currentPage = index);
                              if (index == boarding.length - 1) {
                                isLastOnBoarding = true;
                              } else {
                                isLastOnBoarding = false;
                              }
                            },
                            itemBuilder: (context, index) =>
                                buildBoardingItem(context: context,model: boarding[index],index: index),
                            itemCount: boarding.length,
                            physics: const BouncingScrollPhysics(),
                            controller: boarderController),
                      ),
                    ]),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 51,vertical:70),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Expanded(
                        child:XButtonWelcome(
                            textColor: const Color(0xff6283b9),
                            functionPressing: ()
                            {
                            //  storage.write("welcome", true);
                              Navigator.of(context).push(MaterialPageRoute(builder: (context)=>RegisterScreen()));
                            },
                            textButton: "Register".tr,
                            styleButton: registerButtonStyleWelcome),
                      ),
                      const SizedBox(
                          width: 40
                      ),
                      Expanded(
                        child: XButtonWelcome(
                           textColor:  const Color(0xff1a2378),
                            functionPressing: ()
                            {
                             // storage.write("welcome", true);
                             Navigator.of(context).push(MaterialPageRoute(builder: (context)=>LoginScreen()));
                            },
                            textButton: 'Login'.tr,
                            styleButton: loginButtonStyleWelcome),
                      ),
                    ],
                  ),
                ),

              ],
            ),
          ),
        ));
  }
}


