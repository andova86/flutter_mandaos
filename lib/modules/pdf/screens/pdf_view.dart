
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:mandaos/utils/constants.dart';
import 'package:mandaos/utils/funtions.dart';
import 'package:path/path.dart';

class PDFViewerPage extends StatefulWidget {
  final File file;
  final int initPage;


   PDFViewerPage({required this.file, required this.initPage});

  @override
  _PDFViewerPageState createState() => _PDFViewerPageState();
}

class _PDFViewerPageState extends State<PDFViewerPage> {
  PDFViewController? controller;
  int pages = 0;
  int indexPage = 0;

  @override
  Widget build(BuildContext context) {
    final name = basename(widget.file.path);
    final text = '${indexPage + 1} of $pages';

    return Scaffold(
      appBar: AppBar(
        backgroundColor: kPrimaryColor,
        title: Text(name),
        actions: pages >= 2
        ? [
        Center(child: Text(text)),
        IconButton(
          icon: Icon(Icons.chevron_left, size: 32),
          onPressed: () {
            final page = indexPage == 0 ? pages : indexPage - 1;
            controller!.setPage(page);
          },
        ),
        IconButton(
          icon: Icon(Icons.chevron_right, size: 32),
          onPressed: () {
            final page = indexPage == pages - 1 ? 0 : indexPage + 1;
            controller!.setPage(page);
          },
        ),
        ]
        : null,
      ),
      body: PDFView(
        filePath: widget.file.path,
        defaultPage: widget.initPage,
        // autoSpacing: false,
        // swipeHorizontal: true,
        // pageSnap: false,
        // pageFling: false,
        onRender: (pages) => setState(() => this.pages = pages!),
        onError: (error){
          print('Perro');
          //Message('Error al abrir la url del Tribuna', context);
        },
        onPageError: (page, error){

          //Message('Error al abrir la url del Tribuna', context);
        },
        onViewCreated: (controller) =>
            setState(() => this.controller = controller),
        onPageChanged: (indexPage, _) =>
            setState(() => this.indexPage = indexPage!),
      ),
    );


  }

  @override
  void initState() {
    indexPage = widget.initPage;
    super.initState();
    print('La pagina es : '+ indexPage.toString());

  }

  @override
  void dispose() {
    super.dispose();
  }
}