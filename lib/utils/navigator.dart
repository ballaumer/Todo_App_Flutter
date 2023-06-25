import 'package:flutter/material.dart';

class Navi {
  static navigateTo(BuildContext context, page) async {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => page),
    );
  }

  static navigatePushRemoveTo(BuildContext context, page) async {
    Navigator.pushAndRemoveUntil(context,
        MaterialPageRoute(builder: (context) => page), (route) => false);
  }

  static navigateBack(BuildContext context) async {
    Navigator.pop(context);
  }
}
