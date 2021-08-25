import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mandaos/models/product.dart';
import 'package:mandaos/services/product_provider.dart';
import 'package:mandaos/utils/constants.dart';
import 'package:provider/provider.dart';

class CardProductBuyHome extends StatelessWidget {
  const CardProductBuyHome({Key? key, required this.product, required this.cantPeople}) : super(key: key);

  final Product product;
  final int cantPeople;

  @override
  Widget build(BuildContext context) {
    final _prodProvider = Provider.of<ProductProvider>(context, listen: false);


    double t = product.price * product.cuota * cantPeople;
    String total = "\$ " + t.toStringAsFixed(2) + " cup";
    double c =  product.cuota * cantPeople;

    return Container(
      decoration: BoxDecoration(


      ),

     // padding: EdgeInsets.all(10),
      child: ListTile(
          title: Text(
            product.title,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
                fontSize: 14,
              fontFamily: 'UbuntuRegular',
                fontWeight: FontWeight.bold,

                color: kPrimaryColor,
                ),
          ),
          subtitle: Text(
            total + "    " + c.toString() + " " + product.um,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(fontSize: 14,fontFamily: 'UbuntuRegular' ,color: kPrimaryColor.withOpacity(.7)),
          ),
         leading:
         CircleAvatar(
           maxRadius: 26,
           backgroundImage: AssetImage(product.img),
         ),



        /* Container(
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

            ),),*/

        trailing: Icon(CupertinoIcons.hand_draw, color: Colors.redAccent,),
          /*trailing: IconButton(
            icon: Icon(Icons.delete, color: Colors.red,),
            onPressed: () {
              _prodProvider.removeFromCatalog(product);
              Navigator.of(context).pop();

            },
          )*/

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
    );
  }
}
