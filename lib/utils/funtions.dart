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

void MessageSnackBar(String message, BuildContext context, IconData icon, Color colorIcon){
  final snackBar = SnackBar(
      duration: Duration(seconds: 1),
      content: Container(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(right: 5),
              child: Icon(
                icon,
                color: colorIcon,
              ),
            ),
             FittedBox(child: Text(message)),

          ],
        ),
      ));

  ScaffoldMessenger.of(context).showSnackBar(snackBar);

}
