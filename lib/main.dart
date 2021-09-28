// @dart=2.9
import 'package:after_layout/after_layout.dart';
import 'package:apklis_payment_checker/apklis_info.dart';
import 'package:apklis_payment_checker/apklis_info_checker.dart';
import 'package:apklis_payment_checker/apklis_payment_checker.dart';
import 'package:apklis_payment_checker/apklis_payment_status.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:mandaos/modules/products/data/ListProducts.dart';
import 'package:mandaos/modules/products/provider/product_provider.dart';
import 'package:mandaos/modules/products/screen/modify_product_screen.dart';
import 'package:mandaos/modules/products/screen/product_detail_screen.dart';
import 'package:mandaos/routes/routes.dart';
import 'package:mandaos/modules/home/screen/home_screen.dart';
import 'package:mandaos/modules/home/screen/splash_screen.dart';
import 'package:mandaos/services/database_helper.dart';
import 'package:mandaos/services/db_helper.dart';
import 'package:mandaos/utils/constants.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'modules/home/screen/paid.dart';
import 'modules/products/models/product.dart';



void main() => runApp(
  MultiProvider(
    providers: [
      //ChangeNotifierProvider(create: (_) => ColorProvider()),
      ChangeNotifierProvider(create: (_) => ProductProvider())
    ],
    child: MyApp(),
  ),
);

class MyApp extends StatelessWidget {
  //DatabaseHelper data = new DatabaseHelper();
 // final dbHelper = new DatabaseHelper();
  static int sp = 0;



  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);



    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Mis Mandaos',
      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate
      ],
      supportedLocales: [
        const Locale('es'),
        //const Locale('fr')
      ],
     // themeMode: ThemeMode.light,
      theme: ThemeData(
        fontFamily: 'UbuntuRegular',
        primaryColor: kPrimaryColor,
        textTheme: Theme.of(context).textTheme.apply(bodyColor: kTextColor,fontFamily: 'UbuntuRegular',),

        visualDensity: VisualDensity.adaptivePlatformDensity,
       // dialogTheme: ,
        pageTransitionsTheme: PageTransitionsTheme(builders: {
          TargetPlatform.iOS: ZoomPageTransitionsBuilder(),
          TargetPlatform.android: CupertinoPageTransitionsBuilder(),}),

      ),
      //darkTheme: darkThemeData(context),
      home:  Splash(),
      routes: getAplicationRoutes(),
      //initialRoute: Splash().,
      onGenerateRoute: (RouteSettings settings ){

        if (settings.name == 'productmodify') {
          // Cast the arguments to the correct
          // type: ScreenArguments.
          final prod = settings.arguments as Product;

          // Then, extract the required data from
          // the arguments and pass the data to the
          // correct screen.
          return MaterialPageRoute(
            builder: (context) {
              return ModifyProductScreen(prod: prod);
            },
          );
        }

        if (settings.name == 'productdetail') {
          // Cast the arguments to the correct
          // type: ScreenArguments.
          final prod = settings.arguments as Product;

          // Then, extract the required data from
          // the arguments and pass the data to the
          // correct screen.
          return MaterialPageRoute(
            builder: (context) {
              return ProductDetailScreen(product: prod);
            },
          );
        }




       return MaterialPageRoute(builder: (BuildContext context) => HomeScreen()
       );
      },
      //home: TestScreen(),
    );
  }




}


class Splash extends StatefulWidget {
  String result = '';


  @override
  SplashState createState() => new SplashState();
}

class SplashState extends State<Splash> with AfterLayoutMixin<Splash> {





  Future checkFirstSeen() async {




    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool _seen = (prefs.getBool('seen') ?? false);

    String appName = '';
    String packageName = '';
    String version = '';
    String buildNumber = '';

    PackageInfo.fromPlatform().then((PackageInfo packageInfo) {
      appName = packageInfo.appName;
      packageName = packageInfo.packageName;
      version = packageInfo.version;
      buildNumber = packageInfo.buildNumber;

      print('/*/*/*/*/*/*/*/*/*/*/*');
      print('El nombre es: ' + appName);
      print(packageName);
      print(version);
      print(buildNumber);
    });

   initDatabase();
    UpdateF(5);
    UpdateF(6);
    UpdateL(16);
    UpdateP(20);
    UpdatePi(22);

    //AddCig();

    if (_seen) {

      getApklisInfo().then((value) {
        print('Apklis esta instalado: ${value.isInstalled}');
        print('Code: ${value.versionCode}');
        print('Name: ${value.versionName}');



        if(value.isInstalled == false)
        {

          Navigator.of(context).pushAndRemoveUntil(
              new MaterialPageRoute(builder: (context) => new Paid()), ModalRoute.withName('paid'));

        }
        else{
          AddCig();



          Navigator.of(context).pushAndRemoveUntil(
              new MaterialPageRoute(builder: (context) => new HomeScreen()), ModalRoute.withName('home'));
        }

      } );
      /*_getApklis(packageName).then((value) {

        print('El valor es: ${value.paid}   ${value.username} ');
        if(value.paid == false)
        {
          Navigator.of(context).pushAndRemoveUntil(
              new MaterialPageRoute(builder: (context) => new Paid()), ModalRoute.withName('paid'));

        }


      } );*/



    } else {

      getApklisInfo().then((value) async {
        print('Apklis esta instalado: ${value.isInstalled}');
        print('Code: ${value.versionCode}');
        print('Name: ${value.versionName}');

        if(value.isInstalled == false)
        {

          Navigator.of(context).pushAndRemoveUntil(
              new MaterialPageRoute(builder: (context) => new Paid()), ModalRoute.withName('paid'));

        }
        else{

          _initProduct();
          _initConfig();
          await prefs.setBool('seen', true);
          Navigator.of(context).pushAndRemoveUntil(
              new MaterialPageRoute(builder: (context) => new SplashScreen()), ModalRoute.withName('splash'));

        }

      } );

       }
  }


  Future<ApklisPaymentStatus> _getApklis(String packageName) async {
    var status = await ApklisPaymentChecker.isPurchased(packageName);

    return status;

  }

  Future<ApklisInfo> getApklisInfo() async {
    final apklisInfo = await ApklisInfoCheck.getApklisInfo();
    return apklisInfo;
  }

  @override
  void afterFirstLayout(BuildContext context) => checkFirstSeen();

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: new Center(
        child: CircularProgressIndicator(

        ),

      ),
    );
  }
}

void _initProduct() async {
  int count = await queryRowCount();
  print('La cantidad de productos es: ' + count.toString());

  if (count == 0) {
    for (int i = 0; i < list_products.length; i++) {
      Map<String, dynamic> row = {
        columnTitle: list_products[i].title,
        columnPrice: list_products[i].price,
        columnCuota: list_products[i].cuota,
        columnUM: list_products[i].um,
        columnImg: list_products[i].img,
        columnKid: list_products[i].kid,
        columnRecomended: list_products[i].recomended,
      };

      final id = await insert(row, table);

      print('inserted row id: $id');
    }
  }
}
void _initConfig() async {
  List<Map> items = await queryAllRows(table_config);
  print(items);
  if (items.length == 0) {
    Map<String, dynamic> row2 = {
      columnSplash: 0,
      columnNinos37: 0,
      columnBebes: 0,
      columnAdultos: 0,
    };

    final id =  insert(row2, table_config);
    print('***** Configuración Inicial *****************');
    List<Map> items2 = await queryAllRows(table_config);
    print(items2.length.toString() + " elementos");
  }





}

