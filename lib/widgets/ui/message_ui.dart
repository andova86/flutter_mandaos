import 'package:flutter/material.dart';

class MessageUI extends StatelessWidget {
  //const MessageUI({Key? key}) : super(key: key);
  String message;
  int val;
  MessageUI({required this.message, required this.val});

  @override
  Widget build(BuildContext context) {
    return SnackBar(
        duration: Duration(seconds: 1),
        content:
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            val == 1 ? Icon(Icons.check, color: Colors.green,) :
            Icon(Icons.info_outline, color: Colors.red,),
            Padding(
              padding: const EdgeInsets.only(left: 10),
              child: Text(message,style: TextStyle(fontFamily: 'UbuntuRegular'),),
            ),
          ],
        )
    );
  }
}
