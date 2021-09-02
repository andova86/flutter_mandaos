import 'dart:io';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mandaos/generated/assets.dart';
import 'package:mandaos/modules/pdf/api/pdf_api.dart';
import 'package:mandaos/modules/pdf/screens/pdf_view.dart';
import 'package:mandaos/utils/funtions.dart';

class DocumentScreen extends StatelessWidget {
  //const DocumentScreen({Key? key}) : super(key: key);
  void openPDF(BuildContext context, File file, int initPage) => Navigator.of(context).push(
    MaterialPageRoute(builder: (context) => PDFViewerPage(file: file, initPage: initPage)),
  );
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Documentos Importantes',style: TextStyle(fontFamily: 'UbuntuRegular')),
      ),


      body: Container(
        child:   ListView(
          children: [
            ListTile(
              onTap: () async {
                String path = 'assets/img/goc2021ex410.pdf';
                final file = await PDFApi.loadAsset(Assets.imgPancarta);
                print(file);
                if (file == null) Message('No se encontró el documento', context);
                openPDF(context, file, 0);
              },
              leading: Icon(Icons.picture_as_pdf_outlined),
              title: Text('PRECIOS ESTABLECIDOS',style: TextStyle(fontFamily: 'UbuntuRegular')),
              subtitle: Text('para productos de la canasta familiar normada',style: TextStyle(fontFamily: 'UbuntuRegular')),
            ),

            ListTile(
              onTap: () {
                PDF_fromURL(context, 'https://www.gacetaoficial.gob.cu/sites/default/files/goc-2020-ex71_0.pdf', 126);
              },
              leading: Icon(Icons.picture_as_pdf_outlined),
              title: Text('RESOLUCIÓN No. 346-2020',style: TextStyle(fontFamily: 'UbuntuRegular')),
              subtitle: Text('Precio minorita de los productos alimenticios', style: TextStyle(fontFamily: 'UbuntuRegular'),),
            ),
            Divider(),
            ListTile(
              onTap: () {
                PDF(context);
              },
              leading: Icon(Icons.picture_as_pdf_outlined),
              title: Text('Distribución de productos',style: TextStyle(fontFamily: 'UbuntuRegular')),
              subtitle: Text('La Habana',style: TextStyle(fontFamily: 'UbuntuRegular')),
            ),
            Divider(),
            ListTile(
              onTap: () async {
                String path = 'assets/img/goc2021ex410.pdf';
                final file = await PDFApi.loadAsset(path);
                print(file);
                if (file == null) Message('No se encontró el documento', context);
                openPDF(context, file, 0);
              },
              leading: Icon(Icons.picture_as_pdf_outlined),
              title: Text('Gaceta Oficial No. 41 Extraordinaria ',style: TextStyle(fontFamily: 'UbuntuRegular')),
              subtitle: Text('Establece los precios y descripción del producto arroz para la venta normada, controlada y liberada a la población.',style: TextStyle(fontFamily: 'UbuntuRegular')),
            ),
          ],
        ),
      ),
    );


  }

  Future<void> PDF(BuildContext context) async {
  var newDate = new DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day - 1);

  String day = DateFormat('dd').format(newDate);
  String month = DateFormat('MM').format(newDate);
  String year = DateFormat('yyyy').format(newDate);

  var _url = 'http://www.tribuna.cu/file/pdf/'+ year + '/'+ month+'/' + day+ '/Tribuna_'+year+month+day+'02';


  final url =
      'http://www.tribuna.cu/file/pdf/2021/08/29/Tribuna_2021082902.pdf';
  final file = await PDFApi.loadNetwork(_url);
  print(file);
  if(file.existsSync())
    {
      Message('Hola', context);

    }
  else{
    Message('No', context);
  }
  openPDF(context, file, 0);
}

  Future<void> PDF_fromURL(BuildContext context, String url, int initPage) async {


    final file = await PDFApi.loadNetwork(url);
    openPDF(context, file, initPage);
  }

  Future<void> PDFGaceta41(BuildContext context) async {

  }

}
