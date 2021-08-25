import 'package:badges/badges.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:mandaos/models/product.dart';
import 'package:mandaos/screens/buy/buy_product_screen.dart';
import 'package:mandaos/screens/buy/historical_buy.dart';
import 'package:mandaos/screens/config/config_screen.dart';
import 'package:mandaos/screens/home/about_screen.dart';
import 'package:mandaos/screens/home/help_screen.dart';
import 'package:mandaos/screens/products/list_product_screen.dart';
import 'package:mandaos/services/db_helper.dart';
import 'package:mandaos/services/product_provider.dart';
import 'package:mandaos/utils/constants.dart';
import 'package:mandaos/widgets/badgeUI.dart';
import 'package:mandaos/widgets/card_carrousel.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:provider/provider.dart';

import 'faq_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  TextEditingController _filter = new TextEditingController();
  String version = '';
  List<Product> list = [];

  // List<Product> filteredProd = [];
  //String _searchText = "";

  @override
  Widget build(BuildContext context) {
    //final _prodProvider = Provider.of<ProductProvider>(context, listen: false);

    Size size = MediaQuery.of(context).size;


    return Scaffold(
      drawer: _drawerShow(),
      appBar: AppBar(
        //title: Text('Productos de la Bodega'),
        backgroundColor: kPrimaryColor,
        // title: ,
        elevation: 0,
        leading: Builder(
          builder: (context) => IconButton(
            icon: Icon(
              CupertinoIcons.decrease_indent,
              color: Colors.white,
            ),
            onPressed: () => Scaffold.of(context).openDrawer(),
          ),
        ),

        actions: <Widget>[

          BadgeUI()


        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            _Welcom(),
            Container(
              padding: EdgeInsets.only(left: 15, right: 15, top: 10),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      RichText(
                        text: TextSpan(
                          text: 'Recomendados para ti',
                          style: TextStyle(
                              color: kPrimaryColor,
                              fontSize: 24,
                              fontFamily: 'UbuntuRegular',
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      /* RichText(
                          text: TextSpan(
                              text: ' Ver mas',
                              style: TextStyle(
                                  color: kSecondaryColor, fontSize: 18),
                              recognizer: TapGestureRecognizer()
                                ..onTap = () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            ListProductScreen()),
                                  );
                                }))*/
                    ],
                  ),
                  Column(
                    children: [
                      SizedBox(
                        height: 10,
                      ),
                      CarouselSlider(
                        options: CarouselOptions(
                          height: size.height * 0.25,
                          aspectRatio: 16 / 9,
                          viewportFraction: 0.65,

                          initialPage: 0,
                          enableInfiniteScroll: false,
                          reverse: false,
                          autoPlay: true,
                          autoPlayInterval: Duration(seconds: 4),
                          autoPlayAnimationDuration:
                              Duration(milliseconds: 800),
                          autoPlayCurve: Curves.fastOutSlowIn,
                          enlargeCenterPage: true,
                          //onPageChanged: callbackFunction,
                          scrollDirection: Axis.horizontal,
                        ),
                        items: list.map((prod) {
                          return Builder(
                            builder: (BuildContext context) {
                              return CardCarrousel(prod);
                            },
                          );
                        }).toList(),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Row(
                        children: [
                          Text(
                            'En solo 2 pasos, verifica tu precio.  ',
                            style: TextStyle(
                                color: kPrimaryColor,
                                fontSize: 16,
                                fontFamily: 'UbuntuRegular',
                                fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  '  1- Ver productos y selecciona algunos.',
                                  style: TextStyle(
                                    fontFamily: 'UbuntuRegular',
                                      color: kPrimaryColor, fontSize: 12),

                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                Text(
                                  '  2- Verifica tu precio por producto y el total a pagar.',
                                  style: TextStyle(
                                    fontFamily: 'UbuntuRegular',
                                    color: kPrimaryColor,
                                    fontSize: 12,
                                  ),
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      Container(
                        width: double.infinity,
                        padding: EdgeInsets.all(20),
                        decoration: BoxDecoration(
                            color: kSecondaryColor,
                            borderRadius: BorderRadius.circular(20),
                            gradient: LinearGradient(
                              begin: Alignment.topLeft,
                              end: Alignment.bottomLeft,
                              colors: [
                                Colors.white,
                                kSecondaryColor,
                              ],
                            ),
                            boxShadow: [
                              BoxShadow(
                                  offset: Offset(0, 1),
                                  color: Colors.black38,
                                  spreadRadius: 1,
                                  blurRadius: 2)
                            ]),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Realice su compra en el mercado de una manera más fácil. ',
                              style: TextStyle(
                                  color: kPrimaryColor,
                                  fontWeight: FontWeight.normal,
                                  fontFamily: 'UbuntuRegular',
                                  fontSize: 16),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                ElevatedButton(
                                    onPressed: () {
                                      //Navigator.of(context).pop();
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  ListProductScreen()));
                                    },
                                    style: ButtonStyle(
                                        backgroundColor:
                                            MaterialStateProperty.all(
                                                Colors.redAccent)),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          'Empecemos',
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontFamily: 'UbuntuRegular'),
                                        ),
                                        SizedBox(
                                          width: 10,
                                        ),
                                        Icon(
                                          Icons.logout,
                                          size: 16,
                                          color: Colors.white,
                                        )
                                      ],
                                    ))
                              ],
                            ),
                          ],
                        ),
                      ),

                      /*ListTile(
                        onTap: () {},
                        title: Text('Seleccione sus productos y verifique el precio total de la compra en el mercado de una manera fácil. '),
                        trailing: Icon(Icons.logout),

                       tileColor: kotherColor,
                        shape: Border.all(color: kPrimaryColor,),
                      )*/
                    ],
                  ),
                  SizedBox(
                    height: 30,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void initState() {

    super.initState();

    refreshData();
    String v;
    String appName = '';
    String packageName = '';

    String buildNumber = '';

    PackageInfo.fromPlatform().then((PackageInfo packageInfo) {
      appName = packageInfo.appName;
      // packageName = packageInfo.packageName;
      version = packageInfo.version;
      buildNumber = packageInfo.buildNumber;

      setState(() {
        version = packageInfo.version;
        print(version);
      });

    });

    //dbHelper.listConfig();
  }

  @override
  void dispose() {
    super.dispose();
  }

  Drawer _drawerShow() {

    return Drawer(
        child: Column(
          children: [
            DrawerHeader(
              margin: EdgeInsets.zero,
              padding: EdgeInsets.zero,
              child: Container(
                width: double.infinity,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(20),
                        bottomRight: Radius.circular(20)),
                    color: kPrimaryColor,
                    boxShadow: [
                      BoxShadow(
                          color: Colors.black38,
                          blurRadius: 20,
                          spreadRadius: 10,
                          offset: Offset(0, 5))
                    ]),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Mandaos',
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 30,
                          fontFamily: 'UbuntuRegular'),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Image.asset(
                      'assets/img/carritoCompras.png',
                      width: 60,
                      height: 60,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      'Versión '  + version,
                      style: TextStyle(color: kSecondaryColor),
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              child: ListView(
                children: [
                  ListTile(
                    selected: true,
                    onTap: () {
                      Navigator.of(context).pop();
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => HomeScreen()),
                      );
                    },
                    leading: Icon(
                      Icons.home_filled,
                      color: kSecondaryColor,
                      size: 36,
                    ),
                    title: Text(
                      'Inicio',
                      style: TextStyle(
                          color: kPrimaryColor,
                          fontSize: 20,
                          fontFamily: 'UbuntuRegular'),
                    ),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  ListTile(
                    onTap: () {
                      Navigator.of(context).pop();
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ListProductScreen()));
                    },
                    leading: Icon(
                      Icons.list,
                      color: kSecondaryColor,
                      size: 36,
                    ),
                    title: Text(
                      'Productos',
                      style: TextStyle(
                          color: kPrimaryColor,
                          fontSize: 20,
                          fontFamily: 'UbuntuRegular'),
                    ),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  ListTile(
                    onTap: () {
                      Navigator.of(context).pop();
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => BuyProductScreen()));
                    },
                    leading: Icon(
                      Icons.shopping_cart_sharp,
                      color: kSecondaryColor,
                      size: 36,
                    ),
                    title: Text(
                      'Compras',
                      style: TextStyle(
                          color: kPrimaryColor,
                          fontSize: 20,
                          fontFamily: 'UbuntuRegular'),
                    ),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  ListTile(
                    onTap: () {
                      Navigator.of(context).pop();
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => HistoricalBuyScreen()));
                    },
                    leading: Icon(
                      Icons.add_shopping_cart_rounded,
                      color: kSecondaryColor,
                      size: 36,
                    ),
                    title: Text(
                      'Historial de Compras',
                      style: TextStyle(
                          color: kPrimaryColor,
                          fontSize: 20,
                          fontFamily: 'UbuntuRegular'),
                    ),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  ListTile(
                    onTap: () {
                      Navigator.of(context).pop();
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ConfigScreen()));
                    },
                    leading: Icon(
                      Icons.settings,
                      color: kSecondaryColor,
                      size: 36,
                    ),
                    title: Text(
                      'Configuracion',
                      style: TextStyle(
                          color: kPrimaryColor,
                          fontSize: 20,
                          fontFamily: 'UbuntuRegular'),
                    ),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  ListTile(
                    onTap: () {
                      Navigator.of(context).pop();
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => HelpScreen()));
                    },
                    leading: Icon(
                      Icons.help_outline,
                      color: kSecondaryColor,
                      size: 36,
                    ),
                    title: Text(
                      'Ayuda',
                      style: TextStyle(
                          color: kPrimaryColor,
                          fontSize: 20,
                          fontFamily: 'UbuntuRegular'),
                    ),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  ListTile(
                    onTap: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => FaqScreen()));
                    },
                    leading: Icon(
                      Icons.question_answer,
                      color: kSecondaryColor,
                      size: 36,
                    ),
                    title: Text(
                      'Preguntas Frecuentes',
                      style: TextStyle(
                          color: kPrimaryColor,
                          fontSize: 20,
                          fontFamily: 'UbuntuRegular'),
                    ),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  ListTile(
                    onTap: () {
                      Navigator.of(context).pop();
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => AboutScreen()));
                    },
                    leading: Icon(
                      Icons.account_box_outlined,
                      color: kSecondaryColor,
                      size: 36,
                    ),
                    title: Text(
                      'Acerca de',
                      style: TextStyle(
                          color: kPrimaryColor,
                          fontSize: 20,
                          fontFamily: 'UbuntuRegular'),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ));
  }

  Future refreshData() async {

   // dbHelper.listBuy();
    //print();
    List<Product> lista = await listRecomended();
    print(list);

    setState(() {
      list = lista;
      //list.shuffle();
      // filteredProd = this.list;
    });
  }

  Widget _Welcom() {
    double result =
        MediaQuery.of(context).size.height - AppBar().preferredSize.height;
   // print(result);
    if (result >= 500) {
      return Container(
        padding: EdgeInsets.only(
            left: kDefaultPadding,
            right: kDefaultPadding,
            bottom: kDefaultPadding),
        height: MediaQuery.of(context).size.height * 0.13,
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
                'Bienvenido',
                style: TextStyle(
                    fontSize: 30,
                    color: Colors.white,
                    fontFamily: 'UbuntuRegular'),
              ),
            ),
            //Image.network('assets/img/pro.png'),
            Icon(
              Icons.home_outlined,
              size: 40,
              color: kSecondaryColor,
            ),
          ],
        ),
      );
    }
    return Text('');
  }
}
