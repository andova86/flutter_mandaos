import 'package:flutter/material.dart';

class Paid extends StatelessWidget {
  const Paid({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child:
        Text('Debe instalar Apklis para utilizar la aplicación.'),
      ),
    );
  }
}
