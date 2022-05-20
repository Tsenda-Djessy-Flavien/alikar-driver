import 'dart:developer';

import 'package:alikardriver/Controller/AppController/appcontroller.dart';
import 'package:alikardriver/Model/UserModel/TestDriveModel.dart';
import 'package:alikardriver/View/homepage.dart';
import 'package:alikardriver/View/DriverTrack/tracking.dart';
import 'package:circular_countdown_timer/circular_countdown_timer.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TestDrivePage extends StatefulWidget {
  final List<QuestionDrive> questionData;

  const TestDrivePage({Key? key, required this.questionData}) : super(key: key);
  @override
  _TestDrivePageState createState() => _TestDrivePageState();
}

class _TestDrivePageState extends State<TestDrivePage> {
  final CountDownController _controller = CountDownController();
  AppController appController = Get.find();

  @override
  void initState() {
    // _controller.start();
  }

  @override
  void dispose() {
    _controller.restart();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
      ),
      body: Column(
        children: [
          const SizedBox(height: 15,),
          CircularCountDownTimer(
            duration: 10,
            initialDuration: 1,
            controller: _controller,
            width: MediaQuery.of(context).size.width / 2,
            height: 50,
            ringColor: Colors.grey[300]!,
            ringGradient: null,
            fillColor: Colors.purpleAccent[100]!,
            fillGradient: null,
            backgroundColor: Colors.purple[500],
            backgroundGradient: null,
            strokeWidth: 20.0,
            strokeCap: StrokeCap.round,
            textStyle: const TextStyle(
                fontSize: 33.0,
                color: Colors.white,
                fontWeight: FontWeight.bold),
            textFormat: CountdownTextFormat.S,
            isReverse: false,
            isReverseAnimation: false,
            isTimerTextShown: true,
            autoStart: false,
            onStart: () {
              debugPrint('Countdown Started');
            },
            onComplete: () {
              debugPrint('Countdown Ended');
            },
          ),
          //  widget.questionData[appController.indexController].src!
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Image.asset("assets/testdrive.jpg",
              height: MediaQuery.of(context).size.height / 2 - 50,
            ),
          ),
          Text("${widget.questionData[appController.indexController].label}"),
          const SizedBox(
            height: 10,
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: ListView.separated(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  separatorBuilder: (context, index) => const SizedBox(height: 5),
                  itemCount: widget
                      .questionData[appController.indexController].answers!.length,
                  itemBuilder: (context, index)
                  {
                    return GestureDetector(
                      child: Container(
                        height: 50,
                        width: MediaQuery.of(context).size.width - 40,
                        child: Center(
                            child: Text(widget.questionData[appController.indexController].answers![index].label!)),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            border:
                            Border.all(width: 1.5, color: Colors.blueAccent)),),
                      onTap: ()
                      {
                        log(widget.questionData[appController.indexController].note.toString()); // to see the note of question
                        var listAnswers = [];
                        for(int i = 0 ; i< widget.questionData[appController.indexController].answers!.length ;i++)
                        {
                          listAnswers.add(
                              {
                                "label":widget.questionData[appController.indexController].answers![i].label,
                                "correct":widget.questionData[appController.indexController].answers![i].correct
                              });
                        }

                        print("data length is  ${widget.questionData.length}");
                        print("data length is  ${appController.indexController}");
                        if (appController.indexController < widget.questionData.length-1 )
                        {
                          if(widget.questionData[appController.indexController].answers![index].correct!) {
                            appController.answerTestDriveList.add({
                              "questionId": widget.questionData[appController.indexController].sId,
                              "label": widget.questionData[appController.indexController].label,
                              "note": widget.questionData[appController.indexController].note,
                              "value": true,
                              "answers": listAnswers
                            });
                            appController.indexController++;
                          }
                          else {
                            appController.answerTestDriveList.add({
                              "questionId": widget.questionData[appController.indexController].sId,
                              "label": widget.questionData[appController.indexController].label,
                              "note": widget.questionData[appController.indexController].note,
                              "value": false,
                              "answers": listAnswers
                            });
                            appController.indexController++;
                          }

                         // print(appController.answerTestDriveList);
                         // print(appController.indexController);

                          setState(() {});
                        }
                        else if(appController.indexController == widget.questionData.length-1)
                        {
                          if(widget.questionData[appController.indexController].answers![index].correct!)
                          {
                            appController.answerTestDriveList.add({
                              "questionId": widget.questionData[appController.indexController].sId,
                              "label": widget.questionData[appController.indexController].label,
                              "note": widget.questionData[appController.indexController].note,
                              "value": true,
                              "answers": listAnswers
                            });
                          }
                          else
                          {
                            appController.answerTestDriveList.add({
                              "questionId": widget.questionData[appController.indexController].sId,
                              "label": widget.questionData[appController.indexController].label,
                              "note": widget.questionData[appController.indexController].note,
                              "value": false,
                              "answers": listAnswers
                            });
                          }
                          print(appController.answerTestDriveList);

                          Navigator.of(context).push(MaterialPageRoute(builder: (context)=> TrackingPage()));
                        }

                        else
                        {
                          setState(() {});
                          print(appController.answerTestDriveList);
                          //Navigator.of(context).push(MaterialPageRoute(builder: (context)=> const HomePage()));
                          print("fine");
                        }
                        setState(() {   });

                      },

                    );
                  }),
            ),
          ),
          Row(
            children: [
              TextButton(
                  onPressed: () {
                    if (appController.indexController > 0) {
                      print("index--");
                      setState(() {
                        appController.indexController--;
                      });
                    } else {
                      print("fine");
                    }
                  },
                  child: const Text("Undo")),
              const Spacer(),
              TextButton(
                  onPressed: () {
                    if (appController.indexController < widget.questionData.length - 1) {
                      print("index++");
                      setState(() {
                        appController.indexController++;
                      });
                    } else {
                      print("fine");
                    }
                  },
                  child: const Text("Next")),
            ],
          )
        ],
      ),

    );
  }
}
