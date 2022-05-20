import 'dart:typed_data';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart' hide Response;
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'dart:developer';
import 'package:location/location.dart';
import 'dart:async';
import 'package:flutter/services.dart';
import 'package:geolocator/geolocator.dart' as geo;
import 'package:socket_io_client/socket_io_client.dart' as IO;

import '../../uses/cte.dart';
class TrackingController extends GetxController
{

  // Tracking Part
  bool servicestatus = false;
  bool haspermission = false;
  late geo.LocationPermission permission;
  late geo.Position position;
  String long = "";
  String lat = "";
  late StreamSubscription<geo.Position> positionStream;
  StreamSubscription? locationSubscription;
  StreamSubscription? locationSubscription1;
  Location locationTracker = Location();
  Circle? circle;
  GoogleMapController? controllerMap;
  LocationData? location;
  double distanceInMetersCurrent = 0;
  Uint8List? imageData;

  final Set<Polyline> polyline = {};
  final Set<Polyline> polylineDriver = {};
  final Set<Marker> markers = {};
  List<LatLng> listLatLongRealTime = [];
  List<LatLng> listLatLangAToB = [];
  final LatLng lastLatLng = const LatLng(33.573107913900095, -7.6483503751212645);
  LatLng myActualPosition = const LatLng(13.069280, 77.455844);
  double speed = 0;
  double? time;
  String? idMission;

  // for networking
  Dio dio = Dio();
  late Response response;




  @override
  void onInit()
  {
    checkGps();
    getCurrentLocation();
  }


  Future createPointsMission({required createLatitude, required createLongitude}) async {
    response = await dio.post('${BaseURl}coordinations/create',
        data:
        {
          "points": [ {"lat": createLatitude, "long": createLongitude } ],
        },
      options: Options(headers:
      {
        "Content-Type": "application/json",
        "X-Auth-Token": token,
      }) ,
    );

    if (response.statusCode == 200)
    {
      log(response.data.toString());
      idMission = response.data["_id"].toString();
      log(idMission!);
    }
    else
    {
      print("Error");
    }
  }


  Future updatePointsMission({required updateLatitude, required updateLongitude,required String idMission}) async {
    response = await dio.post('${BaseURl}coordinations/update',
      queryParameters: {'_id': idMission},
        data:
        {
          "points": [ {"lat": updateLatitude, "long": updateLongitude } ],
        },
      options: Options(headers: {"Content-Type": "application/json", "X-Auth-Token": token}),);
    if (response.statusCode == 200)
    {
      //log(response.data.toString());
    }
    else
    {
      print("Error");
    }
  }



  checkGps() async {
    servicestatus = await geo.Geolocator.isLocationServiceEnabled();
    if (servicestatus) {
      permission = await geo.Geolocator.checkPermission();

      if (permission == geo.LocationPermission.denied) {
        permission = await geo.Geolocator.requestPermission();
        if (permission == geo.LocationPermission.denied) {
          print('Location permissions are denied');
        } else if (permission == geo.LocationPermission.deniedForever) {
          print("'Location permissions are permanently denied");
        } else {
          haspermission = true;
        }
      } else {
        haspermission = true;
      }

      if (haspermission) {
        update();

        getLocation();
      }
    } else {
      print("GPS Service is not enabled, turn on GPS location");
    }
    update();
  }


  static const CameraPosition initialLocation = CameraPosition(
    target: LatLng(13.035606, 77.562381),
    zoom: 14.4746,
  );


  Future<Uint8List> getMarker() async {
    ByteData byteData = await rootBundle.load("assets/caar.png");
    return byteData.buffer.asUint8List();
  }


  Future<void> getCurrentLocation() async {
    try {
      imageData = await getMarker();
      location = await locationTracker.getLocation();
      updateMarkerAndCircle(location!, imageData!);

      if (locationSubscription != null)
      {
        locationSubscription!.cancel();
      }


      locationSubscription = locationTracker.onLocationChanged.listen((newLocalData) {
            if (controllerMap != null)
            {

              if(listLatLongRealTime.isEmpty)
              {
                createPointsMission(createLatitude: newLocalData.latitude, createLongitude: newLocalData.longitude);
              }
              else if(listLatLongRealTime.isNotEmpty)
              {
                Future.delayed(const Duration(seconds: 15)).then((value) => updatePointsMission(updateLatitude: newLocalData.latitude!, updateLongitude: newLocalData.longitude!,idMission: idMission!));
              }

              listLatLongRealTime.add(LatLng(newLocalData.latitude!, newLocalData.longitude!)); // this for add stream of position

              if(listLatLangAToB.length <1)
              {
                listLatLangAToB.add(listLatLongRealTime.first);
                listLatLangAToB.add(lastLatLng);
              }


              double distanceInMeters = Geolocator.distanceBetween(
                  listLatLangAToB.first.latitude,
                  listLatLangAToB.first.longitude,
                  listLatLangAToB.last.latitude,
                  listLatLangAToB.last.longitude);

              distanceInMetersCurrent = Geolocator.distanceBetween(
                  newLocalData.latitude!,
                  newLocalData.longitude!,
                  lastLatLng.latitude,
                  lastLatLng.longitude);

              speed = newLocalData.speed!;
              time = speed * distanceInMeters;

              controllerMap!.animateCamera(CameraUpdate.newCameraPosition(
                  CameraPosition(
                      bearing: 192.8334901395799,
                      target:
                      LatLng(newLocalData.latitude!, newLocalData.longitude!),
                      tilt: 0,
                      zoom: 18.00)));
              updateMarkerAndCircle(newLocalData, imageData!);
              update();
            }
          });
    } on PlatformException catch (e) {
      if (e.code == 'PERMISSION_DENIED') {
        debugPrint("Permission Denied");
      }
    }
  }


  void onMapCreated(GoogleMapController controllerParam) {
    update();
    controllerMap = controllerParam;

    // this for real Time Tracking
    polyline.add(Polyline(
      polylineId: const PolylineId('realtime'),
      visible: true,
      points: listLatLongRealTime,
      width: 2,
      color: Colors.blue,
    ));

    // this for Tracking from A to B
    polyline.add(Polyline(
      polylineId: const PolylineId('complete'),
      visible: true,
      points: listLatLangAToB,
      width: 4,
      color: Colors.red,
    ));

    update();

  }

  void updateMarkerAndCircle(LocationData newLocalData, Uint8List imageData) {
    LatLng latlng = LatLng(newLocalData.latitude!, newLocalData.longitude!);

    if(listLatLangAToB.isNotEmpty)
    {
      addFixedMarker(markers: markers,positionMarker: listLatLangAToB.first,markerID: "Start",titleMarker: "Start" );
      addFixedMarker(markers: markers,positionMarker: listLatLangAToB.last,markerID: "End",titleMarker: "End" );
    }
    if(markers.length>2)
    {
      markers.clear();
      addFixedMarker(markers: markers,positionMarker: listLatLangAToB.first,markerID: "Start",titleMarker: "Start" );
      addFixedMarker(markers: markers,positionMarker: listLatLangAToB.last,markerID: "End",titleMarker: "End" );
    }

    markers.add(Marker(
        markerId: const MarkerId("home"),
        position: latlng,
        rotation: newLocalData.heading!,
        draggable: false,
        zIndex: 2,
        flat: true,
        anchor: const Offset(0.5, 0.5),
        icon: BitmapDescriptor.fromBytes(imageData)));


    circle = Circle(
        circleId: const CircleId("car"),
        radius: newLocalData.accuracy!,
        zIndex: 1,
        strokeColor: Colors.blue,
        center: latlng,
        fillColor: Colors.blue.withAlpha(70));


    update();

  }


  getLocation() async {
    position = await geo.Geolocator.getCurrentPosition(desiredAccuracy: geo.LocationAccuracy.high);

    long = position.longitude.toString();
    lat = position.latitude.toString();

    update();

    geo.LocationSettings locationSettings = const geo.LocationSettings(
      accuracy: geo.LocationAccuracy.high,
      distanceFilter: 100,
    );

    StreamSubscription<geo.Position> positionStream =
    geo.Geolocator.getPositionStream(locationSettings: locationSettings)
        .listen((geo.Position position) {
      print(position.longitude);
      print(position.latitude);
      long = position.longitude.toString();
      lat = position.latitude.toString();

      update();
    });
  }


  void addFixedMarker({required Set<Marker> markers , required LatLng positionMarker, required String markerID , required String titleMarker})
  {
    markers.add(Marker(
        markerId: MarkerId(markerID),
        position: positionMarker,
        infoWindow:  InfoWindow(
          title: titleMarker ,
          snippet: 'This is a snippet',
        )));
  }




}
