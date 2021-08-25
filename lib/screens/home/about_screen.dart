import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mandaos/generated/assets.dart';
import 'package:mandaos/utils/constants.dart';
import 'package:url_launcher/url_launcher.dart';

class AboutScreen extends StatelessWidget {
  //const ConfigScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    Size size = MediaQuery.of(context).size;
    const _url = 'https://t.me/mandaos_cuba';
    const _mail = 'mailto:andova86@gmail.com?subject=Recomendaciones de Usuario';
    const _phone = 'tel:+5353302763';

    void _launchURL() async =>
        await canLaunch(_url) ? await launch(_url) : throw 'No se puede acceder a $_url';

    void _launchEmail() async =>
        await canLaunch(_mail) ? await launch(_mail) : throw 'Error al enviar correo $_url';

    void _launchPhone() async =>
        await canLaunch(_phone) ? await launch(_phone) : throw 'Error al llamar $_url';

    return Scaffold(
      backgroundColor: Colors.white,
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        //title: Text('Productos de la Bodega'),
        backgroundColor: kPrimaryColor,
        elevation: 0,
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


        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                padding: EdgeInsets.only(
                    left: kDefaultPadding,
                    right: kDefaultPadding,
                    bottom: 10),
                height: size.height * 0.10,
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
                      padding: const EdgeInsets.only(right: 8.0),
                      child: Text(
                        'Acerca de...',
                        style: TextStyle(
                            fontFamily: 'UbuntuRegular',
                          fontSize: 30,
                          color: Colors.white,


                        ),
                      ),
                    ),
                    //Image.network('assets/img/pro.png'),
                    Icon(
                      Icons.account_box_outlined,
                      size: 35,
                      color: kSecondaryColor,
                    ),
                  ],
                ),
              ),

              SizedBox(height: 20,),
              //Text('En proceso !!')

              Container(
                margin: EdgeInsets.all(10),
                width: double.infinity,
                padding: EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                          color: kPrimaryColor, blurRadius: 5,spreadRadius: 0.5, offset: Offset(0, 1))
                    ],   borderRadius: BorderRadius.circular(20)
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Datos del Desarrollador', style: TextStyle(color: kPrimaryColor,fontWeight: FontWeight.bold, fontSize: 20, fontFamily: 'UbuntuRegular'),),

                    Divider(color: kPrimaryColor,),
                    ListTile(
                      onTap: (){
                        _launchEmail();
                      },
                       title: Text('Andy Luis Pons', style: TextStyle(fontFamily: 'UbuntuRegular')),
                      subtitle: Text('andova86@gmail.com', style: TextStyle(fontFamily: 'UbuntuRegular')),
                      leading: Icon(Icons.email, color: kSecondaryColor,),
                    ),

                    ListTile(
                      onTap: (){
                        _launchPhone();
                      },
                      title: Text('+53 (5330-2763)' ,style: TextStyle(fontFamily: 'UbuntuRegular')),
                      //subtitle: Text('andova86@gmail.com'),
                      leading: Icon(Icons.phone, color: kSecondaryColor,),
                    ),

                  ],
                ),
              ),


              Container(
                margin: EdgeInsets.all(10),
                width: double.infinity,
                padding: EdgeInsets.all(20),
                decoration: BoxDecoration(
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                          color: kPrimaryColor, blurRadius: 5,spreadRadius: 0.5, offset: Offset(0, 1))
                    ],  borderRadius: BorderRadius.circular(20)
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Síguenos en nuestro grupo de Telegram', style: TextStyle(color: kPrimaryColor,fontWeight: FontWeight.bold, fontSize: 20, fontFamily: 'UbuntuRegular'),),

                    Divider(color: kPrimaryColor,),
                    InkWell(onTap: (){
                      _launchURL();
                    },
                    child: Center(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Image.asset(Assets.imgTele, width: 100, ),
                      ),
                    ),
                    ),

                  ],
                ),
              ),


            ],
          ),
        ),


      ),
    );
  }

}
