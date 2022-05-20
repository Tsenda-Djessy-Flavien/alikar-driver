import 'package:flutter/material.dart';

Widget myFormField({
  TextEditingController? controller,
  String? labelText,
  String? hintText,
  String? pathImage,
  Function? validate,
  Widget? prefixIcon,
  IconData? suffixIcon,
  Function? onChange,
  Function? onSubmit,
  Function? onTap,
  TextInputType? type,
  bool isPass = false,
  Function? suffixPressed,
  bool isClickable = true,

}) {
  return SizedBox(
    child: Row(
      children: [
        Image.asset(pathImage!),
        SizedBox(width: 15,),
        Expanded(
          child: TextFormField(
            obscureText: isPass ? true : false,
            controller: controller,
            cursorColor: Colors.black,
            decoration: InputDecoration(
             // filled: true,
              labelText: labelText,
              hintText: hintText,
              labelStyle: const TextStyle(color: Colors.white),
              prefixIcon: prefixIcon,

            ),
            validator: (value) => validate!(value),
            onFieldSubmitted: (value) => onSubmit!(value),
            keyboardType: type,
          ),
        ),
      ],
    ),
  );
}


//#1A237880



Widget loginButton(
    {required String textButton,
      required Function() functionPressing,
      required ButtonStyle styleButton,required Color textColor}) {
  return SizedBox(
    height: 45,
    width: 228,
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

final ButtonStyle loginButtonStyle = ButtonStyle(
  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
    RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(25),

    ),

  ),
  backgroundColor: MaterialStateProperty.all(Color(0xff03a9f4)),
);


