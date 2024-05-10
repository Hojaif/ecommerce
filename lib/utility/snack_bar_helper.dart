import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SnackBarHelper {
  static void showErrorSnackBar(String message,{String title = "Error"}) {
    Get.snackbar(
      title,
      message,
      backgroundColor: Colors.red,
      colorText: Colors.white,
      borderRadius: 20,
      margin: EdgeInsets.symmetric(horizontal: 300),
      duration: Duration(seconds: 3),
      icon: Icon(Icons.error, color: Colors.white),
    );
  }

  static void showSuccessSnackBar(String message,{String title = "Success"}) {
    Get.snackbar(
      title,
      message,
      backgroundColor: Colors.green,
      colorText: Colors.white,
      borderRadius: 20,
      margin: EdgeInsets.symmetric(horizontal: 300),
      duration: Duration(seconds: 3),
      icon: Icon(Icons.check_circle, color: Colors.white),
    );
  }
}
