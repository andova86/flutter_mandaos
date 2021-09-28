

import 'package:flutter/material.dart';
import 'package:mandaos/modules/cart/screen/buy_product_screen.dart';
import 'package:mandaos/modules/cart/screen/historical_buy.dart';
import 'package:mandaos/modules/home/screen/about_screen.dart';
import 'package:mandaos/modules/home/screen/config_screen.dart';
import 'package:mandaos/modules/home/screen/faq_screen.dart';
import 'package:mandaos/modules/home/screen/help_screen.dart';
import 'package:mandaos/modules/home/screen/home_screen.dart';
import 'package:mandaos/modules/home/screen/paid.dart';
import 'package:mandaos/modules/home/screen/splash_screen.dart';
import 'package:mandaos/modules/pdf/screens/document_screen.dart';
import 'package:mandaos/modules/products/screen/Convertion_screen.dart';
import 'package:mandaos/modules/products/screen/list_product_screen.dart';
import 'package:mandaos/modules/products/screen/modify_product_screen.dart';
import 'package:mandaos/modules/products/screen/product_detail_screen.dart';
import 'package:mandaos/modules/reports/screen/monthly_screen.dart';

Map <String, WidgetBuilder> getAplicationRoutes(){


  final HomeScreen _Home_page = HomeScreen();
  final ConfigScreen _Config_page = ConfigScreen();
  final SplashScreen _Splash_page = SplashScreen();
  final AboutScreen _About_page = AboutScreen();
  final HelpScreen _Help_page = HelpScreen();
  final FaqScreen _Faq_page = FaqScreen();
  final DocumentScreen _Docs_page = DocumentScreen();
  final ListProductScreen _ListProducts_page = ListProductScreen();
  final BuyProductScreen _Buy_page = BuyProductScreen();
  final HistoricalBuyScreen _HistoricalBuy_page = HistoricalBuyScreen();
  final LineChartSample2 _Line_page = LineChartSample2();
  final Paid _paid = Paid();




final ConvertionScreen Convertion_page = ConvertionScreen();


  final routes = <String, WidgetBuilder>{

    'home'        : ( BuildContext context ) => _Home_page,
    'config'      : ( BuildContext context ) => _Config_page,
    'splash'      : ( BuildContext context ) => _Splash_page,
    'about'       : ( BuildContext context ) => _About_page,
    'help'        : ( BuildContext context ) => _Help_page,
    'faq'         : ( BuildContext context ) => _Faq_page,
    'docs'        : ( BuildContext context ) => _Docs_page,
    'products'    : ( BuildContext context ) => _ListProducts_page,
    'buy'         : ( BuildContext context ) => _Buy_page,
    'historybuy'  : ( BuildContext context ) => _HistoricalBuy_page,
    'chart'       : ( BuildContext context ) => _Line_page,
    'convert'     : ( BuildContext context ) => Convertion_page,
    'paid'        : ( BuildContext context ) => _paid,
    //'productdetail' : ( BuildContext context ) => ProductDetailScreen(),
    //'productmodify' : ( BuildContext context ) => ModifyProductScreen(),
  };

  return routes;

}

