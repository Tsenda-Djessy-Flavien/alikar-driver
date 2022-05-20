import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:alikardriver/Model/UserModel/MissionModel.dart';
import 'package:alikardriver/Model/UserModel/TestDriveModel.dart';
import 'package:alikardriver/Model/UserModel/TestInfoModel.dart';
import 'package:alikardriver/Model/UserModel/UserModel.dart';
import 'package:alikardriver/Model/UserModel/countrymodel.dart';
import 'package:alikardriver/Model/UserModel/originmodel.dart';
import 'package:alikardriver/View/DriveCompletInfo/CompletInfo.dart';
import 'package:alikardriver/View/DriverCourseDrive/driverlistcoursepage.dart';
import 'package:alikardriver/View/DriverTestInfo/drivertestinfopage.dart';
import 'package:alikardriver/uses/ListQuestionSwitch/listswitche.dart';
import 'package:alikardriver/uses/cte.dart';
import 'package:camera/camera.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart' hide Response;
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:developer';
import 'package:location/location.dart';
import 'dart:async';
import 'package:flutter/services.dart';
import 'package:geolocator/geolocator.dart' as geo;

class AppController extends GetxController {
  // for Password TextFiled
  IconData suffix = Icons.visibility_off_outlined;
  bool isPassword = true;

  // for networking
  Dio dio = Dio();
  late Response response;

  var loadingLogin = false.obs;

  // Global Keys for Forms
  final GlobalKey<FormState> loginFormKey = GlobalKey<FormState>();
  final GlobalKey<FormState> registerFormKey = GlobalKey<FormState>();
  final GlobalKey<FormState> completeInfoFormKey = GlobalKey<FormState>();

  // TextField Controller for Login
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  // TextField Controller for Register
  final TextEditingController registerEmailController = TextEditingController();
  final TextEditingController registerNameController = TextEditingController();
  final TextEditingController registerPhoneController = TextEditingController();
  final TextEditingController registerPasswordController = TextEditingController();

  // DropDown Button in Register
  String value0 = 'Maroc';
  List<String> allCountryList = [];

  // for Test Info
  List<QuestionInfo> questionInfoList = [];
  List<ListSwitch> listSwitch = <ListSwitch>[];
  List answerTestInfoList = [];

  // for Complementary Info
  final TextEditingController completeInfoRipController = TextEditingController();
  final TextEditingController completeInfoWorkAddressController = TextEditingController();
  var picker = ImagePicker();
  File? myImages;
  String? base64Image;
  String? personalImage ;
  String? fromCamera ;
  String? anthropometricImage ;
  List<String> idCard = [];
  List<String> residenceCertificate = [];
  List<String> medicalPapers = ["https://storage-alikar.b-cdn.net/saas/5-2022/1651674854537.jpeg"];
  List<String> selfEmployedCard = [];
  List<String> license = [];
  List<String> professionalCard = [];
  List<String> degrees = []  ;



  // for Test Drive
  List<QuestionDrive> questionDriveList = [];
  List answerTestDriveList = [];
  int indexController = 0; // this counter  go to next question

  //take Pictures
  var pickers = ImagePicker();
  File? profileImage;

  bool showedCIN = false;
  bool showedPermit = false;
  bool showedJustificatifeDeResidence = false;
  bool showedCarteAuto = false;


  @override
  void onInit()
  {

    getAllCountry().then((value)
    {
      List<CountryModel>? allCountry = value.countryModel;
      allCountry!.map((e) {
        allCountryList.add(e.name.toString());
      }).toList();
    });

    getOrigin().then((_origin) {
      originModelInstance = _origin;
      getCountry(codeCountry: _origin.country!).then((value) {
        var myCountry = value.countryModel!.first;
        countryModelInstance = myCountry;
      });
    });
  }

  void changePasswordVisibility() {
    isPassword = !isPassword;
    suffix = isPassword ? Icons.visibility_off_outlined : Icons.visibility;
    update();
  }


  // for Register

  Future<Country> getAllCountry() async {
    response = await dio
        .get('${BaseURl}countries/search', queryParameters: {'limit': 500});
    log(response.data.toString());
    return Country.fromJson(response.data);
  }

  Future<Origin> getOrigin() async {
    response = await dio.get('https://ipinfo.io/196.117.139.209',
        queryParameters: {'token': '5db2d9411b862a'});
    return Origin.fromJson(response.data);
  }

  Future<Country> getCountry({required String codeCountry}) async {
    response = await dio.get('${BaseURl}countries/search',
        queryParameters: {'code': codeCountry});
    return Country.fromJson(response.data);
  }

  Future signUp(
      {required String name,
      required String email,
      required String type,
      required String phone,
      required String password}) async {
    response = await dio.post('${BaseURl}users/signup', data: {
      "name": name,
      "email": email,
      "password": password,
      "phone": phone,
      "type": type,
      "country": {
        "_id": countryModelInstance.sId,
        "name": countryModelInstance.name,
        "code": countryModelInstance.code,
        "iso": countryModelInstance.iso,
        "currency": countryModelInstance.currency,
        "dialCode": countryModelInstance.dialCode
      },
      "origin": {
        "ip": originModelInstance.ip,
        "city": originModelInstance.city,
        "region": originModelInstance.region,
        "country": originModelInstance.country,
        "loc": originModelInstance.loc,
        "org": originModelInstance.org,
        "timezone": originModelInstance.timezone
      }
    });
    print(response.data['token'].toString());
    print(response.data.toString());
  }

  Future login({required String email, required String password}) async {
   dio.post('${BaseURl}users/login', data: {
      "email": email,
      "password": password,
    }).then((value)
   {
     if (value.statusCode == 200)
     {
       token = value.data['token'].toString();
       print('Token is that $token');
       Get.offAll(() => TestInfoPage());
     }

     if(value.statusCode == 400)
     {
       log(value.data.toString());
       log("Error");
     }
   }).onError((error, stackTrace)
   {
     log("error.toString()");
   });



  }

  Future<TestInfo> testInfo() async {
    response = await dio.get('${BaseURl}questions/search',
        queryParameters: {'type': 'testInfo'},
        options: Options(headers: {
          "Content-Type": "application/json",
          "X-Auth-Token": token
        }));
    log(response.data.toString());
    return TestInfo.fromJson(response.data);
  }

  Future<List<QuestionInfo>> getTestInfoData() async =>
      testInfo().then((value) {
        questionInfoList = value.questionTestInfo!;
        return questionInfoList;
      });

  Future createDriverTestInfo() async {
    response = await dio.post('${BaseURl}drivers/create',
        data: {"quizInfo": answerTestInfoList},
        options: Options(headers: {
          "Content-Type": "application/json",
          "X-Auth-Token": token,
        }));

    if (response.statusCode == 200) {
      log(response.data.toString());
      Get.offAll(() => CompleteInfoDrive());
    } else
    {
      print("Error");
    }
  }


  Future getImageFromLocale({required String imageType}) async {

    picker.pickImage(source: ImageSource.gallery).then((value)
    {
      if (value != null)
      {
        myImages = File(value.path);
        imgs = value.mimeType;
        log(imgs.toString());
        convertImageToBase64(imagePath: myImages!,imageType: imageType);
      } else
      {
        print('No image selected.');
      }

    });

  }


  Future convertImageToBase64({required File imagePath,required String imageType}) async
  {
     imagePath.readAsBytes().then((value)
     {
       base64Image = base64.encode(value);
       log("$base64Image");
       uploadImages(image64Base: "data:image/jpeg;base64,$base64Image",imageType: imageType);
     });
  }

  Future uploadImages({required String image64Base,required String imageType}) async {
    response = await dio.post('${BaseURl}images/upload',
        data: {"picture": image64Base},
        options: Options(headers: {
          "Content-Type": "application/json",
          "X-Auth-Token": token
        }));

    if(imageType == "personalImage")
    {
      personalImage = response.data.toString();
    }
    if(imageType == "idCardRecto")
    {
      idCard.add(response.data.toString());
    }
    if(imageType == "idCardVerso")
    {
      idCard.add(response.data.toString());
    }
    if(imageType == "anthropometricImage")
    {
      anthropometricImage = response.data.toString();
    }
    if(imageType == "residenceCertificateRecto")
    {
      residenceCertificate.add(response.data.toString());
    }
    if(imageType == "residenceCertificateVerso")
    {
      residenceCertificate.add(response.data.toString());
    }
    if(imageType == "selfEmployedCardRecto")
    {
      selfEmployedCard.add(response.data.toString());
    }
    if(imageType == "selfEmployedCardVerso")
    {
      selfEmployedCard.add(response.data.toString());
    }
    if(imageType == "licenseRecto")
    {
      license.add(response.data.toString());
    }
    if(imageType == "licenseVerso")
    {
      license.add(response.data.toString());
    }if(imageType == "professionalCardRecto")
    {
      professionalCard.add(response.data.toString());
    }
    if(imageType == "professionalCardVerso")
    {
      professionalCard.add(response.data.toString());
    }
    if(imageType == "degrees")
    {
      degrees.add(response.data.toString());

    }
    if(imageType == "fromcamera")
    {
      fromCamera = response.data.toString();
    }

    log(response.data.toString());
    log(userModelInstance.name.toString());

  }


  Future completeInfoDriver({required String rip, required String workAddress,}) async {
    response = await dio.post('${BaseURl}drivers/update',
        data:
        {
          "image":personalImage,
          "idCard" :
          {
            "idNumber":"4414141444141144",
            "src":idCard,
          },
          "anthropometric":anthropometricImage,
          "residenceCertificate":residenceCertificate,
          "rip": rip,
          "medicalPapers":[
            {"type": "B","src": medicalPapers},
          ],
          "selfEmployedCard" :
          {
            "idNumber":"4414141444141144",
            "src":selfEmployedCard,
          },
          "license":
          [
            {"type": "B", "idNumber": "B", "src": license},
          ],
          "professionalCard" :
          {
            "idNumber":"4414141444141144",
            "src":professionalCard,
          },
          "degrees":
          [
            {"name": "B","src": degrees},
          ],
          "workaddresse": workAddress,
        },
        options: Options(headers: {
          "Content-Type": "application/json",
          "X-Auth-Token": token,
        }));

    getTestDriveData();
    Get.offAll(() => ListCourseDrivePage());
  }

  Future<TestDrive> testDrive() async {
    response = await dio.get('${BaseURl}questions/search',
        queryParameters: {'type': 'testDriving'},
        options: Options(headers: {
          "Content-Type": "application/json",
          "X-Auth-Token": token
        }));
    return TestDrive.fromJson(response.data);
  }

  Future<List<QuestionDrive>> getTestDriveData() async {
    questionDriveList.clear();
    testDrive().then((value) {
      List<QuestionDrive>? all = value.questionTestDrive;
      all!.map((e) {
        questionDriveList.add(e);
      }).toList();
    });
    return questionDriveList;
  }

  Future answerTestDrive() async {
    response = await dio.post('${BaseURl}drivers/update',
        data: {"quizDrive": answerTestDriveList},
        options: Options(headers: {
          "Content-Type": "application/json",
          "X-Auth-Token": token,
        }));

    if (response.statusCode == 200) {
      log(response.data.toString());
    } else {
      print("Error");
    }
  }



  Future<List<dynamic>> getAllMissionsTypeOffer({required String typeOffer}) async {
    response = await dio.get('${BaseURl}missions/search',
        queryParameters: {"typeOffer":"ponctual"},
        options: Options(headers:
        {
          "Content-Type": "application/json",
          "X-Auth-Token": token,
        }));


    if (response.statusCode == 200)
    {
      //  listOfMissions = response.data as List<dynamic> ;
      //log(listOfMissions[0]["serveiceId"]);
    } else
    {
      print("Error");
    }

    return response.data;


  }


}
