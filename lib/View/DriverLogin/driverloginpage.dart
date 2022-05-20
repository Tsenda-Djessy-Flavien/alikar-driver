import 'dart:developer';

import 'package:alikardriver/View/AliKarOnBoarding/onboarding.dart';
import 'package:alikardriver/Controller/AppController/appcontroller.dart';
import 'package:alikardriver/View/DriverRegister/driverregisterpage.dart';
import 'package:alikardriver/uses/componetes/obnboardingcomponts/widgetonboarding.dart';
import 'package:alikardriver/uses/componetes/registerlogincompontes/widgetregisterlogin.dart';
import 'package:alikardriver/uses/widgets/navigations.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({Key? key}) : super(key: key);

  bool value = false;

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AppController>(builder: (appController) {
      return Scaffold(
        body: Container(
          decoration: const BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                Color(0xff74c9ef),
                Color(0xffaaddf4),
              ])),
          child: SafeArea(
              child: Form(
            key: appController.loginFormKey,
            child: Column(
              children: [
                Image.asset(
                  'assets/logo.png',
                  height: MediaQuery.of(context).size.height / 2 - 50,
                  width: MediaQuery.of(context).size.width + 100,
                ),
                Expanded(
                  child: Container(
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(30),
                        topRight: Radius.circular(30),
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: SingleChildScrollView(
                        physics: BouncingScrollPhysics(),
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(15),
                              child: Row(
                                children: [
                                  // InkWell(
                                  //     onTap: () => goToOnBoarding(context),
                                  //     child: const Icon(Icons.arrow_back)),
                                  const SizedBox(
                                    width: 20,
                                  ),
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: const [
                                      Text(
                                        "Login",
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontFamily: "Roboto",
                                            fontWeight: FontWeight.bold,
                                            fontSize: 30),
                                      ),
                                      Text(
                                        " to your account",
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontFamily: "Roboto",
                                            fontWeight: FontWeight.bold,
                                            fontSize: 30),
                                      ),
                                    ],
                                  )
                                ],
                              ),
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 25),
                              child: Column(
                                children: [
                                  myFormField(
                                    pathImage: "assets/icons/mail.png",
                                    controller: appController.emailController,
                                    validate: (String? value) {
                                      if (value == null || value.isEmpty) {
                                        return "Empty Failed";
                                      } else {
                                        return null;
                                      }
                                    },
                                    type: TextInputType.emailAddress,
                                    suffixIcon: Icons.email_outlined,
                                    hintText: "Enter Email",
                                  ),
                                  const SizedBox(height: 20),
                                  myFormField(
                                    pathImage: "assets/icons/lock.png",
                                    suffixPressed: () {
                                      appController.changePasswordVisibility();
                                      appController.update();
                                    },
                                    onSubmit: (value) {
                                      if (appController
                                              .loginFormKey.currentState
                                              ?.validate() !=
                                          null) {
                                        appController.update();
                                      }
                                    },
                                    controller:
                                        appController.passwordController,
                                    validate: (String? value) {
                                      if (value == null || value.isEmpty) {
                                        return "Empty Failed";
                                      } else {
                                        return null;
                                      }
                                    },
                                    type: TextInputType.text,
                                    isPass: true,
                                    hintText: "Enter Password",
                                    suffixIcon: appController.suffix,
                                  ),
                                  Row(
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      TextButton(
                                          onPressed: () {
                                            Navigator.of(context).push(
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        RegisterScreen()));
                                          },
                                          child: const Text(
                                            "Mot de passe oublier ?",
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 13,
                                                fontWeight: FontWeight.bold,
                                                height: 1),
                                          )),
                                    ],
                                  ),
                                  Row(
                                    children: <Widget>[
                                      const SizedBox(
                                        width: 10,
                                      ),
                                      const SizedBox(width: 10),
                                      Checkbox(
                                        value: value,
                                        onChanged: (valur) {
                                          value = valur!;
                                          log("login");
                                          appController.update();
                                        },
                                      ),
                                      const Text(
                                        'Lorem ipsum dolor sit amet',
                                        style: TextStyle(fontSize: 17.0),
                                      ), //Text
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 35,
                                  ),
                                  appController.loadingLogin.value
                                      ? const Center(
                                          child: CircularProgressIndicator())
                                      : loginButton(
                                          textColor: Colors.white,
                                          textButton: "Login",
                                          functionPressing: () {
                                            if (appController
                                                    .loginFormKey.currentState
                                                    ?.validate() !=
                                                null) {
                                              appController.login(
                                                  email: appController
                                                      .emailController.text,
                                                  password: appController
                                                      .passwordController.text);
                                            }
                                          },
                                          styleButton: loginButtonStyle),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          )),
        ),
      );
    });
  }
}
