import 'package:flutter/material.dart';
import 'package:mandaos/utils/constants.dart';

ThemeData darkThemeData(BuildContext context){

  return ThemeData.dark().copyWith(
    primaryColor: kSecondaryColor,
    backgroundColor: kotherColor,
    brightness: Brightness.light
  );

}