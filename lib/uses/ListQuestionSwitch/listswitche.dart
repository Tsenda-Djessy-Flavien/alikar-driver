import 'dart:developer';

import 'package:alikardriver/Controller/AppController/appcontroller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';


class ListSwitch extends StatefulWidget {
  final String label;
  final int index;
  bool value = false;


   ListSwitch({Key? key, required this.label,required this.index}) : super(key: key);

  @override
  _ListSwitcheState createState() => _ListSwitcheState();


}

class _ListSwitcheState extends State<ListSwitch> {
  AppController appController = Get.find();

//estTutorSite site = BestTutorSite.javatpoint;
//BestTutorSite site = BestTutorSite.javatpoint;
bool site = false ;
bool site1 = true ;

  @override
  Widget build(BuildContext context) {


    return  Container(
      height: 50,
      width: MediaQuery.of(context).size.width,
      child:  Padding(
        padding: const EdgeInsets.all(10),
        child: Row(
          children: [
            Text(widget.label),
            Spacer(),
            Radio(
              value:widget.value,
              groupValue: site1,
              fillColor: MaterialStateColor.resolveWith((states) => Colors.orange),
              focusColor: MaterialStateColor.resolveWith((states) => Colors.orange),
              onChanged: (bool? value)
              {
                setState(()
                {

                  site = value!;
                  log(value.toString());
                  log(widget.label.toString());
                });
              },
            ),
            Radio(
              value: widget.value,
              groupValue: site,
              fillColor: MaterialStateColor.resolveWith((states) => Colors.orange),
              focusColor: MaterialStateColor.resolveWith((states) => Colors.orange),
              onChanged: (bool? value) {
                setState(()
                {
                  site1 = value!;
                  site1 = site;
                  log(widget.label.toString());
                  log(value.toString());
                });
              },
            ),
          ],
        ),
      ),
    );
    /*ListTile(
      leading: Text(widget.label) ,
      trailing: Switch(value: widget.value,onChanged: (bool change)
      {
        if(widget.value == false)
        {
          setState(()
          {
            widget.value = true;
            print(".................................");
            print("${appController.answerTestInfoList}");
            updateValue(index: widget.index,key: "value",listUpdate: appController.answerTestInfoList,newValue: widget.value);
            print(".................................");
            print("${appController.answerTestInfoList}");

          });

        }
        else
        {
          setState(() {
            widget.value = false;
            print(".................................");
            print("${appController.answerTestInfoList}");
            updateValue(index: widget.index,key: "value",listUpdate: appController.answerTestInfoList,newValue: widget.value);
            print(".................................");
            print("${appController.answerTestInfoList}");
          });
        }

      },),
    );*/
  }

  void updateValue({required int index,required String key,required List listUpdate, required bool newValue})
  {
    listUpdate[index].update(key, (value) =>  newValue, ifAbsent: () => false);
  }
}
enum BestTutorSite {javatpoint, w3schools, tutorialandexample }
