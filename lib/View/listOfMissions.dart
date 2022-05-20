import 'package:alikardriver/Controller/AppController/appcontroller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

final missionController = Get.put(AppController());


class ListOfMissions extends StatelessWidget
{
  const ListOfMissions({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
          future: missionController.getAllMissionsTypeOffer(typeOffer: "ponctual"),
          builder: (BuildContext context, AsyncSnapshot snapshot)
          {
            if (snapshot.connectionState == ConnectionState.done) {
              print("test");
              if (snapshot.hasData) {
                print("test Data");

                return ListView.builder(
                    physics: const BouncingScrollPhysics(),
                    itemCount:  snapshot.data.length,
                    scrollDirection: Axis.vertical,
                    itemBuilder: (_, int index)
                    {
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: SizedBox(
                          width: 300,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment:CrossAxisAlignment.start,
                            children:
                            [
                             Text("Type Mission : ${snapshot.data[index]["type"]}"),
                             Text("Type Offe : ${snapshot.data[index]["typeOffer"]}"),
                             Text("Type Subscription	:  ${snapshot.data[index]["typeSubscription"]}"),
                             Text("Date : ${snapshot.data[index]["date"].toString()}"),
                             Text("Status :  ${snapshot.data[index]["status"]}"),
                            ],
                          ),
                        ),
                      );
                    });

              }
            }
            return const Center(child: CircularProgressIndicator());
          }),
    );
  }


}
