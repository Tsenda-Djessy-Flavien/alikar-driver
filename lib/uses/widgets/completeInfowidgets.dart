import 'package:alikardriver/Controller/AppController/appcontroller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

final appController = Get.put(AppController());

Widget listTileSubTile(
    {required String imagePath, required void Function()? onTap}) {
  return Padding(
    padding: const EdgeInsets.all(10),
    child: Container(
      height: 80,
      decoration: BoxDecoration(
          border: Border.all(color: Colors.grey, width: 1),
          borderRadius: BorderRadius.circular(10)),
      child: Center(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Image.asset(imagePath),
            InkWell(
              onTap: onTap,
              child: Container(
                  child: const Center(
                    child: Text("Upload"),
                  ),
                  height: 25,
                  width: 90,
                  decoration: BoxDecoration(
                      color: Colors.orange,
                      borderRadius: BorderRadius.circular(10))),
            )
          ],
        ),
      ),
    ),
  );
}

Widget listTileListTile(
    {required String imagePath,
    required String title,
    required void Function()? onTap,
    required bool values}) {
  return ListTile(
      leading: Image.asset(imagePath),
      title: Text(title),
      subtitle: const Text("Upload the in PDF format"),
      trailing: const Icon(
        Icons.arrow_drop_down_sharp,
        size: 25,
      ),
      onTap: onTap);
}
