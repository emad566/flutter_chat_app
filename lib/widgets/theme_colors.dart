import 'package:flutter/material.dart';
import 'package:get/get.dart';

const Color whiteClr = Colors.white;
const Color blackClr = Colors.black;
var grey200 = Colors.grey[200];
const errorClr = Colors.red;
const primaryClr = Color(0xFF2B475E);
const Color darkGreyClr = Color(0xFF121212);
const Color darkHeaderClr = Color(0xFF424242);
const Color focusedBorderClr = Colors.green;

class ThemeColors{
  static Color get buttonText => Get.isDarkMode? whiteClr : blackClr;
  static Color get buttonBg => Get.isDarkMode? blackClr : whiteClr;
  static Color get snackBarSuccessBg => Get.isDarkMode? blackClr : Colors.green;
  static Color get snackBarFailBg => Get.isDarkMode? Colors.grey : Colors.red;
  static Color get chatInputText => Get.isDarkMode? whiteClr : blackClr;
  static Color get chatInputBg => Get.isDarkMode? darkGreyClr : whiteClr;
  static Color get chatInputBorder => Get.isDarkMode? whiteClr : blackClr;
  static Color get chatBg => Get.isDarkMode? Colors.black12 : whiteClr;
  static Color get chatItemBg => Get.isDarkMode? Colors.black : primaryClr.withOpacity(.8);
}