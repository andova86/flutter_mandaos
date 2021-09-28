


import 'package:flutter/material.dart';

import 'constants.dart';


class HeaderM extends StatelessWidget {


  final String title;
  final IconData ico;
  const HeaderM({required this.title, required this.ico});

  @override
  Widget build(BuildContext context) {

    print(' pinta el encabezado');
    return

      Container(
        height: MediaQuery.of(context).size.height * 0.15 ,
        width: double.infinity,
       // color: Colors.redAccent,
        child: CustomPaint(
          painter: _HeaderDiagonalPainter(),
          child: Column(children: [
            FittedBox(

              child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(right: 8.0, ),
                      child: Text(
                        title,
                        style: TextStyle(
                          fontFamily: 'UbuntuRegular',
                          fontSize: 30,
                          color: Colors.white,


                        ),
                      ),
                    ),
                    //Image.network('assets/img/pro.png'),
                    Icon(
                      ico,
                      size: 35,
                      color: kSecondaryColor,
                    ),
                  ],
                ),
              ),
            ),


          ],),
        ),
      );
  }
}


class _HeaderDiagonalPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    // TODO: implement paint

    final paint = Paint();
    paint.color = kPrimaryColor;
    paint.style = PaintingStyle.fill;
    paint.strokeWidth = 50;
    final path = new Path();
    //Dibujar
    //path.moveTo(0, size.height * 0.6);
    path.lineTo(0, size.height * 0.50);
    path.quadraticBezierTo(size.width * 0.4, size.height, size.width, size.height * 0.50);
    path.lineTo(size.width, 0);

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
