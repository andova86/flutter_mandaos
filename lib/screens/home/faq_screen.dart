import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mandaos/models/expansion_pannel.dart';
import 'package:mandaos/utils/constants.dart';

class FaqScreen extends StatefulWidget {
  const FaqScreen({Key? key}) : super(key: key);

  @override
  _FaqScreenState createState() => _FaqScreenState();
}

class _FaqScreenState extends State<FaqScreen> {


  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery
        .of(context)
        .size;
    double result = MediaQuery
        .of(context)
        .size
        .height - AppBar().preferredSize.height;


    return Scaffold(
      backgroundColor: Colors.white,

      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        //title: Text('Productos de la Bodega'),

        backgroundColor: kPrimaryColor,
        elevation: 0,
       /* actions: [
          IconButton(onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => HistoricalBuyScreen()),
            );
          }, icon: Icon(Icons.history_outlined, color: Colors.white,))
        ],*/
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

      body: SafeArea(
        maintainBottomViewPadding: false,
        child: Column(
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
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(right: 10),
                    child: Text(
                      'Preguntas Frecuentes',
                      style: TextStyle(
                          fontSize: result < 480 ? 16 : 20,
                          color: Colors.white,
                          fontFamily: 'UbuntuRegular'),
                    ),
                  ),
                  //Image.network('assets/img/pro.png'),
                  Icon(
                    Icons.question_answer_outlined,
                    size: result < 480 ? 26 : 30,
                    color: kSecondaryColor,
                  ),
                ],
              ),
            ),

            SizedBox(height: 20,),

            Expanded(
              child: Container(
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


