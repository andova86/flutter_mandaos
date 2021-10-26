import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mandaos/modules/cart/models/cart_product.dart';
import 'package:mandaos/modules/cart/models/buy.dart';
import 'package:mandaos/modules/products/models/product.dart';
import 'package:mandaos/services/db_helper.dart';
import 'package:mandaos/utils/constants.dart';
import 'package:mandaos/utils/funtions.dart';

class HistoricalBuyScreen extends StatefulWidget {
  const HistoricalBuyScreen({Key? key}) : super(key: key);

  @override
  _HistoricalBuyScreenState createState() => _HistoricalBuyScreenState();
}

class _HistoricalBuyScreenState extends State<HistoricalBuyScreen> {
  //TextEditingController _filter = new TextEditingController();
  List<CartProduct> list = [];
  double total = 0;
  Buy? b;
  DateTime dateField = DateTime.now();
  List<Buy> lista = [];
  List<CartProduct> listaD = [];

  //final dbHelper = n;

  //List<Product> filteredProd = [];

  late Product selectedProduct;
  int value = 0;
  double valueK = 0;

  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    double result =
        MediaQuery.of(context).size.height - AppBar().preferredSize.height;

    // final _prodProvider = Provider.of<ProductProvider>(context, listen: false);
    //list = _prodProvider.products;

    //int total = _getTotal();

    return Scaffold(
      backgroundColor: Colors.white,
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        //title: Text('Productos de la Bodega'),
        backgroundColor: kPrimaryColor,
        elevation: 0,
        title: Text(
          'Historial de Compras',
          style: TextStyle(
              fontSize: 18, color: Colors.white, fontFamily: 'UbuntuRegular'),
        ),
        actions: <Widget>[
          IconButton(
            icon: Icon(
              Icons.list_alt_outlined,
              size: 32.0,
              color: Colors.white,
            ),
            onPressed: () {
              setState(() {
                list = [];
              });
              print(listaD.length);
            },
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _getData(context, DateFormat('dd/MM/yyyy').format(dateField));
        },
        mini: result < 480 ? true : false,
        child: Icon(
          Icons.refresh,
          color: Colors.white,
        ),
        backgroundColor: Colors.redAccent,
      ),
      body: SafeArea(
        maintainBottomViewPadding: false,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              padding: EdgeInsets.only(
                  left: kDefaultPadding, right: kDefaultPadding, bottom: 5),
              height: size.height * 0.06,
              decoration: BoxDecoration(
                  color: kPrimaryColor,
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(36),
                      bottomRight: Radius.circular(36))),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(right: 8.0),
                    child: Text(
                      'Cantidad: ',
                      style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: kSecondaryColor,
                          fontFamily: 'UbuntuRegular'),
                    ),
                  ),
                  //Image.network('assets/img/pro.png'),
                  Text(
                    list.length.toString() + ' productos.',
                    style: TextStyle(
                        fontSize: 18,
                        color: kSecondaryColor,
                        fontFamily: 'UbuntuRegular'),
                  ),
                ],
              ),
            ),
            list.length == 0
                ? Expanded(
                    child: FutureBuilder<List<DateTime>>(
                    future: ListBuysInYear(DateTime.now().year),
                    builder: (
                      context,
                      snapshot,
                    ) {
                      print(snapshot.connectionState);
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return CircularProgressIndicator();
                      } else if (snapshot.connectionState ==
                          ConnectionState.done) {
                        if (snapshot.hasError) {
                          return const Text('Error');
                        } else if (snapshot.hasData) {
                          return Container(
                            padding: EdgeInsets.all(20),
                            child: ListView.builder(
                                itemCount: snapshot.data!.length,
                                itemBuilder: (context, i) {
                                  String dt = DateFormat('dd/MM/yyyy')
                                      .format(snapshot.data![i]);
                                  return ListTile(
                                    title: Text(
                                      dt,
                                      style: TextStyle(
                                          color: kPrimaryColor,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 20),
                                    ),
                                    //subtitle: ,
                                    leading: Icon(Icons.remove_red_eye_rounded),
                                    /* trailing: IconButton(icon: Icon(Icons.delete, color: Colors.redAccent,), onPressed: () {
                                      showDialog(
                                          barrierDismissible: false,
                                          context: context,
                                          builder: (_) => new AlertDialog(
                                            content: Text(
                                              'Desea eliminar la compra seleccionada. ?',
                                              style: TextStyle(color: kPrimaryColor),
                                            ),
                                            actions: [
                                              TextButton(
                                                onPressed: () {

                                                  deleteBuybyDate(dt, tableCartProducts).then((value) {

                                                    print('Se elimino ************ $value');

                                                    setState(() {
                                                      list=[];
                                                    });
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

                                    },),*/
                                    onTap: () {
                                      if (snapshot.data != null) {
                                        _getData(context, dt);
                                      }
                                    },
                                  );
                                }),
                          );
                        } else {
                          return const Text('Empty data');
                        }
                      } else {
                        return Text('State: ${snapshot.connectionState}');
                      }
                    },
                  ))
                : Expanded(
                    child: Container(
                        child: ListView.builder(
                          itemCount: list.length,
                          itemBuilder: (BuildContext context, int index) {
                            return _data(list[index], index);
                          },
                        ),
                        // margin: EdgeInsets.only(left: 10, right: 10),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          /*gradient: LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomLeft,
                          colors: [
                            Colors.white,
                            kSecondaryColor,
                          ],
                        ),*/
                          /*boxShadow: [
                          BoxShadow(
                              offset: Offset(0, 20),
                              color: Colors.black38,
                              blurRadius: 5)
                        ]*/
                        )),
                  ),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        height: result < 480 ? 50 : 80,
        padding: EdgeInsets.only(left: 20, right: 20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Precio Total',
                  style: TextStyle(
                    color: kSecondaryColor,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'UbuntuRegular',
                    fontSize: 14,
                  ),
                ),
                Text(
                  " \$ " +
                      total
                          .toStringAsFixed(2)
                          .replaceAll(RegExp(r"([.]*0+)(?!.*\d)"), "") +
                      ' CUP',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontFamily: 'UbuntuRegular',
                      fontWeight: FontWeight.bold),
                ),
              ],
            ),
            ElevatedButton(
                onPressed: () {
                  _selectDate(context);
                  // print("*********************");
                  // print(DateFormat('dd/MM/yyyy').format(date));
                },
                style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(kotherColor),
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(40),
                    ))),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      DateFormat('dd/MM/yyyy').format(dateField),
                      style: TextStyle(
                          color: kPrimaryColor,
                          fontFamily: 'UbuntuRegular',
                          fontWeight: FontWeight.w900),
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    Icon(
                      Icons.date_range,
                      size: 16,
                      color: kPrimaryColor,
                    )
                  ],
                ))
          ],
        ),
        decoration: BoxDecoration(
          color: kPrimaryColor,
          // boxShadow: [BoxShadow(color: Colors.white, blurRadius: 50, offset: Offset(0,10))],
          //borderRadius: BorderRadius.only(topRight: Radius.circular(20), topLeft: Radius.circular(20)),
        ),
      ),
    );
  }

  double _getTotal() {
    double vtotal = 0;
    print('Cantidad: ' + list.length.toString());
    for (int i = 0; i < list.length; i++) {
      double t = list[i].price * list[i].cuota * list[i].cant;
      vtotal = vtotal + t;
    }

    return vtotal;
  }

  void _getData(BuildContext context, String? date) {
    _getConfig(date!).then((val) {
      setState(() {
        //print(listaD);
        if (listaD.length > 0) {
          list = listaD;

          total = _getTotal();

          setState(() {
            dateField = DateFormat('dd/MM/yyyy').parse(date);
          });
        } else {
          list = [];
          Message(
              '! No existen datos de compra en el día seleccionado !', context);
        }
      });
      print("success");
    }).catchError((error, stackTrace) {
      print("outer: $error");
    });
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  _getConfig(String dateNew) async {
    // print(date);
    listaD = await listCartProductBuy(dateNew);
    //print(listaD);
  }

  _selectDate(BuildContext context) async {
    final DateTime? selected = await showDatePicker(
      context: context,
      initialDate: dateField,
      firstDate: DateTime(2020),
      lastDate: DateTime(2050),
      helpText: 'Seleccione la fecha de la compra',
      cancelText: 'Cancelar',
      confirmText: 'Aceptar',
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: ColorScheme.light(
              primary: kPrimaryColor, // header background color
              onPrimary: kSecondaryColor, // header text color
              onSurface: kPrimaryColor.withOpacity(.8), // body text color
            ),
            textButtonTheme: TextButtonThemeData(
              style: TextButton.styleFrom(
                primary: kPrimaryColor, // button text color
              ),
            ),
          ),
          child: child!,
        );
      },
    );

    if (selected != null && selected != dateField) {
      setState(() {
        dateField = selected;
      });
    }
  }

  Widget _data(CartProduct cart, int index1) {
    double p = cart.price * cart.cant * cart.cuota;
    String unit =
        cart.um == "uno" ? cart.title.toLowerCase() : cart.um.toString();

    return Column(
      children: [
        Dismissible(
          key: UniqueKey(),
          child: ListTile(

            leading:  CircleAvatar(
              maxRadius: 25,
              backgroundColor: kotherColor,
              child: Text(
                '\$ ' +
                    p
                        .toStringAsFixed(2)
                        .replaceAll(RegExp(r"([.]*0+)(?!.*\d)"), ""),
                style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: kPrimaryColor),
              ),
            ),

              // SizedBox(height: 5,),
              // CircleAvatar(
              //   maxRadius: 15,
              //   backgroundImage: _backgroundImage2(cart.img),
              // ),
            title: Text(
              cart.title,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 5,
                ),
                Text((cart.cuota * cart.cant)
                        .toStringAsFixed(2)
                        .replaceAll(RegExp(r"([.]*0+)(?!.*\d)"), "") +
                    " " +
                    unit +
                    " por " +
                    cart.cant.toString() +
                    " personas."),
              ],
            ),
            trailing: IconButton(onPressed: (){

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

                          setState(() {
                            delete(cart.id!, tableCartProducts);
                            list.removeAt(index1);
                          });

                          Navigator.of(context).pop();


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
            }, icon: Icon(Icons.delete_forever, color: Colors.red,),)
          ),
          onDismissed: (index) {
            setState(() {
              delete(cart.id!, tableCartProducts);
              list.removeAt(index1);
            });
          },
          direction: DismissDirection.endToStart,
          background: Container(
            color: Colors.red,
            margin: EdgeInsets.symmetric(horizontal: 15),
            alignment: Alignment.centerRight,
            child: Icon(
              Icons.delete,
              color: Colors.white,
              size: 32,
            ),
          ),
        ),
        Divider(
          height: 10,
        ),
      ],
    );
  }

  ImageProvider? _backgroundImage2(String path) {
    if (path.contains('assets')) {
      return AssetImage(path);
    } else {
      return FileImage(File(path));
    }
  }
}
