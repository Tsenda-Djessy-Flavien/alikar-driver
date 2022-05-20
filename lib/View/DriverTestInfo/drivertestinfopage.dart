import 'dart:async';
import 'package:alikardriver/Controller/AppController/appcontroller.dart';
import 'package:alikardriver/Model/UserModel/TestInfoModel.dart';
import 'package:alikardriver/uses/ListQuestionSwitch/listswitche.dart';
import 'package:alikardriver/uses/componetes/registerlogincompontes/widgetregisterlogin.dart';
import 'package:alikardriver/uses/widgets/navigations.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../Model/UserModel/TestInfoModel.dart';

class TestInfoPage extends StatefulWidget {
  const TestInfoPage({Key? key}) : super(key: key);

  @override
  State<TestInfoPage> createState() => _TestInfoPageState();
}

class _TestInfoPageState extends State<TestInfoPage> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<AppController>(builder: (appController) {
      return Scaffold(
        body: SafeArea(
          child: Column(
            children: [
              SizedBox(
                height: 35,
              ),
              Row(
                children: [
                  const SizedBox(
                    width: 15,
                  ),
                  // InkWell(
                  //     onTap: () => goToLoginScreen(context),
                  //     child: const Icon(
                  //       Icons.arrow_back_ios,
                  //       size: 20,
                  //     )),
                  const SizedBox(
                    width: 15,
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      Text(
                        "Complete your sign-in",
                        style: TextStyle(
                            color: Colors.black,
                            fontFamily: "Roboto",
                            fontWeight: FontWeight.bold,
                            fontSize: 25,
                            height: 1),
                      ),
                      const SizedBox(
                        height: 2,
                      ),
                      Text(
                        " Create account by filling the form below .",
                        style: TextStyle(
                            color: Colors.black,
                            fontFamily: "Roboto",
                            fontWeight: FontWeight.bold,
                            fontSize: 10),
                      ),
                    ],
                  )
                ],
              ),
              SizedBox(
                height: 40,
              ),
              Expanded(
                child: FutureBuilder<List<QuestionInfo>>(
                    future: appController.getTestInfoData(),
                    builder: (BuildContext context,
                        AsyncSnapshot<List<QuestionInfo>> snapshot) {
                      if (snapshot.connectionState == ConnectionState.done) {
                        var questions;
                        print("");
                        if (snapshot.hasData) {
                          questions = snapshot.data!.toList();

                          return ListView.builder(
                              physics: const BouncingScrollPhysics(),
                              itemCount: questions.length,
                              scrollDirection: Axis.vertical,
                              itemBuilder: (_, int index) {
                                final data = questions[index];
                                appController.listSwitch.add(ListSwitch(
                                    label: data.label!, index: index));

                                appController.answerTestInfoList.add({
                                  "questionId": data.sId,
                                  "label": data.label,
                                  "note": data.note,
                                  "value": false,
                                });

                                Timer.periodic(const Duration(seconds: 30),
                                    (timer) {
                                  // print("Data Send");
                                });

                                return Column(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          top: 15.0,
                                          bottom: 5,
                                          left: 15,
                                          right: 15),
                                      child: appController.listSwitch[index],
                                    ),
                                  ],
                                );
                              });
                        }
                      }
                      return const Center(child: CircularProgressIndicator());
                    }),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: loginButton(
                    textColor: Colors.white,
                    textButton: "Continuer",
                    functionPressing: () {
                      print("${appController.answerTestInfoList}");
                      appController.createDriverTestInfo();
                    },
                    styleButton: loginButtonStyle),
              ),
              SizedBox(
                height: 15,
              ),
            ],
          ),
        ),
      );
    });
  }
}
