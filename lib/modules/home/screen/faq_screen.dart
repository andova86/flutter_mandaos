import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mandaos/modules/home/models/expansion_pannel.dart';
import 'package:mandaos/utils/constants.dart';
import 'package:mandaos/utils/headers.dart';

class FaqScreen extends StatefulWidget {
  const FaqScreen({Key? key}) : super(key: key);

  @override
  _FaqScreenState createState() => _FaqScreenState();
}

class _FaqScreenState extends State<FaqScreen> {


  @override
  Widget build(BuildContext context) {


    return Scaffold(
      backgroundColor: Colors.white,

      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        //title: Text('Productos de la Bodega'),

        backgroundColor: kPrimaryColor,
        elevation: 0,

      ),

      body: SafeArea(
        maintainBottomViewPadding: false,
        child: Column(
          children: [
           const HeaderM(title: 'Preguntas Frecuentes', ico: Icons.question_answer_outlined),

            Expanded(
              child:
              Container(
                padding: EdgeInsets.all(10),
                margin: EdgeInsets.all(10),
                child:
                ListView.builder(
                  itemCount: itemData.length,
                  itemBuilder: (BuildContext context, int index) {
                    return ExpansionPanelList(


                      animationDuration: Duration(milliseconds: 500),
                      dividerColor: kSecondaryColor,

                      children: [
                        ExpansionPanel(

                          body: Container(
                            padding: EdgeInsets.only(left: 15, right: 15, bottom: 15),
                            child: Text(
                              itemData[index].description,
                              style: TextStyle(
                                  color: kPrimaryColor.withOpacity(.8),
                                  fontFamily: 'UbuntuRegular',
                                  fontSize: 14,
                                  letterSpacing: 0.3,
                                  height: 1.3),
                            ),
                          ),
                          headerBuilder: (BuildContext context,
                              bool isExpanded) {
                            return Container(
                              padding: EdgeInsets.all(15),
                              child: Text(
                                itemData[index].headerItem,
                                style: TextStyle(
                                  fontFamily: 'UbuntuRegular',
                                  color: itemData[index].colorsItem,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold
                                ),
                              ),
                            );
                          },
                          isExpanded: itemData[index].expanded,
                        )
                      ],
                      expansionCallback: (int item, bool status) {
                        setState(() {
                          itemData[index].expanded = !itemData[index].expanded;
                        });
                      },
                    );
                  },
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
  }

  @override
  void dispose() {
    super.dispose();
  }
}


