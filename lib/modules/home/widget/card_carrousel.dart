import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mandaos/modules/products/models/product.dart';
import 'package:mandaos/modules/products/screen/product_detail_screen.dart';

class CardCarrousel extends StatelessWidget {
  // const CardCarrousel({Key? key}) : super(key: key);
  final Product prod;

  CardCarrousel({required this.prod});

  @override
  Widget build(BuildContext context) {
   // Size size = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, 'productdetail',arguments: prod);
      },
      child:

      /*Hero(
        tag: "hero-" + prod.id.toString() + prod.title,
        child: */

        Container(
          margin: EdgeInsets.all(5),

          decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(prod.img),
                fit: BoxFit.fill,
              ),
              //color: kPrimaryColor,
              boxShadow: [
                BoxShadow(
                    color: Colors.black38,
                    spreadRadius: 1,
                    blurRadius: 1,
                    offset: Offset(0, 1))
              ],
              borderRadius: BorderRadius.all(Radius.circular(30))),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                child: SizedBox(
                  height: 300,
                  child: FittedBox(
                    fit: BoxFit.fitWidth,
                    child: Container(
                      padding: EdgeInsets.all(10),
                      margin: EdgeInsets.only(bottom: 10),
                      child: Text(
                        prod.title,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 2,
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'UbuntuRegular',
                          fontSize: 16,
                          decoration: TextDecoration.none,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                ),
                decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomLeft,
                      colors: [
                        Colors.transparent,
                        Colors.black54,
                      ],
                    ),

                    //color: kPrimaryColor,

                    borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(30),
                        bottomRight: Radius.circular(30))),
                width: double.infinity,
                height: 50,
                alignment: Alignment.center,
              ),
            ],
          ),
        ),
      //),
    );
  }
}
