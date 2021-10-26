import 'dart:async';

import 'package:animate_do/animate_do.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mandaos/modules/products/models/product.dart';
import 'package:mandaos/modules/products/provider/product_provider.dart';
import 'package:mandaos/modules/products/widget/card_prod_home_gv.dart';
import 'package:mandaos/services/db_helper.dart';
import 'package:mandaos/utils/constants.dart';
import 'package:mandaos/utils/funtions.dart';
import 'package:mandaos/utils/helper.dart';
import 'package:mandaos/widgets/ui/badgeUI.dart';
import 'package:provider/provider.dart';



class ListProductScreen extends StatefulWidget {
  const ListProductScreen({Key? key}) : super(key: key);

  @override
  _ListProductScreenState createState() => _ListProductScreenState();
}

class _ListProductScreenState extends State<ListProductScreen> {
  TextEditingController _filter = new TextEditingController();

  List<Product> list = [];
  List<Product> list2 = [];
  List<Product> filteredProd = [];

  Color _color = kPrimaryColor;

  /* _ListProductScreenState() {
    _filter.addListener(() {

    }


    );
  }
*/
  @override
  Widget build(BuildContext context) {
   // print(' pinta la lista');
    final _prodProvider = Provider.of<ProductProvider>(context, listen: false);

    Size size = MediaQuery.of(context).size;
    changeStatusLight();


    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: kPrimaryColor,

        actions: <Widget>[

          Padding(
            padding: const EdgeInsets.all(15.0),
            child: IconButton(onPressed: (){
              Navigator.pushNamed(context, 'addproduct',
                  arguments: 0);


            }, icon: Icon(CupertinoIcons.add_circled_solid)),
          ),



          BadgeUI(),


        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          refreshData().whenComplete(() => MessageSnackBar('Datos actualizados', context, Icons.list, Colors.blueAccent));

        },
        backgroundColor: Colors.red,
        mini: true,
        child: Icon(Icons.refresh, color: Colors.white,),
      ),
      body: Column(
        children: <Widget>[
          Container(
            height: size.height * 0.2,
            child: Stack(
              children: <Widget>[
                const _Head(),

                Positioned(
                    bottom: 0,
                    left: 0,
                    right: 0,
                    child: Container(
                      alignment: Alignment.center,
                      margin: EdgeInsets.symmetric(horizontal: kDefaultPadding),
                      height: 54,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.all(Radius.circular(20)),
                          boxShadow: [
                            BoxShadow(
                              offset: Offset(0, 1),
                              blurRadius: 10,
                            ),
                          ]),
                      child: TextField(
                        controller: _filter,
                        decoration: InputDecoration(
                            hintText: "Buscar",
                            contentPadding: EdgeInsets.all(10),
                            enabledBorder: InputBorder.none,
                            focusedBorder: InputBorder.none,
                            suffixIcon: Icon(
                              Icons.search,
                              size: 24.0,
                              color: kPrimaryColor,
                            ),
                            hintStyle: TextStyle(
                              color: kPrimaryColor.withOpacity(0.5),
                            )),
                        onTap: () {
                          //print('lista');
                        },
                        onChanged: (value) {
                          if (value.isEmpty) {
                            setState(() {
                              _filter.text = "";
                              filteredProd = list;
                            });
                          } else {
                            setState(() {
                              List<Product> tempList = [];
                              for (int i = 0; i < list.length; i++) {
                                if (list[i]
                                    .title
                                    .toLowerCase()
                                    .contains(value.toLowerCase())) {
                                  tempList.add(list[i]);
                                }
                              }

                              filteredProd = tempList;
                            });
                          }
                        },
                      ),
                    )),
              ],
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Expanded(child: _buildList2(_prodProvider)),
        ],
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    // refreshData();
    _getData().then((val) {
      setState(() {
        list = list2;
        filteredProd = list2;
      });
      print("success");
    }).catchError((error, stackTrace) {
      print("outer: $error");
    });
  }

  @override
  void dispose() {
    super.dispose();
  }




  Widget _buildList2(_prodProvider) {
    print(' Building listview productos');
    return GridView.builder(
        gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
            maxCrossAxisExtent: 250,
            childAspectRatio: 2 / 2,
            crossAxisSpacing: 5,
            mainAxisSpacing: 5),
        itemCount: filteredProd.length,
        itemBuilder: (BuildContext ctx, index) {
          return FadeIn(
            // duration: Duration(milliseconds: 200 * index),
            child: Container(
              margin: EdgeInsets.all(10),
              child: Stack(
                fit: StackFit.expand,
                children: [
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                          bottomRight: Radius.circular(20),
                          bottomLeft: Radius.circular(20),
                          topRight: Radius.circular(20)),
                      boxShadow: [
                        BoxShadow(
                            color: kPrimaryColor,
                            blurRadius: 5,
                            spreadRadius: 0.5,
                            offset: Offset(0, 1))
                      ],
                    ),
                    child: CardProductHomeGV(
                      product: filteredProd[index],
                      cantPeople: 1,
                    ),
                  ),
                  Positioned(
                    left: 0,
                    top: 0,
                    child: new Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(
                              bottomRight: Radius.circular(80)),
                          color: _color,
                        ),
                        child: IconButton(
                          padding: EdgeInsets.only(top: 8),
                          alignment: Alignment.topCenter,
                          icon: Icon(
                            Icons.add_shopping_cart_rounded,
                            color: Colors.white,
                            size: 22,
                          ),
                          focusColor: kSecondaryColor,
                          tooltip: 'Haga Clic para añadir al carrito.',
                          onPressed: () {
                            showDialog(
                                barrierDismissible: false,
                                context: context,
                                builder: (_) => new AlertDialog(
                                      content: Text(
                                        'Añadir al carrito de compra.',
                                        style: TextStyle(color: kPrimaryColor),
                                      ),
                                      actions: [
                                        TextButton(
                                          onPressed: () {
                                            bool result =
                                                _prodProvider.addToCatalog(
                                                    filteredProd[index]);

                                            Navigator.of(context).pop();

                                            final snackBar;

                                            if (result) {
                                              snackBar = SnackBar(
                                                  duration:
                                                      Duration(seconds: 1),
                                                  content: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.start,
                                                    children: [
                                                      Icon(
                                                        Icons.check,
                                                        color: Colors.green,
                                                      ),
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .only(left: 10),
                                                        child: Text(
                                                            'Se añadió este producto al carrito.'),
                                                      ),
                                                    ],
                                                  ));
                                            } else {
                                              snackBar = SnackBar(
                                                  duration:
                                                      Duration(seconds: 1),
                                                  content: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.start,
                                                    children: [
                                                      Icon(
                                                        Icons.warning,
                                                        color: Colors.red,
                                                      ),
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .only(left: 10),
                                                        child: Text(
                                                            'Ya usted añadió este producto.'),
                                                      ),
                                                    ],
                                                  ));
                                            }

                                            ScaffoldMessenger.of(context)
                                                .showSnackBar(snackBar);
                                          },
                                          child: Text('Agregar',
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontFamily: 'UbuntuRegular')),
                                          style: ButtonStyle(
                                              backgroundColor:
                                                  MaterialStateProperty.all(
                                                      kPrimaryColor)),
                                        ),
                                        TextButton(
                                          onPressed: () {
                                            Navigator.of(context).pop();
                                          },
                                          child: Text(
                                            'Cancelar',
                                            style: TextStyle(color: Colors.red),
                                          ),
                                        )
                                      ],
                                    ));
                          },
                        )),
                  ),
                ],
              ),
            ),
          );
        });
  }

  _getData() async {
    list2 = await listP();
  }

  FutureOr onGoBack() {
    refreshData();
  }

  Future refreshData() async {
    List<Product> lista = await listP();
    //print(list.length);

    setState(() {
      list = lista;
      //list.shuffle();
      filteredProd = lista;
    });
  }


}


class _Head extends StatelessWidget {
  const _Head({Key? key}) : super(key: key);



  @override
  Widget build(BuildContext context) {
   // print('pinta la cabecera');

    Size size = MediaQuery.of(context).size;

    return Container(
      padding: EdgeInsets.only(
          left: kDefaultPadding,
          right: kDefaultPadding,
          bottom: 36 + kDefaultPadding),
      height: size.height * 0.2 - 10,
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
              'Productos',
              style: TextStyle(
                  fontSize: 30,
                  color: Colors.white,
                  fontFamily: 'UbuntuRegular'),
            ),
          ),
          //Image.network('assets/img/pro.png'),
          Icon(
            Icons.view_list,
            size: 40,
            color: kSecondaryColor,
          ),
        ],
      ),
    );
  }
}
