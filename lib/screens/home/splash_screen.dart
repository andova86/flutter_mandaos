import 'package:flutter/material.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:mandaos/generated/assets.dart';
import 'package:mandaos/screens/home/home_screen.dart';
import 'package:mandaos/utils/constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatelessWidget {
  //const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return SafeArea(
      child: IntroductionScreen(
        showNextButton: true,
        showSkipButton: true,
        color: kPrimaryColor,
        nextColor: kPrimaryColor,

        controlsPadding: EdgeInsets.only(left: 0, right: 0),
        skip: const Text(
          'Saltar',
          style: TextStyle(
              fontWeight: FontWeight.bold,

              fontFamily: 'UbuntuRegular',
              fontSize: 20),
        ),
        next: Icon(
          Icons.arrow_forward_outlined,
          color: kPrimaryColor,
        ),
        dotsDecorator: DotsDecorator(
            size: Size(6, 6),
            color: kSecondaryColor,
            activeShape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
            activeSize: Size(18, 8),
        activeColor: kPrimaryColor,
          spacing: EdgeInsets.all(4)
        ),

        pages: [
          PageViewModel(
            title: 'Mandaos',
            body:
                'La aplicación de Mandaos es una herramienta para ayudar a las personas de una manera fácil '
                    'gestionar los productos que van a comprar en el Mercado.',
            image: Image.asset(Assets.imgHome),
            decoration: PageDecoration(

              imagePadding: EdgeInsets.only(top: 15),
              titleTextStyle: TextStyle(fontFamily: 'UbuntuRegular', color: kPrimaryColor,fontSize: 26, fontWeight: FontWeight.bold),
              bodyTextStyle: TextStyle(
                fontFamily: 'UbuntuRegular', color: kPrimaryColor, fontSize: 18, )

            )
          ),

          PageViewModel(
              title: 'Menu de la aplicación',
              body: 'A continuación un listado de opciones del menu y su descripción.',
              image: Image.asset(Assets.imgMenu2),
              footer: Column(children: [
                Container(
                  padding: EdgeInsets.only(right: 20, left: 20, top: 10, bottom: 5),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('1- ', style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold,fontFamily: 'UbuntuRegular'),),
                      Expanded(
                        child: Text('Página de inicio de la aplicación donde se muestra los productos mas comprados.',
                          style: TextStyle(color: kPrimaryColor,fontFamily: 'UbuntuRegular'),

                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: EdgeInsets.only(right: 20, left: 20, top: 10, bottom: 5),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('2- ', style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold),),
                      Expanded(
                        child: Text('Página que te muestra un listado de los productos del mercado y sus detalles.',
                          style: TextStyle(color: kPrimaryColor,fontFamily: 'UbuntuRegular'),

                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: EdgeInsets.only(right: 20, left: 20, top: 10, bottom: 5),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('3- ', style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold),),
                      Expanded(
                        child: Text('Página que te muestra según  los productos seleccionados por usted, el precio de cada uno y el precio total de la compra en el mercado.',
                          style: TextStyle(color: kPrimaryColor,fontFamily: 'UbuntuRegular'),

                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: EdgeInsets.only(right: 20, left: 20, top: 10, bottom: 5),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('4- ', style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold,fontFamily: 'UbuntuRegular'),),
                      Expanded(
                        child: Text('Página para visualizar todas las compras guardadas en la aplicación.',
                          style: TextStyle(color: kPrimaryColor,fontFamily: 'UbuntuRegular'),

                        ),
                      ),
                    ],
                  ),
                ),

                Container(
                  padding: EdgeInsets.only(right: 20, left: 20, top: 10, bottom: 5),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('5- ', style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold,fontFamily: 'UbuntuRegular'),),
                      Expanded(
                        child: Text('Página para configurar los consumidores de la libreta de abastecimiento.',
                          style: TextStyle(color: kPrimaryColor,fontFamily: 'UbuntuRegular'),

                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: EdgeInsets.only(right: 20, left: 20, top: 10, bottom: 5),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('6- ', style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold),),
                      Expanded(
                        child: Text('Página de preguntas frecuentes de los usuarios y sus respuestas.',
                          style: TextStyle(color: kPrimaryColor,fontFamily: 'UbuntuRegular'),

                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: EdgeInsets.only(right: 20, left: 20, top: 10, bottom: 5),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('7- ', style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold),),
                      Expanded(
                        child: Text('Página de ayuda al usuario final.',
                          style: TextStyle(color: kPrimaryColor,fontFamily: 'UbuntuRegular'),

                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: EdgeInsets.only(right: 20, left: 20, top: 10, bottom: 5),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('8- ', style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold),),
                      Expanded(
                        child: Text('Página de información del Desarrollador y como contactarlo.',
                          style: TextStyle(color: kPrimaryColor,fontFamily: 'UbuntuRegular'),

                        ),
                      ),
                    ],
                  ),
                ),
              ],),
              decoration: PageDecoration(

          imagePadding: EdgeInsets.only(top: 15),
        titleTextStyle: TextStyle(fontFamily: 'UbuntuRegular', color: kPrimaryColor,fontSize: 26, fontWeight: FontWeight.bold),
        bodyTextStyle: TextStyle(
          fontFamily: 'UbuntuRegular', color: kPrimaryColor, fontSize: 18, )

    )
          ),

          PageViewModel(

            title: 'Como se realiza una compra virtual ?',
            body: 'Usted puede seleccionar los productos que va a comprar en el mercado y los añade al carrito para comprobar el precio total.',
            image: Image.asset(Assets.imgProductoss),
              decoration: PageDecoration(

                  imagePadding: EdgeInsets.only(top: 15),
                  titleTextStyle: TextStyle(fontFamily: 'UbuntuRegular', color: kPrimaryColor,fontSize: 26, fontWeight: FontWeight.bold),
                  bodyTextStyle: TextStyle(
                    fontFamily: 'UbuntuRegular', color: kPrimaryColor, fontSize: 18, )

              )
          ),

          PageViewModel(
            title: 'Comprobar el precio total.',
            body: 'Según los productos seleccionados puede comprobar el precio total así como el precio de cada producto y sus cantidades.',
            image: Image.asset(Assets.imgCompra),
              decoration: PageDecoration(

                  imagePadding: EdgeInsets.only(top: 15),
                  titleTextStyle: TextStyle(fontFamily: 'UbuntuRegular', color: kPrimaryColor,fontSize: 26, fontWeight: FontWeight.bold),
                  bodyTextStyle: TextStyle(
                    fontFamily: 'UbuntuRegular', color: kPrimaryColor, fontSize: 18, )

              )
          ),


          PageViewModel(
              title: 'Historial de Compras.',
              body: 'Usted puede elegir una fecha para visualizar los datos de una compra realizada.',
              image: Image.asset(Assets.imgHistorial),
              decoration: PageDecoration(

                  imagePadding: EdgeInsets.only(top: 15),
                  titleTextStyle: TextStyle(fontFamily: 'UbuntuRegular', color: kPrimaryColor,fontSize: 26, fontWeight: FontWeight.bold),
                  bodyTextStyle: TextStyle(
                    fontFamily: 'UbuntuRegular', color: kPrimaryColor, fontSize: 18, )

              )
          ),

          PageViewModel(
            title: 'Ver detalles de cada Producto',
            body: 'Usted puede ver los datos de la cuota , precio y un ejemplo del precio por persona (generado hasta 6 personas)',
            image: Image.asset(Assets.imgDetalle),
              decoration: PageDecoration(

                  imagePadding: EdgeInsets.only(top: 15),
                  titleTextStyle: TextStyle(fontFamily: 'UbuntuRegular', color: kPrimaryColor,fontSize: 26, fontWeight: FontWeight.bold),
                  bodyTextStyle: TextStyle(
                    fontFamily: 'UbuntuRegular', color: kPrimaryColor, fontSize: 18, )

              )
          ),

          PageViewModel(
            title: 'Modificar los datos de cada producto',
            body: 'Para facilitar al usuario se incorpora una opción útil para modificar los datos datos de un producto.',
            image: Image.asset(Assets.imgModificar),
              decoration: PageDecoration(

                  imagePadding: EdgeInsets.only(top: 15),
                  titleTextStyle: TextStyle(fontFamily: 'UbuntuRegular', color: kPrimaryColor,fontSize: 26, fontWeight: FontWeight.bold),
                  bodyTextStyle: TextStyle(
                    fontFamily: 'UbuntuRegular', color: kPrimaryColor, fontSize: 18, )

              )
          ),



        ],
        done: Text(
          'Hecho',
          style: TextStyle(
              fontWeight: FontWeight.bold,
              color: kPrimaryColor,
              fontFamily: 'UbuntuRegular',
              //fontFamily: 'DancingScriptRegular',
              fontSize: 20),
        ),
        onDone: () {
          setSeen();

          Navigator.of(context)
              .pushReplacement(MaterialPageRoute(builder: (_) => HomeScreen()));
        },
      ),
    );

  }

  Future setSeen() async {


    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool('seen', true);

  }
}
