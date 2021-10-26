import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mandaos/modules/cart/models/cart_product.dart';
import 'package:mandaos/modules/home/models/config.dart';
import 'package:mandaos/modules/cart/screen/historical_buy.dart';
import 'package:mandaos/modules/products/models/product.dart';
import 'package:mandaos/modules/products/provider/product_provider.dart';
import 'package:mandaos/services/db_helper.dart';
import 'package:mandaos/utils/constants.dart';
import 'package:mandaos/utils/funtions.dart';
import 'package:mandaos/modules/cart/widget/card_prod_buy.dart';
import 'package:mandaos/utils/headers.dart';
import 'package:provider/provider.dart';

class BuyProductScreen extends StatefulWidget {
  const BuyProductScreen({Key? key}) : super(key: key);

  @override
  _BuyProductScreenState createState() => _BuyProductScreenState();
}

class _BuyProductScreenState extends State<BuyProductScreen> {
  //TextEditingController _filter = new TextEditingController();
  List<Product> list = [];
  List<Config> lista = [];

  DateTime date = DateTime.now();
  int precioTotal = 0;

  //List<Product> filteredProd = [];

  Product? selectedProduct;
  double value = 0;
  double valueK = 0;
  bool checkedValue = false;

  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final _prodProvider = Provider.of<ProductProvider>(context, listen: false);
    //list = _prodProvider.products;

    double result =
        MediaQuery.of(context).size.height - AppBar().preferredSize.height;

    Widget _list() {
      return _prodProvider.products.length == 0
          ? Expanded(
              child: Center(
              child: Text('No se ha seleccionado productos.'),
            ))
          : Expanded(
              child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                  ),
                  child: Consumer<ProductProvider>(
                      builder: (context, cart, child) {
                    return ListView.builder(
                      itemCount: cart.products.length,
                      itemBuilder: (BuildContext context, int index) {
                        return Dismissible(
                          child: Column(
                            children: [
                              CardProductBuyHome(
                                product: cart.products[index],
                                peopleG: checkedValue,
                                // cantPeople: value.round() + valueK.round(),
                              ),
                              Divider(),
                            ],
                          ),
                          key: UniqueKey(),

                          direction: DismissDirection.endToStart,

                          // Remove this product from the list
                          // In production enviroment, you may want to send some request to delete it on server side
                          onDismissed: (_) {
                            setState(() {
                              _prodProvider.removeFromCatalog(index);
                              list.removeAt(index);
                            });
                          },
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
                        );
                      },
                    );
                  })

                  // margin: EdgeInsets.only(left: 10, right: 10),

                  ),
            );
    }

    Widget _fAB() {
      return FloatingActionButton(
        onPressed: () {
          if (list.length > 0) {
            showDialog(
                barrierDismissible: false,
                context: context,
                builder: (_) => new AlertDialog(
                      content: Text(
                        'Desea guardar la compra del día seleccionado ?',
                        style: TextStyle(color: kPrimaryColor),
                      ),
                      actions: [
                        TextButton(
                          onPressed: () {
                            int number = 0;
                            //print('*-************--------' + date.day.toString());
                            for (int i = 0; i < list.length; i++) {
                              CartProduct cart = CartProduct(
                                date: date.toIso8601String(),
                                title: list[i].title,
                                um: list[i].um,
                                cuota: list[i].cuota,
                                price: list[i].price,
                                img: list[i].img,
                                cant: list[i].people,
                              );
                              //print(list[i].toJson());
                              Future<int> c =
                                  insert(cart.toJson(), tableCartProducts);
                              if (c.toString().length > 0) {
                                number++;
                              }
                              // dbHelper.listCartProductBuy();

                            }
                            if (number == list.length) {
                              Navigator.of(context).pop();

                              Message('Se guardó la compra correctamente.',
                                  context);
                              _prodProvider.removeAllFromCatalog();
                              setState(() {
                                list = [];
                              });
                              // MessageUI(val: 0,message: "Se guardó la compra correctamente.",);
                            }
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
          } else {
            print('Hay un error');
            print(list.length);
            print(value);

            if (list.length == 0) {
              Message("Debe seleccionar los productos a comprar.", context);
            }
          }
        },

        tooltip: 'Guardar los datos de la compra.',
        mini: result < 500 ? true : false,
        // autofocus: true,

        highlightElevation: 0,
        elevation: 0,
        child: Icon(
          Icons.save,
          color: Colors.white,
        ),
        backgroundColor: Colors.redAccent,
      );
    }

    return Scaffold(
      backgroundColor: Colors.white,
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        //title: Text('Productos de la Bodega'),

        backgroundColor: kPrimaryColor,
        elevation: 0,
        actions: [
          IconButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => HistoricalBuyScreen()),
                );
              },
              icon: Icon(
                Icons.history_outlined,
                color: Colors.white,
              ))
        ],
      ),
      floatingActionButton: _fAB(),
      body: SafeArea(
        maintainBottomViewPadding: false,
        child: Column(
          children: [
            const HeaderM(title: 'Su compra', ico: Icons.shopping_cart),
            Container(
              margin: EdgeInsets.only(left: 10, right: 10, bottom: 10),
              padding: EdgeInsets.all(5),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
                /*gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.centerRight,
                    colors: [
                      Colors.white70,
                      Colors.white,
                    ],
                  ),*/
                boxShadow: [
                  BoxShadow(
                      color: kPrimaryColor,
                      blurRadius: 2,
                      spreadRadius: 0.1,
                      offset: Offset(0, 2))
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Slider(
                                value: value,
                                min: 0,
                                max: 15,
                                divisions: 15,
                                activeColor: kPrimaryColor,
                                inactiveColor: Colors.blueGrey.shade400,
                                label: value.round().toString(),
                                onChanged: (value) {
                                  setState(() => this.value = value);
                                  setState(() => checkedValue = false);
                                }),
                            Row(
                              children: [
                                Expanded(
                                  child: Padding(
                                    padding: const EdgeInsets.only(left: 20),
                                    child: Text(
                                      value.round().toString() + " personas",
                                      textAlign: TextAlign.start,
                                      style: TextStyle(
                                          color: kPrimaryColor,
                                          fontSize: 14,
                                          fontFamily: 'UbuntuRegular'),
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: CheckboxListTile(
                                    contentPadding: EdgeInsets.all(0),

                                    title: FittedBox(
                                      child: Text(
                                        'Aplicar a todos',
                                        style: TextStyle(
                                          fontSize: 12,
                                          fontFamily: 'UbuntuRegular',
                                          fontWeight: FontWeight.bold,
                                          color: kPrimaryColor,
                                        ),
                                      ),
                                    ),
                                    value: checkedValue,

                                    activeColor: kPrimaryColor,
                                    onChanged: (newValue) {
                                      newValue == true
                                          ? _prodProvider
                                              .applyAllCantPeople(value.toInt())
                                          : _prodProvider.applyAllCantPeople(1);

                                      setState(() {
                                        checkedValue = newValue!;
                                      });

                                      setState(() {
                                        list = _prodProvider.products;
                                      });
                                    },
                                    controlAffinity: ListTileControlAffinity
                                        .leading, //  <-- leading Checkbox
                                  ),
                                )
                              ],
                            ),
                          ],
                        ),
                      ),
                      /* Image.asset(
                          'assets/img/personas.png',
                          width: 40,
                        )*/
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 15,
            ),
            _list()
          ],
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        elevation: 0,
        child: Container(
          //margin: EdgeInsets.only(left: 10, right: 10),
          height: result < 480 ? 60 : 80,
          padding: EdgeInsets.only(
              left: result < 480 ? 5 : 15, right: result < 480 ? 5 : 15),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'precio total',
                    style: TextStyle(
                      color: kSecondaryColor,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'UbuntuRegular',
                      fontSize: 12,
                    ),
                  ),
                  Consumer<ProductProvider>(builder: (context, cart, child) {
                    return Text(
                      " \$ " +
                          cart
                              .total()
                              .toStringAsFixed(2)
                              .replaceAll(RegExp(r"([.]*0+)(?!.*\d)"), "") +
                          ' CUP',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontFamily: 'UbuntuRegular',
                          fontWeight: FontWeight.bold),
                    );
                  }),
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
                        borderRadius: BorderRadius.circular(10),
                      ))),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        DateFormat('dd/MM/yyyy').format(date),
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
        ),
        shape: CircularNotchedRectangle(),
        color: kPrimaryColor,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }

  @override
  void initState() {
    super.initState();
    _getConfig().then((val) {
      setState(() {
        value = lista.first.adultos.toDouble() +
            lista.first.ninos37.toDouble() +
            lista.first.splash.toDouble() +
            lista.first.bebes.toDouble();
      });
      print("se actualizo la lista de compras");
    }).catchError((error, stackTrace) {
      print("outer: $error");
    });

    list = Provider.of<ProductProvider>(context, listen: false).products;
  }

  @override
  void dispose() {
    super.dispose();
  }

  _getConfig() async {
    lista = await listConfig();
  }

  _selectDate(BuildContext context) async {
    final DateTime? selected = await showDatePicker(
      context: context,
      initialDate: date,
      firstDate: DateTime(2020),
      lastDate: DateTime(2050),
      helpText: 'Seleccione la fecha de la compra',
      cancelText: 'Cancelar',
      confirmText: 'Aceptar',
      locale: const Locale("es", "ES"),
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

    if (selected != null && selected != date) {
      setState(() {
        date = selected;
      });
    }
  }
}
