import 'dart:io';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mandaos/generated/assets.dart';
import 'package:mandaos/modules/pdf/api/pdf_api.dart';
import 'package:mandaos/modules/pdf/screens/pdf_view.dart';
import 'package:mandaos/utils/constants.dart';
import 'package:mandaos/utils/funtions.dart';
import 'package:mandaos/utils/headers.dart';

class DocumentScreen extends StatelessWidget {
  //const DocumentScreen({Key? key}) : super(key: key);
  void openPDF(BuildContext context, File file, int initPage) =>
      Navigator.of(context).push(
        MaterialPageRoute(
            builder: (context) =>
                PDFViewerPage(file: file, initPage: initPage)),
      );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: kPrimaryColor,

      ),
      body: Column(
        children: [
         const HeaderM(title: 'Documentos ', ico: Icons.picture_as_pdf_outlined),
          Expanded(
            child: SingleChildScrollView(
              physics: BouncingScrollPhysics(),
              child: Column(
                children: [
                  ListTile(
                    onTap: () async {
                      String path = 'assets/img/goc2021ex410.pdf';
                      final file = await PDFApi.loadAsset(Assets.imgPancarta);
                      print(file);
                      if (file == null)
                        Message('No se encontró el documento', context);
                      openPDF(context, file, 0);
                    },
                    leading: Icon(Icons.picture_as_pdf_outlined),
                    title: Text('PRECIOS ESTABLECIDOS',
                        style: TextStyle(fontFamily: 'UbuntuRegular')),
                    subtitle: Text(
                        'para productos de la canasta familiar normada',
                        style: TextStyle(fontFamily: 'UbuntuRegular')),
                  ),
                  Divider(),
                  ListTile(
                    onTap: () {
                      PDF_fromURL(
                          context,
                          'https://www.gacetaoficial.gob.cu/sites/default/files/goc-2020-ex71_0.pdf',
                          126);
                    },
                    leading: Icon(Icons.picture_as_pdf_outlined),
                    title: Text('RESOLUCIÓN No. 346-2020',
                        style: TextStyle(fontFamily: 'UbuntuRegular')),
                    subtitle: Text(
                      'Precio minorita de los productos alimenticios',
                      style: TextStyle(fontFamily: 'UbuntuRegular'),
                    ),
                  ),
                  Divider(),
                  ListTile(
                    onTap: () {


                      PDF(context);

                    },
                    leading: Icon(Icons.picture_as_pdf_outlined,color: Colors.red,),
                    title: Text('DISTRIBUCIÓN DE PRODUCTOS',
                        style: TextStyle(fontFamily: 'UbuntuRegular')),
                    subtitle: Text('La Habana',
                        style: TextStyle(fontFamily: 'UbuntuRegular')),
                  ),
                  Divider(),
                  ListTile(
                    onTap: () async {
                      String path = 'assets/img/goc2021ex410.pdf';
                      final file = await PDFApi.loadAsset(path);
                      print(file);
                      if (file == null)
                        Message('No se encontró el documento', context);
                      openPDF(context, file, 0);
                    },
                    leading: Icon(Icons.picture_as_pdf_outlined),
                    title: Text('Gaceta Oficial No. 41 Extraordinaria ',
                        style: TextStyle(fontFamily: 'UbuntuRegular')),
                    subtitle: Text(
                        'Establece los precios y descripción del producto arroz para la venta normada, controlada y liberada a la población.',
                        style: TextStyle(fontFamily: 'UbuntuRegular')),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> PDF(BuildContext context) async {
    var today = DateTime.now();
    int cant = getLastSunday(today);
    var newDate = new DateTime(today.year, today.month, today.day - cant);

    String day = DateFormat('dd').format(newDate);
    String month = DateFormat('MM').format(newDate);
    String year = DateFormat('yyyy').format(newDate);

    var _url = 'http://www.tribuna.cu/file/pdf/' +
        year +
        '/' +
        month +
        '/' +
        day +
        '/Tribuna_' +
        year +
        month +
        day +
        '02';

    final url =
        'http://www.tribuna.cu/file/pdf/2021/08/29/Tribuna_2021082902.pdf';
    PDF_fromURL(context, _url, 0);




  }

  Future<void> PDF_fromURL(
      BuildContext context, String url, int initPage) async {
   PDFApi.loadNetwork(url).then((file) {
     openPDF(context, file, initPage);
     print('termino');
   }).catchError((value) {

   Message('Error al cargar el documento. Revise su conexión a internet.', context);
   });

  }

  int getLastSunday(DateTime date) {
    String day = DateFormat('EEEE').format(newDate);
    print(day);
    int cant = 1;

    switch (day) {
      case 'Monday':
        {
          cant = 2;
        }
        break;

      case 'Tuesday':
        {
          cant = 3;
        }
        break;

      case 'Wednesday':
        {
          cant = 4;
        }
        break;

      case 'Thursday':
        {
          cant = 5;
        }
        break;

      case 'Friday':
        {
          cant = 6;
        }
        break;

      case 'Saturday':
        {
          cant = 7;
        }
        break;

      default:
        {
          //statements;
        }
        break;
    }

    print(cant);
    return cant;
  }
}
