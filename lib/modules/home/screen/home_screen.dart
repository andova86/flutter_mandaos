import 'package:card_swiper/card_swiper.dart';

import 'package:double_back_to_close_app/double_back_to_close_app.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:mandaos/modules/products/models/product.dart';
import 'package:mandaos/modules/products/screen/list_product_screen.dart';

import 'package:mandaos/services/db_helper.dart';
import 'package:mandaos/utils/constants.dart';
import 'package:mandaos/utils/headers.dart';
import 'package:mandaos/widgets/ui/badgeUI.dart';
import 'package:mandaos/modules/home/widget/card_carrousel.dart';
import 'package:package_info_plus/package_info_plus.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String version = '';
  List<Product> list = [];

  int cantProductos = 0;
  int cantBuy = 0;
  int cantGastos = 0;
  int cantCons = 0;

  // List<Product> filteredProd = [];
  //String _searchText = "";

  @override
  Widget build(BuildContext context) {
    print('building Pantalla Principal');

    return Scaffold(
      drawer: _Drawer(version: version),
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

        actions: <Widget>[BadgeUI()],
      ),
      body: DoubleBackToCloseApp(
        snackBar: const SnackBar(
          duration: Duration(seconds: 1),
          content: Text('Toca de nuevo para salir de la aplicación.'),
        ),
        child: Column(
          children: [
            const HeaderM(title: 'Bienvenido', ico: Icons.home),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Container(
                      padding: EdgeInsets.only(left: 15, right: 15, top: 10),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              _Recomended(),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Column(
                      children: [
                        SizedBox(
                          height: 10,
                        ),


                        Swiper(
                          itemBuilder: (BuildContext context, int index) {
                            return CardCarrousel(prod: list[index]);
                          },
                          itemCount: list.length,
                          itemWidth: 230.0,
                          itemHeight: 230.0,
                          layout: SwiperLayout.STACK,
                          viewportFraction: 0.8,
                          scale: 0.9,
                          autoplay: true,

                        ),
                        SizedBox(
                          height: 20,
                        ),

                        // const _doBuy(),
                      ],
                    ),
                    const _Steps(),
                    /* Row(
                     mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 0),
                          child: Badge(
                            badgeContent: Text(DateTime.now().year.toString(), style: TextStyle(color: Colors.white, fontSize: 14),),
                            shape: BadgeShape.square,
                            borderRadius: BorderRadius.circular(10),
                            // padding: EdgeInsets.all(4),
                            showBadge: true,
                            alignment: Alignment.center,

                          ),
                        ),
                      ],
                    ),*/
                    Row(
                      children: [
                        _HomeBox(
                          title: 'Compras ',
                          subtitle: cantBuy.toString(),
                          icon: CupertinoIcons.shopping_cart,
                          route: 'buy',
                          color: Color(0xffF2EBE9),
                        ),
                        _HomeBox(
                          title: 'Gastos (cup)',
                          subtitle: cantGastos.toString(),
                          icon: CupertinoIcons.money_dollar_circle,
                          color: Color(0xffF0F0F3),
                          route: 'chart',
                        ),
                      ],
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _HomeBox(
                          title: 'Productos ',
                          subtitle: '$cantProductos',
                          icon: CupertinoIcons.list_bullet_below_rectangle,
                          color: kotherColor,
                          route: 'products',
                        ),
                        _HomeBox(
                          title: 'Consumidores',
                          subtitle: cantCons.toString(),
                          icon: CupertinoIcons.group,
                          color: Color(0xffDAF1E4),
                          route: 'config',
                        ),
                      ],
                    ),
                  ],
                ),
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

    getCantProds();
    getCantBuys();

    getCantBuy();
    getCantCons();

    //dbHelper.listConfig();
  }

  @override
  void dispose() {
    super.dispose();
  }

  Future refreshData() async {
    // dbHelper.listBuy();
    //print();
   listRecomended().then((value) {

     setState(() {
       list = value;
       //list.shuffle();
       // filteredProd = this.list;
     });
   });
    print(list);


  }

  Future getCantBuys() async {
    int c = await cantDatesBuysInYear(DateTime.now().year);

    setState(() {
      cantBuy = c;
    });
  }

  Future getCantProds() async {
    int c = await cantProds();

    setState(() {
      cantProductos = c;
    });
  }

  Future getCantBuy() async {
    int c = await cantBuysInYear(DateTime.now().year);

    setState(() {
      cantGastos = c;
    });
  }

  Future getCantCons() async {
    int c = await cantConsumers();

    setState(() {
      cantCons = c;
    });
  }
}

class TriangleClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();
    path.moveTo(0.0, 0.0);
    path.lineTo(size.width, size.height);
    path.lineTo(0.0, size.height);
    path.close();
    return path;

    return path;
  }

  @override
  bool shouldReclip(TriangleClipper oldClipper) => false;
}

class _HomeBox extends StatelessWidget {
  const _HomeBox({
    Key? key,
    required this.title,
    required this.subtitle,
    required this.color,
    required this.icon,
    required this.route,
  }) : super(key: key);

  final String title;
  final String subtitle;

  final Color color;
  final IconData icon;
  final String route;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        onTap: () {
          Navigator.pushNamed(context, route);
        },
        child: Container(
          height: 130,
          margin: EdgeInsets.all(10),
          padding: EdgeInsets.all(10),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: color,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    FittedBox(
                        child: Text(
                      title,
                      style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: kPrimaryColor.withOpacity(0.8)),
                    )),
                    // Divider(height: 10,color: Colors.black12,endIndent: 20,indent: 10,thickness: 2,),

                    FittedBox(
                      child: Text(
                        subtitle,
                        style: TextStyle(
                            fontSize: 32,
                            fontWeight: FontWeight.bold,
                            color: kPrimaryColor),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Icon(
                      icon,
                      color: kPrimaryColor.withOpacity(.7),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _Recomended extends StatelessWidget {
  const _Recomended();

  @override
  Widget build(BuildContext context) {
    return Text(
      'Recomendados para ti',
      style: TextStyle(
          color: kPrimaryColor,
          fontSize: 24,
          fontFamily: 'UbuntuRegular',
          fontWeight: FontWeight.bold),
    );
  }
}

class _Drawer extends StatelessWidget {
  const _Drawer({
    Key? key,
    required this.version,
  }) : super(key: key);

  final String version;

  @override
  Widget build(BuildContext context) {
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
                  'Mis Mandaos',
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
                  'Versión ' + version,
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
                  //Navigator.of(context).pop();

                  Navigator.of(context).pushAndRemoveUntil(
                      new MaterialPageRoute(
                          builder: (context) => new HomeScreen()),
                      ModalRoute.withName('home'));
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
                      fontSize: 16,
                      fontFamily: 'UbuntuRegular'),
                ),
              ),
              ListTile(
                onTap: () {
                  Navigator.of(context).pop();
                  //aqui
                  Navigator.pushNamed(context, 'products');
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
                      fontSize: 16,
                      fontFamily: 'UbuntuRegular'),
                ),
              ),
              ListTile(
                onTap: () {
                  Navigator.of(context).pop();
                  Navigator.pushNamed(context, 'buy');
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
                      fontSize: 16,
                      fontFamily: 'UbuntuRegular'),
                ),
              ),
              SizedBox(
                height: 5,
              ),
              ListTile(
                onTap: () {
                  Navigator.of(context).pop();
                  Navigator.pushNamed(context, 'historybuy');
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
                      fontSize: 16,
                      fontFamily: 'UbuntuRegular'),
                ),
              ),
              SizedBox(
                height: 5,
              ),
              ListTile(
                onTap: () {
                  Navigator.of(context).pop();
                  Navigator.pushNamed(context, 'chart');
                },
                leading: Icon(
                  Icons.show_chart,
                  color: kSecondaryColor,
                  size: 36,
                ),
                title: Text(
                  'Reportes',
                  style: TextStyle(
                      color: kPrimaryColor,
                      fontSize: 16,
                      fontFamily: 'UbuntuRegular'),
                ),
              ),
              SizedBox(
                height: 5,
              ),
              ListTile(
                onTap: () {
                  Navigator.of(context).pop();
                  Navigator.pushNamed(context, 'convert');
                },
                leading: Icon(
                  CupertinoIcons.selection_pin_in_out,
                  color: kSecondaryColor,
                  size: 36,
                ),
                title: Text(
                  'Convertir UM',
                  style: TextStyle(
                      color: kPrimaryColor,
                      fontSize: 16,
                      fontFamily: 'UbuntuRegular'),
                ),
              ),
              SizedBox(
                height: 5,
              ),
              ListTile(
                onTap: () {
                  Navigator.of(context).pop();
                  Navigator.pushNamed(context, 'copy');
                },
                leading: Icon(
                  Icons.backup,
                  color: kSecondaryColor,
                  size: 36,
                ),
                title: Text(
                  'Copia de Seguridad',
                  style: TextStyle(
                      color: kPrimaryColor,
                      fontSize: 16,
                      fontFamily: 'UbuntuRegular'),
                ),
              ),
              SizedBox(
                height: 5,
              ),
              ListTile(
                onTap: () {
                  Navigator.of(context).pop();
                  Navigator.pushNamed(context, 'config');
                },
                leading: Icon(
                  Icons.settings,
                  color: kSecondaryColor,
                  size: 36,
                ),
                title: Text(
                  'Configuración',
                  style: TextStyle(
                      color: kPrimaryColor,
                      fontSize: 16,
                      fontFamily: 'UbuntuRegular'),
                ),
              ),
              SizedBox(
                height: 5,
              ),
              ListTile(
                onTap: () {
                  Navigator.of(context).pop();
                  Navigator.pushNamed(context, 'help');
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
                      fontSize: 16,
                      fontFamily: 'UbuntuRegular'),
                ),
              ),
              SizedBox(
                height: 5,
              ),
              ListTile(
                onTap: () {
                  Navigator.of(context).pop();
                  Navigator.pushNamed(context, 'faq');
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
                      fontSize: 16,
                      fontFamily: 'UbuntuRegular'),
                ),
              ),
              SizedBox(
                height: 5,
              ),
              ListTile(
                onTap: () {
                  Navigator.of(context).pop();
                  Navigator.pushNamed(context, 'docs');
                },
                leading: Icon(
                  CupertinoIcons.doc_plaintext,
                  color: kSecondaryColor,
                  size: 36,
                ),
                title: Text(
                  'Documentos',
                  style: TextStyle(
                      color: kPrimaryColor,
                      fontSize: 16,
                      fontFamily: 'UbuntuRegular'),
                ),
              ),
              SizedBox(
                height: 5,
              ),
              ListTile(
                onTap: () {
                  Navigator.of(context).pop();
                  Navigator.pushNamed(context, 'about');
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
                      fontSize: 16,
                      fontFamily: 'UbuntuRegular'),
                ),
              ),
            ],
          ),
        ),
      ],
    ));
  }
}

class _DoBuy extends StatelessWidget {
  const _DoBuy({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
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
                            builder: (context) => ListProductScreen()));
                  },
                  style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all(Colors.redAccent)),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Empecemos',
                        style: TextStyle(
                            color: Colors.white, fontFamily: 'UbuntuRegular'),
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
    );
  }
}

class _Steps extends StatelessWidget {
  const _Steps({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.maxFinite,
      padding: EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'En solo 3 pasos, verifíca tu compra.  ',
            style: TextStyle(
                color: kPrimaryColor,
                fontSize: 16,
                fontFamily: 'UbuntuRegular',
                fontWeight: FontWeight.bold),
          ),
          SizedBox(
            height: 10,
          ),
          Text(
            '  1- Ver y seleccionar productos.',
            style: TextStyle(
                fontFamily: 'UbuntuRegular',
                color: kPrimaryColor,
                fontSize: 12),
          ),
          SizedBox(
            height: 5,
          ),
          Text(
            '  2- Verificar precio por producto y el total a pagar.',
            style: TextStyle(
              fontFamily: 'UbuntuRegular',
              color: kPrimaryColor,
              fontSize: 12,
            ),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
          SizedBox(
            height: 5,
          ),
          Text(
            '  3- Guarda tu compra virtual.',
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
    );
  }
}
