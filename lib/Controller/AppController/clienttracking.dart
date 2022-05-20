import 'dart:typed_data';
import 'package:alikardriver/uses/cte.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart' hide Response;
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'dart:developer';
import 'package:location/location.dart';
import 'dart:async';
import 'package:flutter/services.dart';
import 'package:geolocator/geolocator.dart' as geo;
import 'package:get/get.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;
class TrackingClientController extends GetxController  {

  @override
  void onInit()
  {
    // Test =>
    //testSoket();
    updateSocketLatLong();
  }


  @override
  void onClose() {
    log("client tracking cloased ");

  } // Tracking Client

  Circle? circleClient;
  GoogleMapController? controllerMap;
  final Set<Polyline> polyline = {};
  final Set<Marker> markersClient = {};
  List<LatLng> listLatLongRealTime = [];
  List<LatLng> listLatLangAToB = [];
  late IO.Socket socket;


  void onMapCreatedClient(GoogleMapController controllerParam) {

    update();

    controllerMap = controllerParam;

    markersClient.add(Marker(
        markerId: const MarkerId("markerID"),
        position: listLatLongRealTime.first,
        infoWindow:   const InfoWindow(
          title: "titleMarker" ,
          snippet: 'This is a snippet',
        )));

    // this for real Time Tracking
    polyline.add(Polyline(
      polylineId: const PolylineId('realtimepoints'),
      visible: true,
      points: listLatLongRealTime,
      width: 2,
      color: Colors.blue,
    ));

    update();
  }


  static const CameraPosition initialLocation = CameraPosition(
    target:  LatLng(33.5743189, -7.6473574),
    zoom: 14.4746,
  );

  Future<Uint8List> getMarker() async
  {
    ByteData byteData = await rootBundle.load("assets/caar.png");
    return byteData.buffer.asUint8List();
  }

  void updateMarkerAndCircle({required double latitude, required double longitude}) async{
    markersClient.clear();
    markersClient.add(Marker(
        markerId: const MarkerId("markerID"),
        position: listLatLongRealTime.first,
        infoWindow:   const InfoWindow(
          title: "titleMarker" ,
          snippet: 'This is a snippet',
        )));


    markersClient.add(Marker(
        markerId: const MarkerId("home"),
        position: LatLng(latitude, longitude),
        draggable: false,
        rotation: -10,
        zIndex: 2,
        flat: true,
        anchor: const Offset(0.5, 0.5),
        icon: BitmapDescriptor.fromBytes(await getMarker())));

    circleClient = Circle(
        circleId: const CircleId("car"),
        radius: 5,
        zIndex: 1,
        strokeColor: Colors.blue,
        center:  LatLng(latitude, longitude),
        fillColor: Colors.blue.withAlpha(70));
    update();

  }

  Future<void> updateSocketLatLong() async {
    log("Test From update Data");
    IO.Socket socket = IO.io('http://192.168.11.120:8088',<String,dynamic>
    {
      "transports":['websocket'],
      "autoConnect":true
    });
    socket.onConnect((_)
    {
      log('create pointes');
    });
    socket.on('current-position', (data)
    {
      update();
      log(data['points'].first.toString());
      listLatLongRealTime.add(LatLng(data['points'].first["lat"], data['points'].first["long"]));
   controllerMap!.animateCamera(CameraUpdate.newCameraPosition(
          CameraPosition(
              bearing: 192.8334901395799,
              target:listLatLongRealTime.last,
              tilt: 0,
              zoom: 18.00)));
      updateMarkerAndCircle(latitude:data['points'].first["lat"],longitude: data['points'].first["long"] );
      update();
    });
    socket.onDisconnect((_) => print('disconnect'));
    socket.on('fromServer', (_) => print(_));
    update();
  }





}