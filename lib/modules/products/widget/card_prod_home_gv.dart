import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:mandaos/modules/products/models/product.dart';
import 'package:mandaos/utils/constants.dart';

class CardProductHomeGV extends StatelessWidget {
  CardProductHomeGV({required this.product, required this.cantPeople});

  final Product product;
  final int cantPeople;

  @override
  Widget build(BuildContext context) {
    timeDilation = 2.5;
    String sub2 = product.cuota.toString().replaceAll(RegExp(r"([.]*0+)(?!.*\d)"), "") + " por persona";
    String sub = product.cuota.toString().replaceAll(RegExp(r"([.]*0+)(?!.*\d)"), "") + " " + product.um + " por persona";

    Size size = MediaQuery.of(context).size;
    double result = size.height - AppBar().preferredSize.height;

    return ClipRRect(
      borderRadius: BorderRadius.only(
          bottomRight: Radius.circular(20),
          bottomLeft: Radius.circular(20),
          topRight: Radius.circular(20)),
      child: Container(
        decoration: BoxDecoration(color: Colors.white),
        child: GestureDetector(
          onTap: () {

            Navigator.pushNamed(context, 'productdetail',arguments: product);

          },
          child: Stack(
            fit: StackFit.expand,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Hero(
                    tag: "hero-" + product.id.toString() + product.title,
                    transitionOnUserGestures: true,
                    child: Image.asset(
                      product.img,
                      fit: BoxFit.fill,
                      width: double.infinity,
                      height: result >= 480 ? 120 : 100,
                    ),
                  ),
                  Container(
                    width: double.infinity,
                    padding: EdgeInsets.all(5),
                    decoration: BoxDecoration(
                        border: Border(
                      top: BorderSide(
                        color: kSecondaryColor,
                      ),
                    )),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          product.title,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          textAlign: TextAlign.start,
                          style: TextStyle(
                              color: kPrimaryColor,
                              fontSize: 12,
                              fontFamily: 'UbuntuRegular'),
                        ),
                        Text(
                          product.um == 'uno' ? sub2 : sub,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          textAlign: TextAlign.start,
                          style: TextStyle(
                              color: Colors.black26,
                              fontSize: 10,
                              fontFamily: 'UbuntuRegular'),
                        )
                      ],
                    ),
                  ),
                ],
              ),
              Positioned(
                top: 5,
                right: 5,
                child: new Container(
                  padding: EdgeInsets.all(5),
                  decoration: new BoxDecoration(
                    boxShadow: [
                      BoxShadow(color: Colors.black38, offset: Offset(0, 2))
                    ],
                    color: Colors.deepOrange,
                    borderRadius: BorderRadius.only(
                        topRight: Radius.circular(15),
                        bottomLeft: Radius.circular(15)),
                  ),
                  constraints: BoxConstraints(
                    minWidth: 50,
                    minHeight: 10,
                  ),
                  child: Text(

                    (product.price * product.cuota).toStringAsFixed(2).replaceAll(RegExp(r"([.]*0+)(?!.*\d)"), "") + ' CUP',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'UbuntuRegular',
                      fontSize: 10,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ],
          ),
        ),

        //),
      ),
    );
  }
}
