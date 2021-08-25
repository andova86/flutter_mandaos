import 'package:flutter/material.dart';
import 'package:mandaos/services/db_helper.dart';
import 'package:mandaos/services/db_helper.dart';

class TestScreen extends StatelessWidget {
  const TestScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {


    initDatabase();


    return Container(child: Center(child: Text('Hola')),);
  }
}
