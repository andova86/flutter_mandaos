import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mandaos/modules/products/models/product.dart';
import 'package:mandaos/modules/products/provider/product_provider.dart';
import 'package:mandaos/utils/constants.dart';
import 'package:provider/provider.dart';

class CardProductHome extends StatelessWidget {
  const CardProductHome({Key? key, required this.product, required this.cantPeople}) : super(key: key);

  final Product product;
  final int cantPeople;

  @override
  Widget build(BuildContext context) {
    final _prodProvider = Provider.of<ProductProvider>(context, listen: false);

    String sub = product.cuota.toString() +
        " " +
        product.um +
        " por persona a " +
        product.price.toStringAsFixed(2).replaceAll(RegExp(r"([.]*0+)(?!.*\d)"), "").replaceAll(RegExp(r"([.]*0+)(?!.*\d)"), "") +
        " CUP";
    double t = product.price * product.cuota * cantPeople;
    String total = "\$ " + t.toStringAsFixed(2) + " cup";

    return Container(
      color: Colors.white,

      padding: EdgeInsets.all(10),
      child: Card(
        color: Colors.white,
        shadowColor: Colors.greenAccent[500],
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        elevation: 16,
        child: ListTile(
            title: Text(
              product.title,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: kPrimaryColor,
                  fontFamily: 'RalewayRegular'),
            ),
            subtitle: Text(
              sub,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(fontSize: 12, fontFamily: 'RalewayRegular'),
            ),
            trailing: Container(
                padding: EdgeInsets.all(5),
                decoration: BoxDecoration(boxShadow: [
                  BoxShadow(
                      color: kSecondaryColor, spreadRadius: 1, blurRadius: 2)
                ]),
                child: Text(total,
                  style:  TextStyle(
                      fontSize: 14,
                      color: kPrimaryColor,
                      fontWeight: FontWeight.bold,
                    fontFamily: 'ComingSoon'


                  ),

                ),),
            leading: IconButton(
              icon: Icon(Icons.add_shopping_cart_rounded, color: Colors.deepOrangeAccent,),
              onPressed: () {
                _prodProvider.addToCatalog(product);
                final snackBar = SnackBar(
                  duration: Duration(seconds: 1),
                  behavior: SnackBarBehavior.floating,
                  content: Text('Se añadió ' + product.title + " al carrito de compras."),
                  action: SnackBarAction(
                    label: 'Aceptar',
                    onPressed: () {},
                  ),
                );

                // Find the Scaffold in the widget tree and use
                // it to show a SnackBar.
                ScaffoldMessenger.of(context).showSnackBar(snackBar);
              },
            )

            /*Container(
            padding: EdgeInsets.all(5),
            decoration: BoxDecoration(boxShadow: [
              BoxShadow(
                  color: Colors.deepPurple.shade400, spreadRadius: 1, blurRadius: 2)
            ]),
            child: Text(total,
                style:  TextStyle(
                    fontSize: 12,
                  color: Colors.white,
                  fontWeight: FontWeight.w600


                ),

            ),
          ),*/
            /* leading: Image.asset(
            'assets/icons/time.png',
            width: 60,
            height: 60,
          ),*/
            //onTap: () {},
            ),
      ),
    );
  }
}
