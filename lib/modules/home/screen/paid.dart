import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:mandaos/utils/constants.dart';

class Paid extends StatelessWidget {
  const Paid({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kPrimaryColor,

      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(CupertinoIcons.info_circle_fill, size: 80,color: kSecondaryColor,),
          SizedBox(height: 20,),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Text('Error debe tener instalada Apklis y realizar la compra para poder utilizar Mis mandaos.',
            style: TextStyle(color: Colors.white, fontSize: 24),
            ),
          )
        ],
      ),
    );
  }
}
