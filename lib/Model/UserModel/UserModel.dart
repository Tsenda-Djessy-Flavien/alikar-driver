import 'dart:io';

import 'package:alikardriver/Model/UserModel/countrymodel.dart';

import 'originmodel.dart';

class UserModel {
  String? name;
  String? email;
  String? phone;
  String? password;
  String? type ;
  CountryModel? country;
  Origin? origin;


  UserModel({
    this.password,
    this.name,
    this.email,
    this.phone,
    this.country,
    this.origin,
    this.type,
  });

  UserModel.fromJson(Map<String, dynamic> json){
    name = json['name'];
    email = json['email'];
    phone = json['phone'];
    type= json['type'];
    origin= json['origin'];
    country= json['country'];
    password= json['password'];

  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'email': email,
      'phone': phone,
      'type' : type,
      'origin' : origin,
      'country' : country,
      'password' : password,

    };
  }

}

UserModel userModelInstance = UserModel();
