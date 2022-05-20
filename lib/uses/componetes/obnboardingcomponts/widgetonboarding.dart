
import 'package:alikardriver/View/AliKarOnBoarding/onboardingmodel.dart';
import 'package:flutter/material.dart';

Widget buildBoardingItem({required BuildContext context,required BoardingModel model,required int index}) =>
    Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children:
        [
          Image.asset(model.image,height: MediaQuery.of(context).size.height/3,width: MediaQuery.of(context).size.width/4,),
          //Text(model.title, style: const TextStyle(fontSize: 16,fontWeight: FontWeight.bold),textAlign: TextAlign.center,),
          Wrap(
            children: [
              Text(model.body, style: const TextStyle(fontSize: 17,height: 1.3),textAlign: TextAlign.center,),
            ],
          ),
          const SizedBox(height: 40,),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(
              boarding.length,
                  (index) => animatedPage(index: index),
            ),
          ),
        ]);


AnimatedContainer animatedPage({required int index}) => AnimatedContainer(
  duration: const Duration(milliseconds: 150),
  margin: const EdgeInsets.only(right: 5),
  height:  currentPage == index ? 20: 15,
  width:  currentPage == index ? 20 : 15,
  child: Center(child:
  Container(
    height: 8,
    width: 8,
    decoration: BoxDecoration(
      color:  currentPage == index ? Color(0xFF7988b9): Colors.transparent,
      borderRadius: BorderRadius.circular(10),
    ),),),
  decoration: BoxDecoration(
    color: Color(0xFFd8ecfb) ,
    //color:  currentPage == index ? Colors.indigoAccent : Colors.indigo,
    borderRadius: BorderRadius.circular(10),
  ),
);


Widget bottomDotedBar({required BuildContext context}) {
  return Row(
    mainAxisSize: MainAxisSize.max,
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      if (isLastOnBoarding == false)
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: TextButton(
              onPressed: () => submit(context),
              child: const Padding(
                padding: EdgeInsets.symmetric(horizontal: 10),
                child: Text(
                  "skip",
                  style: TextStyle(
                      color: Colors.black, height: 1),
                ),
              )),
        ),
      if (isLastOnBoarding == true)
        SizedBox(width: MediaQuery.of(context).size.width/3-30),
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: List.generate(
          boarding.length,
              (index) => animatedPage(index: index),
        ),
      ),
      if (isLastOnBoarding == false)
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 13),
          child: Container(
            height: 35,
            width: 50,
            clipBehavior: Clip.antiAliasWithSaveLayer,
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(10)),
            ),
            child: TextButton(
              child:const Icon(Icons.arrow_forward,color: Colors.black,),
              onPressed: () {
                if (isLastOnBoarding == true) {
                  submit(context);
                } else {
                  boarderController.nextPage(
                      duration: const Duration(milliseconds: 150),
                      curve: Curves.fastLinearToSlowEaseIn);
                }
              },

            ),
          ),
        ),
      if (isLastOnBoarding == true)
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 13),
          child: TextButton(
            child:const Text("Done",style: const TextStyle(color: Colors.black),),
            onPressed: () {
              if (isLastOnBoarding == true) {
                submit(context);
              } else {
                boarderController.nextPage(
                    duration: const Duration(milliseconds: 150),
                    curve: Curves.fastLinearToSlowEaseIn);
              }
            },

          ),
        ),
    ],
  );

}


// this  styles for the 2 page => onBoarding
final ButtonStyle onBoardingButtonStyle = ElevatedButton.styleFrom(
  primary: Colors.indigoAccent,
  onPrimary: Colors.white,
);



final ButtonStyle registerButtonStyleWelcome = ButtonStyle(
  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
    RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(25),

    ),
  ),
  backgroundColor: MaterialStateProperty.all(Color(0xffabe3fb)),
);




final ButtonStyle loginButtonStyleWelcome = ButtonStyle(
  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
    RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(30),
    ),
  ),
  backgroundColor: MaterialStateProperty.all(Colors.white),
);


Widget XButtonWelcome(
    {required String textButton,
      required Function() functionPressing,
      required ButtonStyle styleButton,required Color textColor}) {
  return SizedBox(
    height: 45,
    width: 128,
    child: ElevatedButton(
      child: Text(
        textButton,
        style:  TextStyle(fontWeight: FontWeight.bold ,fontSize: 15,color:textColor),
      ),
      style: styleButton,
      onPressed: functionPressing,
    ),
  );
}