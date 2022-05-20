import 'package:alikardriver/View/DriverCourseDrive/DriverCourseView.dart';
import 'package:alikardriver/View/DriverTestDrive/drivertestdrive.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../Controller/AppController/appcontroller.dart';

class ListCourseDrivePage extends StatelessWidget {
  const ListCourseDrivePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context)  {
    return GetBuilder<AppController>(builder: (appController) {
      return Scaffold(
        body: SafeArea(
          child: Container(
            child: Column(
              children: [
                Expanded(
                  child: ListView(
                    children: [
                      const SizedBox(
                        height: 10,
                      ),
                      ListTile(
                        leading: Image.asset("assets/Capture.PNG"),
                        title: const Text("First Video"),
                        onTap: () {
                          print("Video 1");
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => const VideoPlayer(
                                url: "https://www.youtube.com/watch?v=9RYD00PdkFA",
                              )));
                        },
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      ListTile(
                        leading: Image.asset("assets/Capture.PNG"),
                        title: const Text("First Video"),
                        onTap: () {
                          print("Video 2");
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => const VideoPlayer(
                                url: "https://www.youtube.com/watch?v=ApK4quhVwfs",
                              )));
                        },
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      ListTile(
                        leading: Image.asset("assets/Capture.PNG"),
                        title: const Text("First Video"),
                        onTap: () {
                          print("Video 3");
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => const VideoPlayer(
                                url: "https://www.youtube.com/watch?v=tZIek3PFOW4",
                              )));
                        },
                      ),
                    ],
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ElevatedButton(
                    onPressed: () async {
                     // appController.getTestDriveData();

                        try {
                          Navigator.of(context).push(MaterialPageRoute(builder: (context)=> TestDrivePage(questionData: appController.questionDriveList,)));
                        } on Exception catch (e)
                        {
                         print("problem");
                        }

                    //  appController.testDrive();
                    },
                    child: const Text("Next"),
                  ),
                )
              ],
            ),
          ),
        ),
      );
    });
  }
}


