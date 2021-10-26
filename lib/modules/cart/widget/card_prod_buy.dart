import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mandaos/modules/products/models/product.dart';
import 'package:mandaos/modules/products/provider/product_provider.dart';
import 'package:mandaos/utils/constants.dart';
import 'package:provider/provider.dart';

class CardProductBuyHome extends StatefulWidget {
  CardProductBuyHome(
      {Key? key,
      required this.product,
      required this.peopleG,
      this.cantPeople = 1})
      : super(key: key);

  Product product;
  int cantPeople;
  bool peopleG;

  @override
  _CardProductBuyHomeState createState() => _CardProductBuyHomeState();
}

class _CardProductBuyHomeState extends State<CardProductBuyHome> {
  @override
  Widget build(BuildContext context) {
    double t = widget.product.price * widget.product.cuota * widget.cantPeople;
    final _prodProvider = Provider.of<ProductProvider>(context, listen: false);
    String total = "\$ " +
        t.toStringAsFixed(2).replaceAll(RegExp(r"([.]*0+)(?!.*\d)"), "") +
        " cup";
    double c = (widget.product.cuota * widget.cantPeople);

    /* return Container(
      decoration: BoxDecoration(


      ),

     // padding: EdgeInsets.all(10),
      child: SizedBox(
        height: 100,
        child:




        ListTile(

            title: Text(
              product.title,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                  fontSize: 14,
                fontFamily: 'UbuntuRegular',
                  fontWeight: FontWeight.bold,

                  color: kPrimaryColor,
                  ),
            ),
            subtitle: Text(
              total + " por " + c.toString().replaceAll(RegExp(r"([.]*0+)(?!.*\d)"), "")  + " " + product.um,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(fontSize: 14,fontFamily: 'UbuntuRegular' ,color: kPrimaryColor.withOpacity(.7)),
            ),
           trailing:
           CircleAvatar(
             maxRadius: 26,
             backgroundImage: AssetImage(product.img),
           ),


          leading: _cantProd(cant: cantPeople,),



        ),
      ),
    );*/

    return GestureDetector(
      child: Container(
        width: MediaQuery.of(context).size.width * 0.95,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              flex: 1,
              child: CircleAvatar(
                maxRadius: 40,
                backgroundImage: _backgroundImage2(widget.product.img),
              ),
            ),
            Expanded(
              flex: 2,
              child: Container(
                padding: EdgeInsets.all(10),
                width: MediaQuery.of(context).size.width * 0.45,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.product.title,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: 14,
                        fontFamily: 'UbuntuRegular',
                        fontWeight: FontWeight.bold,
                        color: kPrimaryColor,
                      ),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Text(
                      total +
                          " por " +
                          c.toStringAsFixed(2).replaceAll(RegExp(r"([.]*0+)(?!.*\d)"), "") +
                          " " +
                          widget.product.um,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                          fontSize: 14,
                          fontFamily: 'UbuntuRegular',
                          color: kPrimaryColor.withOpacity(.7)),
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
                flex: 0,
                child: Container(
                  padding: EdgeInsets.zero,
                  margin: EdgeInsets.zero,
                  decoration: BoxDecoration(
                    color: kPrimaryColor.withOpacity(.8),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  width: 45,
                  height: 100,
                  child: Column(
                    children: [
                      Expanded(
                        flex: 1,
                        child: IconButton(
                            onPressed: () {
                              setState(() {
                                widget.peopleG == true
                                    ? widget.cantPeople = widget.cantPeople + 1
                                    : widget.cantPeople =
                                        widget.product.people + 1;
                              });
//print('La cantidad es: ${widget.cantPeople} de ${widget.product.title}');
                              print('Anterior: ${widget.product.people}');
                              widget.product.people = widget.cantPeople;
                              print('Despues: ${widget.product.people}');

                              _prodProvider.updateToCatalog(widget.product);
                              print('La cantidad es: ${_prodProvider.total()}');
                            },
                            icon: Icon(
                              Icons.add_circle,
                              color: Colors.white,
                              size: 30,
                            )),
                      ),
                      Expanded(
                          flex: 0,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Text(
                                widget.cantPeople.toString() + " ",
                                style: TextStyle(
                                    color: Colors.white, fontSize: 16),
                              ),
                              Icon(
                                CupertinoIcons.person_alt,
                                color: CupertinoColors.white,
                                size: 16,
                              )
                            ],
                          )),
                      Expanded(
                          flex: 1,
                          child: IconButton(
                              color: Colors.white,
                              focusColor: Colors.redAccent,
                              onPressed: () {
                                if (widget.cantPeople > 1) {
                                  setState(() {
                                    widget.peopleG == true
                                        ? widget.cantPeople =
                                            widget.cantPeople - 1
                                        : widget.cantPeople =
                                            widget.product.people - 1;
                                  });
                                  widget.product.people = widget.cantPeople;
                                  _prodProvider.updateToCatalog(widget.product);
                                }
                              },
                              icon: Icon(
                                Icons.remove_circle,
                                size: 28,
                              ))),
                    ],
                  ),
                ))
          ],
        ),
      ),
      onTap: () {},
    );
  }

  ImageProvider? _backgroundImage(String path) {
    if (path.contains('assets')) {
      return AssetImage(path);
    }
    return FileImage(File(path));
  }

  @override
  void initState() {
    super.initState();

    widget.cantPeople = widget.product.people;
  }

  @override
  void dispose() {
    super.dispose();
  }

  ImageProvider? _backgroundImage2(String path) {
    if (path.contains('assets')) {
      return AssetImage(path);
    } else {
      return FileImage(File(path));
    }
  }
}
