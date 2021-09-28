import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:mandaos/utils/constants.dart';
import 'package:mandaos/utils/funtions.dart';
import 'package:mandaos/utils/headers.dart';
import 'package:mandaos/widgets/ui/message_ui.dart';

class ConvertionScreen extends StatefulWidget {
 // const ConvertionScreen({Key? key}) : super(key: key);

  @override
  _ConvertionScreenState createState() => _ConvertionScreenState();
}

class _ConvertionScreenState extends State<ConvertionScreen> {
  final _formKey = GlobalKey<FormState>();

  final convController = TextEditingController();
  final resController = TextEditingController();

  final convController1 = TextEditingController();
  final resController1 = TextEditingController();

  final convController2 = TextEditingController();
  final resController2 = TextEditingController();

  final convController3 = TextEditingController();
  final resController3 = TextEditingController();


  String resultConv1 = '';


  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    Widget libraOnza(){

      return Column(children: [
        ClipRRect(

          child:

          Container(
            //decoration: ,
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              width: double.infinity,
              color: kSecondaryColor,
              child: Center(child: Text('de libras a Onzas', style: TextStyle(color: kPrimaryColor,fontSize: 18 ,fontFamily: 'UbuntuRegular', fontWeight: FontWeight.bold)))),
          borderRadius: BorderRadius.only(topLeft: Radius.circular(10), topRight: Radius.circular(10)),
        ),

        Padding(
          padding: const EdgeInsets.all(10.0),
          child: Row(


            children: [
              Container(

                child: TextFormField(
                  style: TextStyle(fontSize: 16, fontFamily: 'UbuntuRegular'),
                  controller: convController,
                  decoration:const  InputDecoration(
                    //icon: Icon(Icons.keyboard,color: Colors.blueGrey,),

                      alignLabelWithHint: true,
                      // hintText: 'ej: 10',
                      labelText: 'Libras',
                      labelStyle: TextStyle(fontSize: 18, fontFamily: 'UbuntuRegular')

                  ),
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if(value!.isEmpty){
                      return 'Ingrese la cantidad';
                    }
                  },
                  onChanged: (text){
                    int value = int.parse(text) * 16;
                    resController.text = value.toString();
                  },

                ),
                width: size.width * 0.4,
              ),
              Container(

                child: TextFormField(
                  style: TextStyle(fontSize: 16, fontFamily: 'UbuntuRegular'),
                  decoration:const  InputDecoration(

                      alignLabelWithHint: true,
                      //hintText: 'ej: 10',
                      labelText: 'Onzas',

                      labelStyle: TextStyle(fontSize: 18, fontFamily: 'UbuntuRegular')

                  ),
                  controller: resController,
                  enabled: false,
                ),
                width: size.width * 0.4,
              ),


            ],
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
          ),
        ),
        SizedBox(height: 10,),
      ],);
    }



    return Scaffold(
      appBar: AppBar(elevation: 0,backgroundColor: kPrimaryColor,),
      body: Column(
        children: [
          const HeaderM(title: 'Convertir unidades', ico: Icons.all_inclusive_outlined),
          Expanded(child: SingleChildScrollView(
            child: Column(
              children: [
                Form(
                  key: _formKey,
                  child:

                  Column(
                    children: [

                     Container(
                         margin: EdgeInsets.all(15),
                         decoration: BoxDecoration(
                             color: Colors.white,

                             borderRadius: BorderRadius.all(Radius.circular(20)),
                             boxShadow: [
                               BoxShadow(
                                   color: Colors.black26,
                                   blurRadius: 6,
                                   offset: Offset(0, 5))
                             ]

                         ),
                         child: libraOnza()),

                      Container(
                          margin: EdgeInsets.all(15),
                          decoration: BoxDecoration(
                              color: Colors.white,

                              borderRadius: BorderRadius.all(Radius.circular(20)),
                              boxShadow: [
                                BoxShadow(
                                    color: Colors.black26,
                                    blurRadius: 6,
                                    offset: Offset(0, 5))
                              ]

                          ),
                          child:  _librasToOnza(convController1: convController1, resController1: resController1, size: size)

                      ),

                      Container(
                          margin: EdgeInsets.all(15),
                          decoration: BoxDecoration(
                              color: Colors.white,

                              borderRadius: BorderRadius.all(Radius.circular(20)),
                              boxShadow: [
                                BoxShadow(
                                    color: Colors.black26,
                                    blurRadius: 6,
                                    offset: Offset(0, 5))
                              ]

                          ),
                          child:  _librasToKG(convController1: convController2, resController1: resController2, size: size)

                      ),

                      Container(
                          margin: EdgeInsets.all(15),
                          decoration: BoxDecoration(
                              color: Colors.white,

                              borderRadius: BorderRadius.all(Radius.circular(20)),
                              boxShadow: [
                                BoxShadow(
                                    color: Colors.black26,
                                    blurRadius: 6,
                                    offset: Offset(0, 5))
                              ]

                          ),
                          child:  _KGTolibras(convController1: convController3, resController1: resController3, size: size)

                      ),





                    ],
                  )

                ),

              ],
            ),
          ))
        ],
      ),
    );


  }

  @override
  void initState() {
    super.initState();
    //convController.addListener(() { print(convController.text);});
  }

  @override
  void dispose() {
    convController.dispose();
    convController1.dispose();
    super.dispose();
  }


}

class _librasToOnza extends StatelessWidget {
  const _librasToOnza({
    Key? key,
    required this.convController1,
    required this.resController1,
    required this.size,
  }) : super(key: key);

  final TextEditingController convController1;
  final TextEditingController resController1;
  final Size size;

  @override
  Widget build(BuildContext context) {
    return Column(children: [
    Container(
      //decoration: ,
        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        width: double.infinity,
        color: kSecondaryColor,
        child: Center(child: Text('de Onzas a libras', style: TextStyle(color: kPrimaryColor,fontSize: 18 ,fontFamily: 'UbuntuRegular', fontWeight: FontWeight.bold)))),

    Padding(
      padding: const EdgeInsets.all(10.0),
      child: Row(


        children: [
          Container(

            child: TextFormField(
              style: TextStyle(fontSize: 16, fontFamily: 'UbuntuRegular'),
              controller: convController1,
              decoration:const  InputDecoration(
                //icon: Icon(Icons.keyboard,color: Colors.blueGrey,),

                  alignLabelWithHint: true,
                  // hintText: 'ej: 10',
                  labelText: 'Onzas',
                  labelStyle: TextStyle(fontSize: 18, fontFamily: 'UbuntuRegular')

              ),
              keyboardType: TextInputType.number,
              validator: (value) {
                if(value!.isEmpty){
                  return 'Ingrese la cantidad';
                }
              },
              onChanged: (text){
                double value = int.parse(text) / 16;
                resController1.text = value.toStringAsFixed(2).replaceAll(RegExp(r"([.]*0+)(?!.*\d)"), "");
              },

            ),
            width: size.width * 0.4,
          ),
          Container(

            child: TextFormField(
              style: TextStyle(fontSize: 16, fontFamily: 'UbuntuRegular'),
              decoration:const  InputDecoration(

                  alignLabelWithHint: true,
                  //hintText: 'ej: 10',
                  labelText: 'Libras',

                  labelStyle: TextStyle(fontSize: 18, fontFamily: 'UbuntuRegular')

              ),
              controller: resController1,
              enabled: false,
            ),
            width: size.width * 0.4,
          ),
        ],
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
      ),
    ),
      SizedBox(height: 10,),
      ],);
  }
}


class _librasToKG extends StatelessWidget {
  const _librasToKG({
    Key? key,
    required this.convController1,
    required this.resController1,
    required this.size,
  }) : super(key: key);

  final TextEditingController convController1;
  final TextEditingController resController1;
  final Size size;

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Container(
        //decoration: ,
          padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
          width: double.infinity,
          color: kSecondaryColor,
          child: Center(child: Text('de libras a kg', style: TextStyle(color: kPrimaryColor,fontSize: 18 ,fontFamily: 'UbuntuRegular', fontWeight: FontWeight.bold)))),

      Padding(
        padding: const EdgeInsets.all(10.0),
        child: Row(


          children: [
            Container(

              child: TextFormField(
                style: TextStyle(fontSize: 16, fontFamily: 'UbuntuRegular'),
                controller: convController1,
                decoration:const  InputDecoration(
                  //icon: Icon(Icons.keyboard,color: Colors.blueGrey,),

                    alignLabelWithHint: true,
                    // hintText: 'ej: 10',
                    labelText: 'Libras',
                    labelStyle: TextStyle(fontSize: 18, fontFamily: 'UbuntuRegular')

                ),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if(value!.isEmpty){
                    return 'Ingrese la cantidad';
                  }
                },
                onChanged: (text){
                  if(text.isNotEmpty)
                    {
                      double value = int.parse(text) * 0.4535;
                      resController1.text = value.toStringAsFixed(2);
                    }
                  else
                    resController1.text = '';

                },

              ),
              width: size.width * 0.4,
            ),
            Container(

              child: TextFormField(
                style: TextStyle(fontSize: 16, fontFamily: 'UbuntuRegular'),
                decoration:const  InputDecoration(

                    alignLabelWithHint: true,
                    //hintText: 'ej: 10',
                    labelText: 'Kilogramos',

                    labelStyle: TextStyle(fontSize: 18, fontFamily: 'UbuntuRegular')

                ),
                controller: resController1,
                enabled: false,
              ),
              width: size.width * 0.4,
            ),
          ],
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
        ),
      ),
      SizedBox(height: 10,),
    ],);
  }
}

class _KGTolibras extends StatelessWidget {
  const _KGTolibras({
    Key? key,
    required this.convController1,
    required this.resController1,
    required this.size,
  }) : super(key: key);

  final TextEditingController convController1;
  final TextEditingController resController1;
  final Size size;

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Container(
        //decoration: ,
          padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
          width: double.infinity,
          color: kSecondaryColor,
          child: Center(child: Text('de kg a Libras', style: TextStyle(color: kPrimaryColor,fontSize: 18 ,fontFamily: 'UbuntuRegular', fontWeight: FontWeight.bold)))),

      Padding(
        padding: const EdgeInsets.all(10.0),
        child: Row(


          children: [
            Container(

              child: TextFormField(
                style: TextStyle(fontSize: 16, fontFamily: 'UbuntuRegular'),
                controller: convController1,
                decoration:const  InputDecoration(
                  //icon: Icon(Icons.keyboard,color: Colors.blueGrey,),

                    alignLabelWithHint: true,
                    // hintText: 'ej: 10',
                    labelText: 'Kilogramos',
                    labelStyle: TextStyle(fontSize: 18, fontFamily: 'UbuntuRegular')

                ),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if(value!.isEmpty){
                    return 'Ingrese la cantidad';
                  }
                },
                onChanged: (text){
                  if(text.isNotEmpty)
                  {
                    double value = int.parse(text) * 2.2046;
                    resController1.text = value.toStringAsFixed(2);
                  }
                  else
                    resController1.text = '';

                },

              ),
              width: size.width * 0.4,
            ),
            Container(

              child: TextFormField(
                style: TextStyle(fontSize: 16, fontFamily: 'UbuntuRegular'),
                decoration:const  InputDecoration(

                    alignLabelWithHint: true,
                    //hintText: 'ej: 10',
                    labelText: 'Libras',

                    labelStyle: TextStyle(fontSize: 18, fontFamily: 'UbuntuRegular')

                ),
                controller: resController1,
                enabled: false,
              ),
              width: size.width * 0.4,
            ),
          ],
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
        ),
      ),
      SizedBox(height: 10,),
    ],);
  }
}