import 'package:flutter/material.dart';
import 'package:mandaos/utils/constants.dart';

class BtnDefault extends StatelessWidget {
  const BtnDefault({Key? key, required this.text, required this.icon, required this.bgColor, required this.functionCallback}) : super(key: key);
  final String text;
  final IconData icon;
  final Color bgColor;
  final Function functionCallback;

  @override
  Widget build(BuildContext context) {

    return  ElevatedButton(
      onPressed: functionCallback(),
      style:

      ButtonStyle(
          backgroundColor:
          MaterialStateProperty.all(bgColor),
          padding: MaterialStateProperty.all(
              EdgeInsets.all(10)),
          shadowColor:
          MaterialStateProperty.all(kSecondaryColor),
          elevation: MaterialStateProperty.all(10),
          shape: MaterialStateProperty.all<
              RoundedRectangleBorder>(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
                //side: BorderSide(color: kPrimaryColor)
              ))),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.only(right: 15),
            child: Text(
              text,
              style: TextStyle(
                  color: kPrimaryColor,
                  fontFamily: 'UbuntuRegular',
                  fontWeight: FontWeight.bold),
            ),
          ),
          Icon(
            icon,
            color: kPrimaryColor,
          ),
        ],
      ),
    );
  }
}
