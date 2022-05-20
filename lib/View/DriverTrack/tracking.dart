import 'dart:async';
import 'package:alikardriver/Controller/AppController/appcontroller.dart';
import 'package:alikardriver/Controller/AppController/clienttracking.dart';
import 'package:alikardriver/Controller/AppController/trackingController.dart';
import 'package:alikardriver/View/clienttracking.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';



class TrackingPage extends StatelessWidget {

  final trackingClientController = Get.put(TrackingClientController());

 AppController appController = Get.find();



  @override
  Widget build(BuildContext context) {
    return GetBuilder<TrackingController>(builder: (trackingController) {
    //  trackingController.getCurrentLocation();
     // appController.streamLocation();
      return Scaffold(
        body: SafeArea(
          child: Stack(
            children: [
              GoogleMap(
                polylines: trackingController.polyline,
               markers: (trackingController.markers != null) ? trackingController.markers : {},
               circles: Set.of((trackingController.circle != null) ? [trackingController.circle!] : []),
                onMapCreated: trackingController.onMapCreated,
                initialCameraPosition: TrackingController.initialLocation,
                mapType: MapType.normal,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children:
                      [
                        Container(child: Center(child: Text("${trackingController.distanceInMetersCurrent} m ", style: TextStyle(color: Colors.white),)), height: 50,width: 200,decoration: BoxDecoration(color: Colors.deepPurple,borderRadius:  BorderRadius.circular(12)),),
                      ],
                    ),
                    SizedBox(height:  10,),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children:
                      [
                        Container(child: Center(child: Text("${trackingController.time} s", style: TextStyle(color: Colors.white),)), height: 50,width: 200,decoration: BoxDecoration(color: Colors.deepPurple,borderRadius:  BorderRadius.circular(12)),),
                      ],
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children:
                      [

                        ElevatedButton(onPressed: ()
                        {
                          Navigator.of(context).push(MaterialPageRoute(builder: (context)=>  TrackingPageClient()));

                        }, child: Text("Go To Client Map"))
                      ],
                    ),
                  ],
                ),
              )
            ],
          ),
        ),

      );
    });
  }


  /**/

}