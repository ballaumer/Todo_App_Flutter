import 'package:flutter/material.dart';
import 'package:todo/utils/textstyle.dart';

TextFormField textFormField({required String hintText,required TextEditingController controller,}){
  return     TextFormField(
    controller: controller,
    decoration: InputDecoration(
      hintText: hintText,
      hintStyle: textStyles(
          fontSize: 15,
          fontWeight: FontWeight.normal,
          color: Colors.white),
    ),
  );
}