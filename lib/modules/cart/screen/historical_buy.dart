import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mandaos/models/cart_product.dart';
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
  int total = 0;
  Buy? b;
  DateTime date = DateTime.now();
  List<Buy> lista = [];
  List<CartProduct> listaD = [];
  //final dbHelper = n;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState> ();

  //List<Product> filteredProd = [];

  late Product selectedProduct;
  int value = 0;
  double valueK = 0;


  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    double result = MediaQuery.of(context).size.height - AppBar().preferredSize.height;

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
              fontSize: 18,
              color: Colors.white,
              fontFamily: 'UbuntuRegular'),
        ),
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
       floatingActionButton: FloatingActionButton(onPressed: (){

         _getConfig(DateFormat('dd/MM/yyyy').format(date)).then((val) {
           setState(() {
             //print(listaD);
             if(listaD.length > 0)
               {

                 list = listaD;

                 setState(() {
                   value = list.first.cant;
                 });

                 total = _getTotal();
               }
             else{
               list=[];
               Message('! No existen datos de compra en el día seleccionado !',context);
             }



           });
           print("success");
         }).catchError((error, stackTrace) {
           print("outer: $error");
         });


       },
         mini: result < 480? true: false,
        child: Icon(Icons.refresh, color: Colors.white,),
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
                      'Consumidores: ',
                      style: TextStyle(
                          fontSize: 16,
                          color: kSecondaryColor,
                          fontFamily: 'UbuntuRegular'),
                    ),
                  ),
                  //Image.network('assets/img/pro.png'),
                  Text(
                    value.toString(),
                    style: TextStyle(
                        fontSize: 18,
                        color: kSecondaryColor,
                        fontFamily: 'UbuntuRegular'),
                  ),
                ],
              ),
            ),
            list.length==0? Expanded(child: Center(child: Icon(CupertinoIcons.cart, size: 64,color: kPrimaryColor.withOpacity(.5),))):

            Expanded(
              child: Container(
                  child: ListView.builder(
                    itemCount: list.length,
                    itemBuilder: (BuildContext context, int index) {
                      return _data(list[index]);
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
            ) ,
          ],
        ),
      ),
      bottomNavigationBar: Container(
        height: result < 480? 50 : 80,
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
                  " \$ " + total.toString() + ' CUP',
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
                    backgroundColor:
                    MaterialStateProperty.all(kotherColor),
                    shape:
                    MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(40),
                        ))


                ),
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
        decoration: BoxDecoration(
          color: kPrimaryColor,
          // boxShadow: [BoxShadow(color: Colors.white, blurRadius: 50, offset: Offset(0,10))],
          //borderRadius: BorderRadius.only(topRight: Radius.circular(20), topLeft: Radius.circular(20)),
        ),
      ),
    );
  }

  int _getTotal() {
    int vtotal = 0;
    print('Cantidad: ' + list.length.toString());
   for (int i = 0; i < list.length; i++) {
      double t = list[i].price * list[i].cuota * (value);
      vtotal = vtotal + t.round();
    }

    return vtotal;
  }

  @override
  void initState() {
    super.initState();

    _getConfig(DateFormat('dd/MM/yyyy').format(date)).then((val) {
      setState(() {
        list = listaD;

        if(list.isNotEmpty)
          {
            setState(() {
              value = list.first.cant;
            });
            total = _getTotal();
          }

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

  _getConfig(String dateNew) async {
   // print(date);
    listaD = await listCartProductBuy(dateNew);
  }

  _getBuy() async {

    b = await getBuybyDate(DateFormat('dd/MM/yyyy').format(date), tableBuy);
  }

  _selectDate(BuildContext context) async{

    final DateTime? selected = await showDatePicker(
      context: context,
      initialDate: date,
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

    if(selected != null && selected != date){
      setState(() {
        date = selected;

      });
//print("LA FECHA ES " + DateFormat('dd/MM/yyyy').format(selected));

    }
  }

/*
  int _getTotal() {
    int vtotal = 0;
    for (int i = 0; i < list.length; i++) {
      double t = list[i].price * list[i].cuota * (value + valueK);
      vtotal = vtotal + t.round();
    }

    return vtotal;
  }
*/

  Widget _data(CartProduct cart) {
    Product? p1;


 double  p = cart.price * cart.cant * cart.cuota;

    return Column(
      children: [

        ListTile(
          leading:  CircleAvatar(
            maxRadius: 20,
            backgroundImage: AssetImage(cart.img),
          ),
          title: Text(cart.title, maxLines: 2, overflow: TextOverflow.ellipsis,),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 5,),
              Text((cart.cuota * cart.cant).toString() + " " + cart.um.toString() + " por " + cart.cant.toString() + " personas."),

            ],
          ),
          trailing: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text('\$ ' + p.toStringAsFixed(1) , style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.red),),
             /* Text('CUP',style: TextStyle(color: kTextColor),)*/
            ],
          ),
        ),
        Divider(height: 10,),
      ],
    );
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
}
