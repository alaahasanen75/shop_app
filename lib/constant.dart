// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:flutter_application_1/modules.dart/login_scrren.dart';
import 'package:flutter_application_1/shared_prefrance.dart';
import 'package:fluttertoast/fluttertoast.dart';

const defaulltColor = Colors.deepOrange;

void ShowToast({required String? msg, required ToastStates? states}) {
  Fluttertoast.showToast(
      msg: msg!,
      //  state.model!.masage!,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 5,
      backgroundColor: ChooseToastColor(states!),
      textColor: Colors.black,
      fontSize: 16.0);
}

enum ToastStates { SUCCESS, ERROR, WARNING }

Color? ChooseToastColor(ToastStates states) {
  Color color;

  switch (states) {
    case ToastStates.SUCCESS:
      color = Colors.green;
      break;
    case ToastStates.ERROR:
      color = Colors.red;
      break;
    case ToastStates.WARNING:
      color = Colors.amber;
      break;
  }
  return color;
}

void SignOut(context) {
  
    

      CachHelper.removeData(key: 'token').then((value) {
        if (value!) {
          Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: ((context) => Shoplogin())),
              (route) => false);
        }
      });
    
  
}

String? token = '';
Widget MyProvider() => Padding(
      padding: const EdgeInsets.symmetric(horizontal: 5),
      child: Container(
        height: 1,
        width: double.infinity,
        color: Colors.grey[300],
      ),
    );
