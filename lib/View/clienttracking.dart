import 'dart:async';
import 'package:alikardriver/Controller/AppController/appcontroller.dart';
import 'package:alikardriver/Controller/AppController/clienttracking.dart';
import 'package:alikardriver/Controller/AppController/trackingController.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';



class TrackingPageClient extends StatelessWidget {




  @override
  Widget build(BuildContext context) {
    return GetBuilder<TrackingClientController>(builder: (trackingClientController) {
      //  trackingController.getCurrentLocation();
      // appController.streamLocation();
      return Scaffold(
        body: SafeArea(
          child: Stack(
            children: [
              GoogleMap(
                polylines: trackingClientController.polyline,
                markers: (trackingClientController.markersClient != null) ? trackingClientController.markersClient : {},
                circles: Set.of((trackingClientController.circleClient != null) ? [trackingClientController.circleClient!] : []),
                onMapCreated: trackingClientController.onMapCreatedClient,
                initialCameraPosition: TrackingClientController.initialLocation,
                mapType: MapType.normal,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [

                        Container(child: const Center(child:  Text(" Client ", style: TextStyle(color: Colors.white),)), height: 50,width: 200,decoration: BoxDecoration(color: Colors.deepPurple,borderRadius:  BorderRadius.circular(12)),),
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




}