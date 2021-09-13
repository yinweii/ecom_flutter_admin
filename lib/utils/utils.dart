import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'dart:math';

class Utils {
  static void showToast(String message, {bool isLong: false}) {
    if (message != null) {
      Fluttertoast.showToast(
          msg: message,
          toastLength: isLong ? Toast.LENGTH_LONG : Toast.LENGTH_SHORT);
    }
  }

  static Future navigatePage(BuildContext context, Widget widget,
      {bool rootNavigator: false}) async {
    return Navigator.of(context, rootNavigator: rootNavigator).push(
      MaterialPageRoute(
        builder: (context) => widget,
      ),
    );
  }

  static Future navigatePop(BuildContext context) async {
    return Navigator.of(context).pop();
  }

  //validate email
  static String validateEmail(String email) {
    if (email.isEmpty) {
      return 'Email không được để trống!';
    }
    String pattern =
        r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+";
    RegExp regExp = RegExp(pattern);
    if (!regExp.hasMatch(email)) {
      return 'Email không đúng định dạng.';
    }
    return null;
  }

  // error text auth
  static String errorText(String error) {
    if (error.contains('A network error')) {
      return 'Không có kết nối internet :(';
    } else if (error.contains('The password is invalid')) {
      return 'Mật khẩu không chính xác!';
    } else if (error.contains('email-already-in-use')) {
      return 'Email đã được sử dụng';
    } else if (error.contains('operation-not-allowed')) {
      return 'Server error, please try again later :(';
    }
    return null;
  }

  //validate password
  static String validatePassword(String password) {
    return null;
  }

  //check image
  static bool imageOk(String url) {
    if (url.isEmpty) {
      return false;
    } else {
      return true;
    }
  }

  static Future navigateReplace(BuildContext context, Widget widget,
      {bool rootNavigator: false}) async {
    return Navigator.of(context, rootNavigator: rootNavigator)
        .pushReplacement(MaterialPageRoute(
      builder: (context) => widget,
    ));
  }

  //error auth
  static String changeText(String message, int number, String changeTo) {
    if (message.length > number) {
      return message.substring(0, number) + changeTo;
    } else {
      return message;
    }
  }

//format hour
  static String hourData(DateTime dateTime) {
    return DateFormat('hh:mm a').format(dateTime);
  }

//format day
  static String dayData(DateTime dateTime) {
    return DateFormat('EEE,dd').format(dateTime);
  }

  static double sizeHeight(BuildContext context) =>
      MediaQuery.of(context).size.height;
  static double sizeWidth(BuildContext context) =>
      MediaQuery.of(context).size.width;
}
