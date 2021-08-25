import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';


_incrementCounter() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  int counter = (prefs.getInt('counter') ?? 0);
  //print('Pressed $counter times.');
  await prefs.setInt('counter', counter);
}

var kPrimaryColor = Color(0xFF455A64);
var kSecondaryColor = Color(0xFFcfd8dc);
var kTextColor = Color(0xFF3C4046);
var kBackgroundColor = Color(0xFFF9F8FD);
var kotherColor = Color(0xFFECE0CE);

const double kDefaultPadding = 20.0;
var data = [
  ColorSelect(kPrimaryColor: Color(0xFF1A4A5A), kSecondaryColor: Color(0xFFBDD9D7), select: true),
  ColorSelect(kPrimaryColor: Color(0xFF005B90), kSecondaryColor: Color(0xFFAFD2E5), select: true),

];


class ColorSelect{
 var kPrimaryColor;
 var kSecondaryColor;
 bool select;
 ColorSelect({required this.kPrimaryColor, required this.kSecondaryColor, required this.select });
}


class ColorProvider with ChangeNotifier {
  void changeColor(int color) {

    if(color == 2)
      {
        kPrimaryColor = data[1].kPrimaryColor;
        kSecondaryColor = data[1].kSecondaryColor;
        notifyListeners();
        print(kPrimaryColor);
      }


  }
}

