import 'dart:developer';

import 'package:alikardriver/Controller/AppController/appcontroller.dart';
import 'package:alikardriver/Model/UserModel/countrymodel.dart';
import 'package:alikardriver/Model/UserModel/originmodel.dart';
import 'package:alikardriver/View/DriverLogin/driverloginpage.dart';
import 'package:alikardriver/uses/componetes/registerlogincompontes/widgetregisterlogin.dart';
import 'package:alikardriver/uses/widgets/navigations.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RegisterScreen extends StatelessWidget {
  RegisterScreen({Key? key}) : super(key: key);
  bool value = false;
  bool value2 = false;

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AppController>(builder: (appController) {
      return Scaffold(

        body: Container(
          decoration:  const BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Color(0xff74c9ef),
                    Color(0xffaaddf4),
                  ]
              )),
          child: SafeArea(
              child: Form(
                key: appController.registerFormKey,
                child: Column(
                  children: [
                    Image.asset(
                      'assets/logo.png',
                      height: MediaQuery.of(context).size.height / 3 -120,
                      width: MediaQuery.of(context).size.width + 100 ,
                    ),
                    Expanded(
                      child: Container(
                        decoration:const BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.only(
                            topLeft:  Radius.circular(30),
                            topRight: Radius.circular(30),
                          ),
                        ),

                        child:Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: SingleChildScrollView(
                            physics: BouncingScrollPhysics(),
                            child: Column(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(15),
                                  child: Row(children: [
                                    InkWell(onTap:()=> goBackMaybe(context),child: const Icon(Icons.arrow_back)),
                                    const SizedBox(width:  20,),
                                    Column(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: const
                                      [
                                        Text("Create",style:TextStyle(color: Colors.black,fontFamily: "Roboto", fontWeight:FontWeight.bold,fontSize: 30),),
                                        Text(" your account",style:TextStyle(color: Colors.black,fontFamily: "Roboto", fontWeight:FontWeight.bold,fontSize: 30),),
                                      ],
                                    )
                                  ],),
                                ),
                                const SizedBox(width:  10,),
                                Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 25),
                                  child: Column(
                                    children: [
                                      myFormField(
                                        pathImage: "assets/icons/lock.png",
                                        controller: appController.registerNameController,
                                        validate: (String? value) {
                                          if (value == null || value.isEmpty) {
                                            return "emptyFailed";
                                          } else {
                                            return null;
                                          }
                                        },
                                        type: TextInputType.emailAddress,
                                        suffixIcon: Icons.person_outlined,
                                        hintText: "Name",
                                      ),
                                      const SizedBox(height: 15),
                                      myFormField(
                                        pathImage: "assets/icons/mail.png",
                                        controller: appController.registerEmailController,
                                        validate: (String? value) {
                                          if (value == null || value.isEmpty) {
                                            return "emptyFailed";
                                          } else {
                                            return null;
                                          }
                                        },
                                        type: TextInputType.emailAddress,
                                        suffixIcon: Icons.email_outlined,
                                        hintText: "Email",
                                      ),
                                      const SizedBox(height: 15),
                                      myFormField(
                                        pathImage: "assets/icons/lock.png",
                                        controller: appController.registerPhoneController,
                                        validate: (String? value) {
                                          if (value == null || value.isEmpty) {
                                            return "emptyFailed";
                                          } else {
                                            return null;
                                          }
                                        },
                                        type: TextInputType.phone,
                                        suffixIcon: Icons.phone_outlined,
                                        hintText: "Phone",
                                      ),
                                      const SizedBox(height: 15),
                                      myFormField(
                                        pathImage: "assets/icons/lock.png",
                                        suffixPressed: () {
                                          appController.changePasswordVisibility();
                                          appController.update();
                                        },
                                        onSubmit: (value) {
                                          if (appController.registerFormKey.currentState
                                              ?.validate() !=
                                              null) {
                                            appController.update();
                                            //BackEnd
                                          }
                                        },
                                        controller: appController.registerPasswordController,
                                        validate: (String? value) {
                                          if (value == null || value.isEmpty) {
                                            return "emptyFailed";
                                          } else {
                                            return null;
                                          }
                                        },
                                        type: TextInputType.text,
                                        isPass: appController.isPassword,
                                        hintText: "Password",
                                        suffixIcon: appController.suffix,
                                      ),
                                      const SizedBox(height: 15),
                                      Container(
                                        decoration: BoxDecoration(
                                            color: Colors.indigo.withOpacity(0.1),
                                            borderRadius: BorderRadius.circular(15)),
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: DropdownButton<String>(
                                            isExpanded: true,
                                            value: appController.value0,
                                            items: appController.allCountryList
                                                .map<DropdownMenuItem<String>>((String value) {
                                              return DropdownMenuItem<String>(
                                                value: value,
                                                child: Row(
                                                  children: [
                                                    const SizedBox(
                                                      width: 10,
                                                    ),
                                                    Text(
                                                      value,
                                                      style: const TextStyle(color: Colors.black),
                                                    ),
                                                  ],
                                                ),
                                              );
                                            }).toList(),
                                            onChanged: (newValue) {
                                              appController.value0 = newValue!;
                                              appController.update();
                                            },
                                            underline: Container(),
                                            // icon: DropdownIcon,
                                          ),
                                        ),
                                      ),

                                      const SizedBox(height: 15),
                                      Row(
                                        children: <Widget>[
                                          const SizedBox(
                                            width: 10,
                                          ),
                                          const SizedBox(width: 10),
                                          Checkbox(
                                            value: value,
                                            onChanged: (valur)
                                            {
                                              value = valur!;
                                              log("re1");
                                              appController.update();
                                            },
                                          ),
                                          const Text(
                                            'Lorem ipsum dolor sit amet',
                                            style: TextStyle(fontSize: 17.0),
                                          ), //Text

                                        ],
                                      ),
                                      Row(
                                        children: <Widget>[
                                          const SizedBox(
                                            width: 10,
                                          ),
                                          const SizedBox(width: 10),
                                          Checkbox(
                                            value: value2,
                                            onChanged: (valur)
                                            {
                                              value2 = valur!;
                                              log("re2");
                                              appController.update();
                                            },
                                          ),
                                          const Text(
                                            'Lorem ipsum dolor sit amet',
                                            style: TextStyle(fontSize: 17.0),
                                          ), //Text

                                        ],
                                      ),
                                      appController.loadingLogin.value
                                          ? const Center(child: CircularProgressIndicator())
                                          : loginButton(
                                          textColor: Colors.black,
                                          textButton: "Register",
                                          functionPressing: () async {
                                            if (appController.registerFormKey.currentState
                                                ?.validate() !=
                                                null) {
                                              appController.signUp(
                                                name: appController.registerNameController.text,
                                                email: appController.registerEmailController.text.trim(),
                                                password: appController.registerPasswordController.text,
                                                phone: appController.registerPhoneController.text,
                                                type: 'driver',
                                              );

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
