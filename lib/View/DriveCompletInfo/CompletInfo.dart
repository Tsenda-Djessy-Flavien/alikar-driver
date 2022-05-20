import 'dart:developer';

import 'package:alikardriver/Controller/AppController/appcontroller.dart';
import 'package:alikardriver/Model/UserModel/TestInfoModel.dart';
import 'package:alikardriver/View/DriverLogin/driverloginpage.dart';
import 'package:alikardriver/View/DriverProfile/driverProfileHeader.dart';
import 'package:alikardriver/View/takePictre/takepicture.dart';
import 'package:alikardriver/uses/componetes/registerlogincompontes/widgetregisterlogin.dart';
import 'package:alikardriver/uses/widgets/completeInfowidgets.dart';
import 'package:alikardriver/uses/widgets/navigations.dart';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../DriverCourseDrive/driverlistcoursepage.dart';
import '../DriverTestInfo/drivertestinfopage.dart';

class CompleteInfoDrive extends StatelessWidget {
  CompleteInfoDrive({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AppController>(builder: (appController) {
      return Scaffold(
        body: SafeArea(
            child: Column(
          children: [
            const SizedBox(
              height: 35,
            ),
            Row(
              children: [
                const SizedBox(
                  width: 15,
                ),
                // InkWell(
                //     onTap: () => goToTestInfoPage(context),
                //     child: const Icon(
                //       Icons.arrow_back_ios,
                //       size: 20,
                //     )),
                const SizedBox(
                  width: 15,
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Text(
                      "Ajouter Vos Documents",
                      style: TextStyle(
                          color: Colors.black,
                          fontFamily: "Roboto",
                          fontWeight: FontWeight.bold,
                          fontSize: 25,
                          height: 1),
                    ),
                    const SizedBox(
                      height: 2,
                    ),
                    Text(
                      " Create account by filling the form below .",
                      style: TextStyle(
                          color: Colors.black,
                          fontFamily: "Roboto",
                          fontWeight: FontWeight.bold,
                          fontSize: 10),
                    ),
                  ],
                )
              ],
            ),
            const SizedBox(
              height: 30,
            ),
            Expanded(
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 25),
                child: Form(
                  key: appController.completeInfoFormKey,
                  child: SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    child: Column(
                      children: [
                        InkWell(
                          onTap: () => appController.getImageFromLocale(
                              imageType: "personalImage"),
                          child: Container(
                            height: 77,
                            width: 83,
                            child: const Center(
                              child: Icon(
                                Icons.person_outlined,
                                size: 35,
                              ),
                            ),
                            decoration: BoxDecoration(
                                color: const Color(0xfff2f2f2),
                                borderRadius: BorderRadius.circular(10)),
                          ),
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        listTileListTile(
                            imagePath: "assets/icons/cin.png",
                            title: "CIN",
                            values: appController.showedCIN,
                            onTap: () {
                              appController.showedCIN =
                                  !appController.showedCIN;
                              log(appController.showedCIN.toString());
                              appController.update();
                            }),
                        if (appController.showedCIN)
                          myFormField(
                            pathImage: "assets/icons/cin.png",
                            controller: appController.completeInfoRipController,
                            validate: (String? value) {
                              if (value == null || value.isEmpty) {
                                return "emptyFailed";
                              } else {
                                return null;
                              }
                            },
                            type: TextInputType.number,
                            suffixIcon: Icons.payment_outlined,
                            hintText: "CIN",
                          ),
                        if (appController.showedCIN)
                          listTileSubTile(
                              imagePath: "assets/icons/cin.png",
                              onTap: () => log("good")),
                        listTileListTile(
                            imagePath: "assets/icons/cin.png",
                            title: "Permit",
                            values: appController.showedPermit,
                            onTap: () {
                              appController.showedPermit =
                                  !appController.showedPermit;
                              log(appController.showedPermit.toString());
                              appController.update();
                            }),
                        if (appController.showedPermit)
                          listTileSubTile(
                              imagePath: "assets/icons/cin.png",
                              onTap: () => log("good")),
                        listTileListTile(
                            imagePath: "assets/icons/cin.png",
                            title: "Permit",
                            values:
                                appController.showedJustificatifeDeResidence,
                            onTap: () {
                              appController.showedJustificatifeDeResidence =
                                  !appController.showedJustificatifeDeResidence;
                              log(appController.showedJustificatifeDeResidence
                                  .toString());
                              appController.update();
                            }),
                        if (appController.showedJustificatifeDeResidence)
                          listTileSubTile(
                              imagePath: "assets/icons/mail.png",
                              onTap: () => log("good")),
                        listTileListTile(
                            imagePath: "assets/icons/mail.png",
                            title: "carte Auto",
                            values: appController.showedCarteAuto,
                            onTap: () {
                              appController.showedCarteAuto =
                                  !appController.showedCarteAuto;
                              log(appController.showedCarteAuto.toString());
                              appController.update();
                            }),
                        if (appController.showedCarteAuto)
                          listTileSubTile(
                              imagePath: "assets/icons/cin.png",
                              onTap: () => log("good")),
                        const SizedBox(height: 10),
                        myFormField(
                          pathImage: "assets/icons/lock.png",
                          controller:
                              appController.completeInfoWorkAddressController,
                          validate: (String? value) {
                            if (value == null || value.isEmpty) {
                              return "emptyFailed";
                            } else {
                              return null;
                            }
                          },
                          type: TextInputType.text,
                          suffixIcon: Icons.work,
                          hintText: "Work Address",
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        ElevatedButton(
                            onPressed: () async {
                              final cameras = await availableCameras();
                              final firstCamera = cameras.first;
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => TakePictureScreen(
                                        camera: firstCamera,
                                      )));
                            },
                            child: const Text("From Camera")),
                        ElevatedButton(
                            onPressed: () {
                              appController.getImageFromLocale(
                                  imageType: "personalImage");
                            },
                            child: const Text("personalImage")),
                        ElevatedButton(
                            onPressed: () {
                              appController.getImageFromLocale(
                                  imageType: "idCardRecto");
                            },
                            child: const Text("idCardRecto")),
                        ElevatedButton(
                            onPressed: () {
                              appController.getImageFromLocale(
                                  imageType: "idCardVerso");
                            },
                            child: const Text("idCardVerso")),
                        ElevatedButton(
                            onPressed: () {
                              appController.getImageFromLocale(
                                  imageType: "anthropometricImage");
                            },
                            child: const Text("anthropometricImage")),
                        ElevatedButton(
                            onPressed: () {
                              appController.getImageFromLocale(
                                  imageType: "residenceCertificateRecto");
                            },
                            child: const Text("residenceCertificateRecto")),
                        ElevatedButton(
                            onPressed: () {
                              appController.getImageFromLocale(
                                  imageType: "residenceCertificateVerso");
                            },
                            child: const Text("residenceCertificateVerso")),
                        ElevatedButton(
                            onPressed: () {
                              appController.getImageFromLocale(
                                  imageType: "selfEmployedCardRecto");
                            },
                            child: const Text("selfEmployedCardRecto")),
                        ElevatedButton(
                            onPressed: () {
                              appController.getImageFromLocale(
                                  imageType: "selfEmployedCardVerso");
                            },
                            child: const Text("selfEmployedCardVerso")),
                        ElevatedButton(
                            onPressed: () {
                              appController.getImageFromLocale(
                                  imageType: "licenseRecto");
                            },
                            child: const Text("licenseRecto")),
                        ElevatedButton(
                            onPressed: () {
                              appController.getImageFromLocale(
                                  imageType: "licenseVerso");
                            },
                            child: const Text("licenseVerso")),
                        ElevatedButton(
                            onPressed: () {
                              appController.getImageFromLocale(
                                  imageType: "professionalCardRecto");
                            },
                            child: const Text("professionalCardRecto")),
                        ElevatedButton(
                            onPressed: () {
                              appController.getImageFromLocale(
                                  imageType: "professionalCardVerso");
                            },
                            child: const Text("professionalCardVerso")),
                        ElevatedButton(
                            onPressed: () {
                              appController.getImageFromLocale(
                                  imageType: "degrees");
                            },
                            child: const Text("degrees")),
                        const SizedBox(
                          height: 30,
                        ),
                        ElevatedButton(
                            onPressed: () {
                              //test
                              if (appController.completeInfoFormKey.currentState
                                      ?.validate() !=
                                  null) {
                                // appController.completeInfoDriver(rip:appController.completeInfoRipController.text, workAddress: appController.completeInfoWorkAddressController.text);

                                appController.getTestDriveData();
                                Get.offAll(() => ListCourseDrivePage());
                              }
                            },
                            child: const Text("Next")),
                        ElevatedButton(
                            onPressed: () {
                              final route = MaterialPageRoute(
                                  builder: (ctx) =>
                                      const DriverProfileHeader());
                              Navigator.push(context, route);
                            },
                            child: const Text('show profile'))
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        )),
      );
    });
  }
}
