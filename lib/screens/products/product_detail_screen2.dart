// @dart=2.9
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mandaos/models/product.dart';
import 'package:mandaos/screens/products/modify_product_screen.dart';
import 'package:mandaos/services/product_provider.dart';
import 'package:mandaos/utils/constants.dart';
import 'package:provider/provider.dart';

class ProductDetailScreen2 extends StatelessWidget {
  final Product product;

  ProductDetailScreen2(this.product);

  @override
  Widget build(BuildContext context) {
    // String sub = product.cuota.toString() + " " + product.um + " por persona";
    //String sub2 = product.cuota.toString() + " por persona";


    String total =
        "\$ " + product.price.toStringAsFixed(2) + " CUP por " + product.um;
    Size size = MediaQuery
        .of(context)
        .size;

    double t = product.price * product.cuota;
    double price1 = (t * 1);
    double price2 = (t * 2);
    double price3 = t * 3;
    double price4 = t * 4;
    double price5 = t * 5;
    double price6 = t * 6;
    //double price7 = t * 7;
    final _prodProvider = Provider.of<ProductProvider>(context, listen: false);

    Widget _people(){

      return Column(
        children: [
          Container(
            padding: EdgeInsets.all(10),
            child: Row(
              mainAxisAlignment:
              MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  children: [
                    Row(
                      mainAxisAlignment:
                      MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          mainAxisAlignment:
                          MainAxisAlignment.center,
                          children: [
                            Text(
                              '1 ',
                              style: TextStyle(
                                  color: kSecondaryColor,
                                  fontSize: 14),
                            ),
                            Icon(
                              CupertinoIcons.person_alt,
                              color: kSecondaryColor,
                              size: 20,
                            )
                          ],
                        ),
                      ],
                    ),
                    Chip(
                      backgroundColor: Colors.white,
                      labelPadding: EdgeInsets.all(0.5),
                      label: Text(
                        '\$ ' +
                            price1.toStringAsFixed(2) +
                            ' CUP ',
                        style: TextStyle(
                            fontSize: 11,
                            color: kPrimaryColor,
                            fontWeight: FontWeight.bold),
                      ),
                    )
                  ],
                ),
                Column(
                  children: [
                    Row(
                      mainAxisAlignment:
                      MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          mainAxisAlignment:
                          MainAxisAlignment.center,
                          children: [
                            Text(
                              '2 ',
                              style: TextStyle(
                                  color: kSecondaryColor,
                                  fontSize: 14),
                            ),
                            Icon(
                              CupertinoIcons.person_alt,
                              color: kSecondaryColor,
                              size: 20,
                            )
                          ],
                        ),
                      ],
                    ),
                    Chip(
                      backgroundColor: Colors.white,
                      label: Text(
                        '\$ ' +
                            price2.toStringAsFixed(2) +
                            ' CUP ',
                        style: TextStyle(
                            fontSize: 11,
                            color: kPrimaryColor,
                            fontWeight: FontWeight.bold),
                      ),
                    )
                  ],
                ),
                Column(
                  children: [
                    Row(
                      mainAxisAlignment:
                      MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          mainAxisAlignment:
                          MainAxisAlignment.center,
                          children: [
                            Text(
                              '3 ',
                              style: TextStyle(
                                  color: kSecondaryColor,
                                  fontSize: 14),
                            ),
                            Icon(
                              CupertinoIcons.person_alt,
                              color: kSecondaryColor,
                              size: 20,
                            )
                          ],
                        ),
                      ],
                    ),
                    Chip(
                      backgroundColor: Colors.white,
                      label: Text(
                        '\$ ' +
                            price3.toStringAsFixed(2) +
                            ' CUP ',
                        style: TextStyle(
                            fontSize: 11,
                            color: kPrimaryColor,
                            fontWeight: FontWeight.bold),
                      ),
                    )
                  ],
                ),
              ],
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Container(
            padding: EdgeInsets.all(10),
            child: Row(
              mainAxisAlignment:
              MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  children: [
                    Row(
                      mainAxisAlignment:
                      MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          mainAxisAlignment:
                          MainAxisAlignment.center,
                          children: [
                            Text(
                              '4 ',
                              style: TextStyle(
                                  color: kSecondaryColor,
                                  fontSize: 14),
                            ),
                            Icon(
                              CupertinoIcons.person_alt,
                              color: kSecondaryColor,
                              size: 20,
                            )
                          ],
                        ),
                      ],
                    ),
                    Chip(
                      backgroundColor: Colors.white,
                      labelPadding: EdgeInsets.all(0.5),
                      label: Text(
                        '\$ ' +
                            price4.toStringAsFixed(2) +
                            ' CUP ',
                        style: TextStyle(
                            fontSize: 11,
                            color: kPrimaryColor,
                            fontWeight: FontWeight.bold),
                      ),
                    )
                  ],
                ),
                Column(
                  children: [
                    Row(
                      mainAxisAlignment:
                      MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          mainAxisAlignment:
                          MainAxisAlignment.center,
                          children: [
                            Text(
                              '5 ',
                              style: TextStyle(
                                  color: kSecondaryColor,
                                  fontSize: 14),
                            ),
                            Icon(
                              CupertinoIcons.person_alt,
                              color: kSecondaryColor,
                              size: 20,
                            )
                          ],
                        ),
                      ],
                    ),
                    Chip(
                      backgroundColor: Colors.white,
                      label: Text(
                        '\$ ' +
                            price5.toStringAsFixed(2) +
                            ' CUP ',
                        style: TextStyle(
                            fontSize: 11,
                            color: kPrimaryColor,
                            fontWeight: FontWeight.bold),
                      ),
                    )
                  ],
                ),
                Column(
                  children: [
                    Row(
                      mainAxisAlignment:
                      MainAxisAlignment.spaceBetween,
                      crossAxisAlignment:
                      CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Text(
                              '6 ',
                              style: TextStyle(
                                  color: kSecondaryColor,
                                  fontSize: 14),
                            ),
                            Icon(
                              CupertinoIcons.person_alt,
                              color: kSecondaryColor,
                              size: 20,
                            )
                          ],
                        ),
                      ],
                    ),
                    Chip(
                      backgroundColor: Colors.white,
                      label: Text(
                        '\$ ' +
                            price6.toStringAsFixed(2) +
                            ' CUP ',
                        style: TextStyle(
                            fontSize: 11,
                            color: kPrimaryColor,
                            fontWeight: FontWeight.bold),
                      ),
                    )
                  ],
                ),
              ],
            ),
          ),
        ],
      );
    }

    return Scaffold(
      appBar: AppBar(),


      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      backgroundColor: kPrimaryColor,
      //floatingActionButtonAnimator: FloatingActionButtonAnimator.scaling,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => ModifyProductScreen(product)),
          );
        },
       // heroTag: "modify-"+ product.id.toString(),
        child: Icon(
          Icons.edit,
          size: 32,
          color: Colors.white,
        ),
        backgroundColor: Colors.redAccent,
        elevation: 30,
        tooltip: 'Haga clic para modificar el producto',
        hoverColor: kSecondaryColor,
      ),

      resizeToAvoidBottomInset: false,
      body: ListView(


        children: [
          Container(
            height: size.height * 0.35,

            child:

            Stack(

              children: [

                Container(
                  height: size.height * 0.35,

                  child: Hero(

                    //transitionOnUserGestures: true,
                    tag: "hero-" + product.id.toString() + product.title,
                    child: Image.asset(
                      product.img,
                      fit: BoxFit.fill,
                      width: double.infinity,

                    ),
                  ),
                ),
               /* Positioned(
                    right: 0,
                    bottom: 0,

                    child:

                    Container(
                      width: size.width * 0.85,
                      alignment: Alignment.center,
                      padding: EdgeInsets.only(left: 20, right: 10, bottom: 10,top: 10),
                      height: 70,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(50),
                            topLeft: Radius.circular(50),
                          ),
                          boxShadow: [BoxShadow(
                            offset: Offset(0, 5),
                            blurRadius: 5,
                            color: kPrimaryColor.withOpacity(.5),

                          )
                          ]
                      ),

                      child:

                      Text(
                        product.title,
                        maxLines: 2,
                        style: TextStyle(fontSize: 16,

                            color: kPrimaryColor,
                            fontWeight: FontWeight.normal
                        ),
                      ),
                    )),*/

                SafeArea(child: Container(

                    decoration: BoxDecoration(
                        color: kPrimaryColor.withOpacity(.5),
                        borderRadius: BorderRadius.only(bottomRight: Radius.circular(30))
                    ),


                    child: BackButton(color: Colors.white,)),),

              ],
            ),
          ),
          Column(
            children: [


              Container(
                padding:
                EdgeInsets.only(left: 10, right: 10, top: 20, bottom: 0),
                margin: EdgeInsets.zero,
               //height: double.minPositive,
                decoration: BoxDecoration(
                  //borderRadius: BorderRadius.only(topRight: Radius.circular(30), topLeft: Radius.circular(30)),
                  //boxShadow: [BoxShadow(color: Colors.black26, blurRadius: 30, spreadRadius: 50)],

                  //borderRadius: BorderRadius.all(Radius.circular(20)),
                  // boxShadow: [BoxShadow(color: Colors.black38, blurRadius: -10,offset: Offset(0,5))]

                  //borderRadius: BorderRadius.only(topLeft: Radius.circular(20), topRight: Radius.circular(20))
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(5),
                          child: Column(
                            children: [
                              /*Text(
                                  'Datos por consumidor',
                                  style: TextStyle(
                                    color: kSecondaryColor,
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),*/
                              Column(
                                mainAxisAlignment:
                                MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                    CrossAxisAlignment.start,

                                    children: [
                                      Text(

                                        product.title,
                                        maxLines: 2,
                                        style: TextStyle(fontSize: 20,

                                            color: Colors.white,
                                            fontWeight: FontWeight.normal
                                        ),),
                                      Divider(height: 20,color: Colors.white,),

                                      Text(
                                        'Cuota',
                                        style: TextStyle(
                                          color: kSecondaryColor.withOpacity(.7),
                                          fontSize: 12,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        children: [
                                          Text(

                                            product.cuota.toString() +
                                                ' ' +
                                                product.um + ' por ',
                                            style: TextStyle(
                                                color: kSecondaryColor,
                                                fontWeight: FontWeight.bold,
                                                fontSize: 16),
                                          ),
                                          Icon(CupertinoIcons.person_alt,color: kSecondaryColor,)
                                        ],
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 10,),
                                  Column(
                                    crossAxisAlignment:
                                    CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Precio',
                                        style: TextStyle(
                                          color: kSecondaryColor.withOpacity(.7),
                                          fontSize: 12,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      FittedBox(
                                        fit: BoxFit.fitWidth,
                                        child: Text(
                                          total,
                                          maxLines: 2,
                                          overflow: TextOverflow.ellipsis,
                                          style: TextStyle(
                                              color: kSecondaryColor,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 16),
                                        ),
                                      )
                                    ],
                                  ),
                                ],
                              ),

                              // Text(product.um == 'uno'? sub : sub2),
                            ],
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Container(
                          //padding: EdgeInsets.all(20),
                          decoration: BoxDecoration(
                              borderRadius:
                              BorderRadius.all(Radius.circular(15)),
                              color: Colors.black26,
                              boxShadow: [
                                BoxShadow(
                                    color: Colors.black26,
                                    blurRadius: 6,
                                    offset: Offset(0, 5))
                              ]),
                          child: _people()
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ElevatedButton(
                          onPressed: () {
                            _prodProvider.addToCatalog(product);

                            //Navigator.of(context).pop();

                            final snackBar = SnackBar(
                              content: Text('Se añadió el producto.'),
                              action: SnackBarAction(
                                label: 'ok',
                                onPressed: () {
                                  // Navigator.of(context).pop();
                                },
                              ),
                            );

                            ScaffoldMessenger.of(context)
                                .showSnackBar(snackBar);
                          },

                          style: ButtonStyle(
                              backgroundColor:
                              MaterialStateProperty.all(kotherColor),
                              padding: MaterialStateProperty.all(
                                  EdgeInsets.all(10)),
                              shadowColor:  MaterialStateProperty.all(kSecondaryColor),
                              elevation:  MaterialStateProperty.all(10),
                              shape:  MaterialStateProperty.all<RoundedRectangleBorder>(RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  //side: BorderSide(color: kPrimaryColor)
                              ))
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,

                            children: [
                              Padding(
                                padding: const EdgeInsets.only(right: 15),
                                child: Text(
                                  'Añadir al Carrito',
                                  style: TextStyle(color: kPrimaryColor),
                                ),
                              ),
                              Icon(
                                CupertinoIcons.cart_fill_badge_plus,
                                color: kPrimaryColor,

                              ),

                            ],
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 20,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );


  }

}


