import 'package:alikardriver/View/DriveCompletInfo/CompletInfo.dart';
import 'package:alikardriver/uses/widgets/navigations.dart';
import 'package:flutter/material.dart';

class DriverProfileHeader extends StatelessWidget {
  const DriverProfileHeader({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Container(
              height: MediaQuery.of(context).size.height / 3,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                  color: const Color(0xff72cff9),
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 5,
                      blurRadius: 7,
                      offset: const Offset(0, 0.5),
                    ),
                  ]),
              child: Column(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 30),
                        child: InkWell(
                            onTap: () => goToCompleteInfoDrive(context),
                            child: const Icon(
                              Icons.arrow_back_ios,
                              size: 20,
                              color: Color(0xfff2f2f2),
                            )),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 20, right: 30),
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
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    mainAxisSize: MainAxisSize.max,
                    textDirection: TextDirection.ltr,
                    children: const [
                      Padding(
                        padding: EdgeInsets.only(top: 20, left: 30),
                        child: Text(
                          'Hi, User name',
                          style: TextStyle(
                            fontFamily: "Roboto",
                            color: Color(0xfff2f2f2),
                            fontSize: 25,
                            fontWeight: FontWeight.bold,
                          ),
                          textAlign: TextAlign.start,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    mainAxisSize: MainAxisSize.max,
                    textDirection: TextDirection.ltr,
                    children: const [
                      Padding(
                        padding: EdgeInsets.only(top: 10, left: 30),
                        child: Text(
                          'Lorem ipsum dolor sit amet',
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                          ),
                          textAlign: TextAlign.start,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            Expanded(
                child: Center(
                    child: Container(
                        width: MediaQuery.of(context).size.width / 1.3,
                        height: 130,
                        decoration: BoxDecoration(
                            border: Border.all(color: const Color(0xff72cff9)),
                            borderRadius: BorderRadius.circular(50)),
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(top: 20),
                              child: Center(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  mainAxisSize: MainAxisSize.max,
                                  children: [
                                    const Text(
                                      'Felicitation !',
                                      style: TextStyle(
                                          fontFamily: "Roboto",
                                          fontSize: 25,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    const Text('votre compte a été créer'),
                                    TextButton(
                                        style: ButtonStyle(
                                            shape: MaterialStateProperty.all(
                                                RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            30.0))),
                                            backgroundColor:
                                                MaterialStateProperty.all(
                                                    Colors.blue),
                                            side: MaterialStateProperty.all(
                                                const BorderSide(
                                                    width: 1,
                                                    color: Color(0xff72cff9))),
                                            padding: MaterialStateProperty.all(
                                                const EdgeInsets.symmetric(
                                                    vertical: 10,
                                                    horizontal: 30))),
                                        onPressed: () {},
                                        child: const Text(
                                          "D'accord Merci !",
                                          style: TextStyle(
                                              color: Color(0xfff2f2f2),
                                              fontWeight: FontWeight.bold),
                                        ))
                                  ],
                                ),
                              ),
                            )
                            // const Text(
                            //   'Felicitation !',
                            //   style: TextStyle(
                            //       fontSize: 22, fontWeight: FontWeight.bold),
                            // ),
                            // const Text('votre compte a été créer'),
                            // Padding(
                            //   padding: const EdgeInsets.only(top: 10),
                            //   child: Container(
                            //     width: 160,
                            //     height: 30,
                            //     decoration: BoxDecoration(
                            //         border: Border.all(
                            //             color: const Color(0xff72cff9)),
                            //         borderRadius: BorderRadius.circular(30)),
                            //   ),
                            // )
                          ],
                        )))),
          ],
        ),
      ),
      // Container(
      //   height: MediaQuery.of(context).size.height / 2.7,
      //   width: MediaQuery.of(context).size.width,
      //   decoration: BoxDecoration(
      //       color: const Color(0xff72cff9),
      //       borderRadius: BorderRadius.circular(20),
      //       boxShadow: [
      //         BoxShadow(
      //           color: Colors.grey.withOpacity(0.5),
      //           spreadRadius: 5,
      //           blurRadius: 7,
      //           offset: const Offset(0, 0.5),
      //         ),
      //       ]),
      //   child: Column(
      //     mainAxisSize: MainAxisSize.max,
      //     children: [
      //       Row(
      //         mainAxisSize: MainAxisSize.max,
      //         mainAxisAlignment: MainAxisAlignment.end,
      //         children: [
      //           Padding(
      //             padding: const EdgeInsets.only(top: 40, right: 30),
      //             child: Container(
      //               height: 77,
      //               width: 83,
      //               child: const Center(
      //                 child: Icon(
      //                   Icons.person_outlined,
      //                   size: 35,
      //                 ),
      //               ),
      //               decoration: BoxDecoration(
      //                   color: const Color(0xfff2f2f2),
      //                   borderRadius: BorderRadius.circular(10)),
      //             ),
      //           ),
      //         ],
      //       ),
      //       Row(
      //         mainAxisAlignment: MainAxisAlignment.start,
      //         mainAxisSize: MainAxisSize.max,
      //         textDirection: TextDirection.ltr,
      //         children: const [
      //           Padding(
      //             padding: EdgeInsets.only(top: 20, left: 30),
      //             child: Text(
      //               'Hi, User name',
      //               style: TextStyle(
      //                 color: Color(0xfff2f2f2),
      //                 fontSize: 22,
      //                 fontWeight: FontWeight.bold,
      //               ),
      //               textAlign: TextAlign.start,
      //             ),
      //           ),
      //         ],
      //       ),
      //       Row(
      //         mainAxisAlignment: MainAxisAlignment.start,
      //         mainAxisSize: MainAxisSize.max,
      //         textDirection: TextDirection.ltr,
      //         children: const [
      //           Padding(
      //             padding: EdgeInsets.only(top: 10, left: 30),
      //             child: Text(
      //               'Lorem ipsum dolor sit amet',
      //               style: TextStyle(
      //                 fontSize: 12,
      //                 fontWeight: FontWeight.bold,
      //               ),
      //               textAlign: TextAlign.start,
      //             ),
      //           ),
      //         ],
      //       ),
      //     ],
      //   ),
      // ),
    );
  }
}
