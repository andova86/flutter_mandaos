import 'dart:async';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mandaos/modules/products/screen/list_product_screen.dart';
import 'package:mandaos/services/database_helper.dart';
import 'package:mandaos/services/db_helper.dart';
import 'package:provider/provider.dart';
import 'package:animate_do/animate_do.dart';

import 'package:mandaos/modules/products/models/product.dart';
import 'package:mandaos/modules/products/provider/product_provider.dart';
import 'package:mandaos/utils/constants.dart';

class ProductDetailScreen extends StatefulWidget {
  //const ProductDetailScreen({Key? key}) : super(key: key);

  Product? product;
  final int idProd;


  ProductDetailScreen({required this.idProd});

  @override
  _ProductDetailScreenState createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen> {
  @override
  Widget build(BuildContext context) {
    //Product product = ModalRoute.of(context)!.settings.arguments as Product;

    String total = "\$ " +
        widget.product!.price
            .toStringAsFixed(2)
            .replaceAll(RegExp(r"([.]*0+)(?!.*\d)"), "") +
        " CUP por " +
        widget.product!.um;
    Size size = MediaQuery.of(context).size;

    double t = widget.product!.price * widget.product!.cuota;
    double price1 = (t * 1);
    double price2 = (t * 2);
    double price3 = t * 3;
    double price4 = t * 4;
    double price5 = t * 5;
    double price6 = t * 6;
    String sub = widget.product!.cuota
            .toString()
            .replaceAll(RegExp(r"([.]*0+)(?!.*\d)"), "") +
        ' ' +
        widget.product!.um +
        ' por ';
    String sub2 = widget.product!.cuota
            .toString()
            .replaceAll(RegExp(r"([.]*0+)(?!.*\d)"), "") +
        ' por ';
    //double price7 = t * 7;
    final _prodProvider = Provider.of<ProductProvider>(context, listen: false);
    double result =
        MediaQuery.of(context).size.height - AppBar().preferredSize.height;

    File file = File(widget.product!.img);


    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.miniEndTop,
      backgroundColor: kPrimaryColor,
      //floatingActionButtonAnimator: FloatingActionButtonAnimator.scaling,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          //Navigator.of(context).po

          Navigator.pushNamed(context, 'addproduct',
                  arguments: widget.idProd)
              .then((val) {
                setState(() {
                  get(widget.idProd, table).then((value) {
                    setState(() {
                      widget.product = value!;
                    });
                  });
                });
          });
        },
        mini: result < 500 ? true : false,
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
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            backgroundColor: kPrimaryColor,
            floating: true,
            collapsedHeight: size.height * 0.3,
            leading: new IconButton(
              icon: new Icon(
                Icons.arrow_back,
                color: kPrimaryColor,
                size: 32,
              ),
              onPressed: () => Navigator.of(context).pop(),
            ),
            flexibleSpace: Hero(
              tag:
                  "hero-" + widget.idProd.toString() + widget.product!.title,
              transitionOnUserGestures: true,
              child: widget.product!.img.contains('assets') == false
                  ? Image(
                      image: FileImage(file),
                      fit: BoxFit.cover,
                      width: double.infinity,
                      height: size.height * 0.4,
                    )
                  : Image.asset(
                      widget.product!.img,
                      fit: BoxFit.cover,
                      width: double.infinity,
                      height: size.height * 0.4,
                    ),
            ),
          ),
          SliverList(
            delegate: SliverChildListDelegate(
              [
                Container(
                  padding:
                      EdgeInsets.only(left: 10, right: 10, top: 0, bottom: 0),
                  margin: EdgeInsets.zero,
                  //height: double.minPositive,

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
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    SizedBox(
                                      height: 15,
                                    ),
                                    Text(
                                      widget.product!.title,
                                      maxLines: 2,
                                      style: TextStyle(
                                          fontSize: 22,
                                          color: kSecondaryColor,
                                          fontFamily: 'UbuntuRegular',
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Divider(
                                      height: 20,
                                      color: Colors.white,
                                    ),
                                    Text(
                                      'Cuota',
                                      style: TextStyle(
                                        color: kSecondaryColor.withOpacity(.7),
                                        fontSize: 12,
                                        fontFamily: 'UbuntuRegular',
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        Text(
                                          widget.product!.um == 'uno'
                                              ? sub2
                                              : sub,
                                          style: TextStyle(
                                              color: kSecondaryColor,
                                              fontWeight: FontWeight.bold,
                                              fontFamily: 'UbuntuRegular',
                                              fontSize: 16),
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
                                SizedBox(
                                  height: 10,
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Precio',
                                      style: TextStyle(
                                        color: kSecondaryColor.withOpacity(.7),
                                        fontSize: 12,
                                        fontFamily: 'UbuntuRegular',
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
                                            fontFamily: 'UbuntuRegular',
                                            fontSize: 16),
                                      ),
                                    )
                                  ],
                                ),
                              ],
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
                              child:

                              _widgetPeople(price1: price1, price2: price2, price3: price3, price4: price4, price5: price5, price6: price6)),
                        ],
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          ElevatedButton(
                            onPressed: () {
                            if(widget.product != null)
                              {

                                bool result =
                                _prodProvider.addToCatalog(widget.product!);
                                print('El resultado es : $result');
                                // Navigator.of(context).pop();

                                SnackBar snackBar;

                                if (result) {
                                  snackBar = SnackBar(
                                      duration: Duration(seconds: 1),
                                      content: Row(
                                        mainAxisAlignment:
                                        MainAxisAlignment.start,
                                        children: [
                                          Icon(
                                            Icons.check,
                                            color: Colors.green,
                                          ),
                                          Padding(
                                            padding:
                                            const EdgeInsets.only(left: 10),
                                            child: Text(
                                              'Se añadió este producto al carrito.',
                                              style: TextStyle(
                                                  fontFamily: 'UbuntuRegular'),
                                            ),
                                          ),
                                        ],
                                      ));
                                } else {
                                  snackBar = SnackBar(
                                      duration: Duration(seconds: 1),
                                      content: Row(
                                        mainAxisAlignment:
                                        MainAxisAlignment.start,
                                        children: [
                                          Icon(
                                            Icons.warning,
                                            color: Colors.red,
                                          ),
                                          Padding(
                                            padding:
                                            const EdgeInsets.only(left: 10),
                                            child: Text(
                                                'Ya usted añadió este producto.'),
                                          ),
                                        ],
                                      ));
                                }

                                ScaffoldMessenger.of(context)
                                    .showSnackBar(snackBar);
                              }
                            },
                            style:

                            ButtonStyle(
                                backgroundColor:
                                    MaterialStateProperty.all(kotherColor),
                                padding: MaterialStateProperty.all(
                                    EdgeInsets.all(10)),
                                shadowColor:
                                    MaterialStateProperty.all(kSecondaryColor),
                                elevation: MaterialStateProperty.all(10),
                                shape: MaterialStateProperty.all<
                                        RoundedRectangleBorder>(
                                    RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  //side: BorderSide(color: kPrimaryColor)
                                ))),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(right: 15),
                                  child: Text(
                                    'Añadir al Carrito',
                                    style: TextStyle(
                                        color: kPrimaryColor,
                                        fontFamily: 'UbuntuRegular',
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                                Icon(
                                  CupertinoIcons.cart_fill_badge_plus,
                                  color: kPrimaryColor,
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: 10,),

                          widget.product!.prodUser == 1 ?
                          ElevatedButton(
                            onPressed: () async {
                              FocusScope.of(context).requestFocus(new FocusNode());

                              showDialog(
                                  barrierDismissible: false,
                                  context: context,
                                  builder: (_) => new AlertDialog(
                                    content: Text(
                                      'Desea eliminar el producto seleccionado. ?',
                                      style: TextStyle(color: kPrimaryColor),
                                    ),
                                    actions: [
                                      TextButton(
                                        onPressed: () {

                                          delete(widget.idProd, table).then((value) {

                                           print('Se elimino ************ $value');

                                           Navigator.popUntil(context, ModalRoute.withName('products'));
                                          });
                                        },
                                        child: Text('Aceptar'),
                                      ),
                                      TextButton(
                                        onPressed: () {
                                          Navigator.of(context).pop();
                                        },
                                        child: Text(
                                          'Cancelar',
                                          style: TextStyle(color: Colors.red),
                                        ),
                                      )
                                    ],
                                  ));
                            },
                            style: ButtonStyle(
                              //  fixedSize:  MaterialStateProperty.all(100),

                                backgroundColor:
                                MaterialStateProperty.all(Colors.red),
                                padding:
                                MaterialStateProperty.all(EdgeInsets.all(15)),
                                shadowColor:
                                MaterialStateProperty.all(Colors.redAccent),
                                elevation: MaterialStateProperty.all(3),
                                shape: MaterialStateProperty.all<
                                    RoundedRectangleBorder>(RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ))),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(right: 15),
                                  child: Text(
                                    'Eliminar Producto',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontFamily: 'UbuntuRegular',
                                    ),
                                  ),
                                ),
                                Icon(
                                  Icons.delete,
                                  color: Colors.white,
                                ),
                              ],
                            ),
                          ):Container()

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
          )
        ],
      ),
    );
  }

  FutureOr onGoBack(var val) {

    print('+++++++++   ${val}');

    setState(() {
      widget.product = val;
    });
  }


  @override
  void initState() {
    super.initState();
    _getData();




    //dbHelper.listConfig();
  }

  void _getData() {
     getProductoAllData(widget.idProd).then((product) {
    setState(() {
      widget.product = product!;
    });

    });
  }

  @override
  void dispose() {
    super.dispose();
  }
}

class _widgetPeople extends StatelessWidget {
  const _widgetPeople({
    Key? key,
    required this.price1,
    required this.price2,
    required this.price3,
    required this.price4,
    required this.price5,
    required this.price6,
  }) : super(key: key);

  final double price1;
  final double price2;
  final double price3;
  final double price4;
  final double price5;
  final double price6;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: EdgeInsets.all(10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _PricePerPerson(price1, 1),
              _PricePerPerson(price2, 2),
              _PricePerPerson(price3, 3),
            ],
          ),
        ),
        SizedBox(
          height: 10,
        ),
        Container(
          padding: EdgeInsets.all(10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _PricePerPerson(price4, 4),
              _PricePerPerson(price5, 5),
              _PricePerPerson(price6, 6),
            ],
          ),
        ),
      ],
    );
  }
}



Widget _PricePerPerson(double price, int number) {
  return

    Column(
    children: [
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                number.toString() + " ",
                style: TextStyle(color: kSecondaryColor, fontSize: 14),
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
              price
                  .toStringAsFixed(2)
                  .replaceAll(RegExp(r"([.]*0+)(?!.*\d)"), "") +
              ' CUP ',
          style: TextStyle(
              fontSize: 11, color: kPrimaryColor, fontWeight: FontWeight.bold),
        ),
      )
    ],
  );
}
