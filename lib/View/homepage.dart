import 'package:alikardriver/View/DriverTrack/tracking.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {

  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return  Scaffold(body: Center(child: Column(
      children: [
        Text("FRGDGSGGGdrfegregregr"),

        ElevatedButton(onPressed: ()
        {
          Navigator.of(context).push(MaterialPageRoute(builder: (context)=>  TrackingPage()));
          },
            child: Text("Go to map"))
      ],
    ),),);
  }
}
