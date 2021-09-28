import 'package:flutter/material.dart';
import 'package:mandaos/modules/home/screen/splash_screen.dart';

class HelpScreen extends StatelessWidget {


  @override
  Widget build(BuildContext context) {

    Size size = MediaQuery.of(context).size;
    return Scaffold(
      resizeToAvoidBottomInset: false,

      body: SafeArea(

        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: SplashScreen(),
        )


      ),
    );
  }
}
