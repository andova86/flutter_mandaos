import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mandaos/models/cart_product.dart';
import 'package:mandaos/models/config.dart';
import 'package:mandaos/models/product.dart';
import 'package:mandaos/screens/buy/historical_buy.dart';
import 'package:mandaos/services/database_helper.dart';
import 'package:mandaos/services/db_helper.dart';
import 'package:mandaos/services/product_provider.dart';
import 'package:mandaos/utils/constants.dart';
import 'package:mandaos/utils/funtions.dart';
import 'package:mandaos/widgets/card_prod_buy.dart';
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
  final dbHelper = new DatabaseHelper();
  DateTime date = DateTime.now();

  //List<Product> filteredProd = [];

  Product? selectedProduct;
  double value = 0;
  double valueK = 0;


  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final _prodProvider = Provider.of<ProductProvider>(context, listen: false);
    list = _prodProvider.products;

    double result =
        MediaQuery.of(context).size.height - AppBar().preferredSize.height;

    int total = _getTotal();

    Widget _list() {
      double result2 =
          MediaQuery.of(context).size.height - AppBar().preferredSize.height;
      return _prodProvider.products.length == 0
          ? Expanded(child: Center(child: Text('No se ha seleccionado productos.'),))
          : Expanded(
              child: Container(
                  child: ListView.builder(
                    itemCount: _prodProvider.products.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Dismissible(
                        child: Column(
                          children: [
                            CardProductBuyHome(
                              product: list[index],
                              cantPeople: value.round() + valueK.round(),
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
            );
    }

    Widget _FAB(){

      return  FloatingActionButton(
        onPressed: () {

          if (list.length > 0 && value > 0) {
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
                            date: DateFormat('dd/MM/yyyy').format(date),
                            title: list[i].title,
                            um: list[i].um,
                            cuota: list[i].cuota,
                            price: list[i].price,
                            img: list[i].img,
                            cant: value.toInt(),
                          );
                          //print(list[i].toJson());
                          Future<int> c = insert(cart.toJson(), tableCartProducts);
                          if (c.toString().length > 0) {
                            number++;
                          }
                          // dbHelper.listCartProductBuy();

                        }
                        if (number == list.length) {
                          Navigator.of(context).pop();
                          Message('Se guardó la compra correctamente.', context);
                          _prodProvider.removeAllFromCatalog();
                          setState(() {
                            list = [];
                          });
                          // MessageUI(val: 0,message: "Se guardó la compra correctamente.",);
                        }




                        /*final snackBar;

                      if (result) {
                        snackBar = SnackBar(
                            duration:
                            Duration(seconds: 1),
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
                                  const EdgeInsets
                                      .only(left: 10),
                                  child: Text(
                                      'Se añadió este producto al carrito.'),
                                ),
                              ],
                            ));
                      } else {
                        snackBar = SnackBar(
                            duration:
                            Duration(seconds: 1),
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
                                  const EdgeInsets
                                      .only(left: 10),
                                  child: Text(
                                      'Ya usted añadió este producto.'),
                                ),
                              ],
                            ));
                      }

                      ScaffoldMessenger.of(context)
                          .showSnackBar(snackBar);*/
                      },
                      child: Text('ok'),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: Text(
                        'cancelar',
                        style: TextStyle(color: Colors.red),
                      ),
                    )
                  ],
                ));



            // Buy buy = Buy(date: DateFormat('dd/MM/yyyy').format(date), cant: value.toInt());
            //dbHelper.insert(buy.toJson(), tableBuy);
            //dbHelper.listCartProductBuy();
          } else {
            print('Hay un error');
            print(list.length);
            print(value);

            if (value.toInt() == 0 && list.length > 0) {
              Message('Seleccione las personas , por favor.', context);
            }

            if (value.toInt() == 0 && list.length == 0) {
              Message(
                  'Debe seleccionar los productos a comprar y las personas.',
                  context);
            }

            if (value.toInt() > 0 && list.length == 0) {
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
        /*actions: <Widget>[
            IconButton(
              icon: Icon(
                Icons.shopping_bag,
                size: 32.0,
                color: Colors.white,
              ),
              onPressed: () {},
            )
          ],*/
      ),
      floatingActionButton: _FAB(),




      body: SafeArea(
        maintainBottomViewPadding: false,
        child: Column(
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
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(right: 10),
                    child: Text(
                      'Su compra',
                      style: TextStyle(
                          fontSize: result < 480 ? 25 : 30,
                          color: Colors.white,
                          fontFamily: 'UbuntuRegular'),
                    ),
                  ),
                  //Image.network('assets/img/pro.png'),
                  Icon(
                    Icons.shopping_bag,
                    size: result < 480 ? 30 : 35,
                    color: kSecondaryColor,
                  ),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.all(10),
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
                              onChanged: (value) =>
                                  setState(() => this.value = value),
                            ),
                            Padding(
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
                          ],
                        ),
                      ),
                      /* Image.asset(
                          'assets/img/personas.png',
                          width: 40,
                        )*/

                      _Emoticon(),
                    ],
                  ),
                  /* Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Slider(
                                value: valueK,
                                min: 0,
                                max: 5,
                                divisions: 5,
                                activeColor: kPrimaryColor,
                                inactiveColor: Colors.blueGrey.shade400,
                                label: valueK.round().toString(),
                                onChanged: (value) =>
                                    setState(() => this.valueK = value),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 20),
                                child: Text(

                                      valueK.round().toString() + " niños menores de 7 años",
                                  textAlign: TextAlign.start,
                                  style: TextStyle(
                                    color: kPrimaryColor,
                                    fontSize: 16,
                                    fontFamily: 'ComingSoon'),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Image.asset(
                          'assets/img/ninos2.jpg',
                          width: 80,
                        )
                      ],
                    ),*/
                ],
              ),
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
         padding: EdgeInsets.only(left: result < 480 ? 5 : 15, right: result < 480 ? 5 : 15),
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
                 Text(
                   "\$ " + total.toString() + ' CUP',
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
                     shape:
                     MaterialStateProperty.all<RoundedRectangleBorder>(
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
            lista.first.bebes.toDouble();
      });
      print("success");
    }).catchError((error, stackTrace) {
      print("outer: $error");
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  _getConfig() async {
    lista = await listConfig();
  }

  int _getTotal() {
    int vtotal = 0;
    for (int i = 0; i < list.length; i++) {
      double t = list[i].price * list[i].cuota * (value + valueK);
      vtotal = vtotal + t.round();
    }

    return vtotal;
  }

  Widget _Emoticon() {
/*

    if(value >= 2 && value <= 5)
    {
      return Icon(CupertinoIcons., color: kPrimaryColor,size: 32,);
    }

    if(value >= 6 && value <= 9)
    {
      return Icon(CupertinoIcons.battery_25, color: kPrimaryColor,size: 32,);
    }

    if(value >= 10 && value <= 15)
    {
      return Icon(CupertinoIcons.battery_100, color: kPrimaryColor,size: 32,);
    }
*/

    return Icon(
      CupertinoIcons.person_2_alt,
      color: kPrimaryColor,
      size: 32,
    );
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
      locale : const Locale("es","ES"),
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
