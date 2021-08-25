import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'constants.dart';

void Message(String message, BuildContext context){
  showDialog(
    barrierColor: Colors.black38,
      barrierDismissible: false,

      context: context,
      builder: (_) => new AlertDialog(
        buttonPadding: EdgeInsets.all(5),
        titlePadding: EdgeInsets.only(bottom: 10,right: 20, left: 20, top: 10),

        content: Text(
          message,
          style: TextStyle(color: kPrimaryColor, fontSize: 14, fontFamily: 'UbuntuRegular', fontWeight: FontWeight.bold),
        ),
        actions: [
          Divider(height: 10,),
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },

            child: Center(child: Text('Aceptar',style: TextStyle(color: Colors.blueAccent, fontSize: 14, fontFamily: 'UbuntuRegular'))),

          ),

        ],
      ));
}
