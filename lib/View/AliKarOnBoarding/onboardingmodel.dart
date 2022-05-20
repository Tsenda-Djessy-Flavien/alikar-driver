import 'package:alikardriver/View/DriverHomePage/driverhompage.dart';
import 'package:alikardriver/View/DriverLogin/driverloginpage.dart';
import 'package:alikardriver/uses/cte.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';


//LocalizationController localizationController = Get.find();

class BoardingModel {
  final String image;
  final String title;
  final String body;
  BoardingModel({
    required this.title,
    required this.image,
    required this.body,
  });
}


bool isLastOnBoarding = false;
PageController boarderController = PageController();

int currentPage  = 0;


void submit(context)
{

  Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context)=>   LoginScreen()));


 storage.write("OnboardingValue", true).then((value)
  {
     Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context)=>  LoginScreen()));
  });
}


List<BoardingModel> boarding = [
//first
  BoardingModel(
      image: "assets/logo.png",
      title: "Drive messages",
      body: "FF Real was originally conceived by Erik Spiekermann as one text weight and one headline weight to be used as the only fonts in his"),

//second
  BoardingModel(
      image: "assets/logo.png",
      title: "Explore Places",
      body: "FF Real was originally conceived by Erik Spiekermann as one text weight and one headline weight to be used as the only fonts in his"),

//third
  BoardingModel(
      image: "assets/logo.png",
      title: "Privacy Protection",
      body: "FF Real was originally conceived by Erik Spiekermann as one text weight and one headline weight to be used as the only fonts in his"),

];
