import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:mandaos/modules/cart/screen/buy_product_screen.dart';
import 'package:mandaos/modules/products/provider/product_provider.dart';
import 'package:provider/provider.dart';

class BadgeUI extends StatelessWidget {
  const BadgeUI({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return   Consumer<ProductProvider>(
      builder: (context, cart, child) {
        return
          Container(

            margin: EdgeInsets.only(right: 15, top: 15),
            child: GestureDetector(
              child: Badge(
                badgeContent: Text("${cart.products.length}", style: TextStyle(color: Colors.white, fontSize: 10),),
                child: Icon(Icons.shopping_cart),
               // padding: EdgeInsets.all(4),
                showBadge: true,
                alignment: Alignment.center,

              ),
              onTap: (){
                Navigator.pushNamed(
                  context,
                  'buy',
                );
              },
            ),
          );


      },
    );
  }
}
