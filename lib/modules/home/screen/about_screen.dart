import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mandaos/generated/assets.dart';
import 'package:mandaos/modules/home/data/changes.dart';
import 'package:mandaos/utils/constants.dart';
import 'package:mandaos/utils/headers.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:url_launcher/url_launcher.dart';

class AboutScreen extends StatefulWidget {
  //const ConfigScreen({Key? key}) : super(key: key);

  @override
  _AboutScreenState createState() => _AboutScreenState();
}

class _AboutScreenState extends State<AboutScreen> {
  String version = '';

  @override
  Widget build(BuildContext context) {
    const _url = 'https://t.me/joinchat/607H7d7UwLZkZDdh';
    const _mail =
        'mailto:andova86@gmail.com?subject=Recomendaciones de Usuario';
    const _phone = 'tel:+5353302763';

    void _launchURL() async => await canLaunch(_url)
        ? await launch(_url)
        : throw 'No se puede acceder a $_url';



   /* void _launchEmail() async => await canLaunch(_mail)
        ? await launch(_mail)
        : throw 'Error al enviar correo $_url';

    void _launchPhone() async => await canLaunch(_phone)
        ? await launch(_phone)
        : throw 'Error al llamar $_url';*/

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
        child: Column(
          children: [
            const HeaderM(
                title: 'Acerca de...', ico: Icons.account_box_outlined),
            Expanded(
                child: SingleChildScrollView(
              physics: BouncingScrollPhysics(),
              child: Column(
                children: [
                  /* Container(
                    margin: EdgeInsets.all(10),
                    width: double.infinity,
                    padding: EdgeInsets.all(20),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                              color: kPrimaryColor,
                              blurRadius: 5,
                              spreadRadius: 0.5,
                              offset: Offset(0, 1))
                        ],
                        borderRadius: BorderRadius.circular(20)),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Datos del Desarrollador',
                          style: TextStyle(
                              color: kPrimaryColor,
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                              fontFamily: 'UbuntuRegular'),
                        ),
                        Divider(
                          color: kPrimaryColor,
                        ),
                        ListTile(
                          onTap: () {
                            _launchEmail();
                          },
                          title: Text('Andy Luis Pons',
                              style: TextStyle(fontFamily: 'UbuntuRegular')),
                          subtitle: Text('andova86@gmail.com',
                              style: TextStyle(fontFamily: 'UbuntuRegular')),
                          leading: Icon(
                            Icons.email,
                            color: kSecondaryColor,
                          ),
                        ),
                        ListTile(
                          onTap: () {
                            _launchPhone();
                          },
                          title: Text('+53 (5330-2763)',
                              style: TextStyle(fontFamily: 'UbuntuRegular')),
                          //subtitle: Text('andova86@gmail.com'),
                          leading: Icon(
                            Icons.phone,
                            color: kSecondaryColor,
                          ),
                        ),
                      ],
                    ),
                  ),*/
                  Container(
                    margin: EdgeInsets.all(10),
                    width: double.infinity,
                    padding: EdgeInsets.all(20),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                              color: kPrimaryColor,
                              blurRadius: 5,
                              spreadRadius: 0.5,
                              offset: Offset(0, 1))
                        ],
                        borderRadius: BorderRadius.circular(20)),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Síguenos en nuestro grupo de Telegram',
                          style: TextStyle(
                              color: kPrimaryColor,
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                              fontFamily: 'UbuntuRegular'),
                        ),
                        Divider(
                          color: kPrimaryColor,
                        ),
                        InkWell(
                          onTap: () {
                            _launchURL();
                          },
                          child: Center(
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Image.asset(
                                Assets.imgTele,
                                width: 80,
                              ),
                            ),
                          ),
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
                              color: kPrimaryColor,
                              blurRadius: 5,
                              spreadRadius: 0.5,
                              offset: Offset(0, 1))
                        ],
                        borderRadius: BorderRadius.circular(20)),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Center(
                          child: Text(
                            'Versión ' + "($version) " + " Lista de cambios",
                            style: TextStyle(
                                color: kPrimaryColor,
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                                fontFamily: 'UbuntuRegular'),
                          ),
                        ),
                        Divider(
                          color: kPrimaryColor,
                        ),
                        Center(
                          child: ElevatedButton(
                            onPressed: () {
                              _showD();
                              // print("*********************");
                              // print(DateFormat('dd/MM/yyyy').format(date));
                            },
                            style: ButtonStyle(
                                backgroundColor:
                                MaterialStateProperty.all(kSecondaryColor),
                                shape: MaterialStateProperty.all<
                                    RoundedRectangleBorder>(
                                    RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(40),
                                    ))),
                            child: Text(
                              'Ver ',
                              style: TextStyle(
                                  color: kPrimaryColor,
                                  fontSize: 14,
                                  fontFamily: 'UbuntuRegular',
                                  fontWeight: FontWeight.w900),
                            ),
                          ),
                        ),

                        /*  _changesList(),*/
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
                              color: kPrimaryColor,
                              blurRadius: 5,
                              spreadRadius: 0.5,
                              offset: Offset(0, 1))
                        ],
                        borderRadius: BorderRadius.circular(20)),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Center(
                          child: Text(
                            'Aplicaciones del Desarrollador',
                            style: TextStyle(
                                color: kPrimaryColor,
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                                fontFamily: 'UbuntuRegular'),
                          ),
                        ),
                        Divider(
                          color: kPrimaryColor,
                        ),
                        Stack(
                          children: [
                            GestureDetector(
                              onTap: (){
                                const _url = 'https://www.apklis.cu/application/com.andovadev.comparte';
                                _launchURLNew(_url);
                              },
                              child: Column(
                                children: [
                                  CircleAvatar(
                                    backgroundImage: AssetImage(Assets.imgComp),
                                    maxRadius: 30,
                                    backgroundColor: Colors.transparent,

                                  ),
                                  SizedBox(height: 10,),
                                  Text('Comparte \n\Comparte', style: TextStyle(color: Colors.grey, fontSize: 10),)
                                ],
                              ),
                            ),

                          ],
                        ),


                        /*  _changesList(),*/
                      ],
                    ),
                  ),
                ],
              ),
            ))
          ],
        ),
      ),
    );
  }

  void _launchURLNew(String url) async => await canLaunch(url)
      ? await launch(url)
      : throw 'No se puede acceder a $url';

  _showD() {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return Dialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.0)),
            //this right here
            child: Container(
              height: MediaQuery.of(context).size.height * 0.5,
              padding: EdgeInsets.all(20),
              child: _changesList(),
            ),
          );
        });
  }

  @override
  void initState() {
    PackageInfo.fromPlatform().then((PackageInfo packageInfo) {
      //version = packageInfo.version;

      setState(() {
        version = packageInfo.version;
        print(version);
      });
    });

    super.initState();

    //dbHelper.listConfig();
  }

  @override
  void dispose() {
    super.dispose();
  }
}

class _changesList extends StatelessWidget {
  const _changesList({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: listChanges140.length,
      itemBuilder: (context, pos) {
        return ListTile(
          minLeadingWidth: 10,
          contentPadding: EdgeInsets.all(0),
          title: Text(
            listChanges140[pos].description,
            style: TextStyle(
                fontSize: 14,
                fontFamily: 'UbuntuRegular',
                color: kPrimaryColor.withOpacity(.6)),
          ),
          leading: Text(listChanges140[pos].number.toString() + " - ",
              style: TextStyle(
                  fontFamily: 'UbuntuRegular',
                  color: kPrimaryColor,
                  fontWeight: FontWeight.bold)),
        );
      },
    );
  }
}
