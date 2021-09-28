import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mandaos/generated/assets.dart';
import 'package:mandaos/modules/home/models/config.dart';
import 'package:mandaos/services/database_helper.dart';
import 'package:mandaos/services/db_helper.dart';
import 'package:mandaos/utils/constants.dart';
import 'package:mandaos/utils/headers.dart';
import 'package:provider/provider.dart';




class ConfigScreen extends StatefulWidget {
  const ConfigScreen({Key? key}) : super(key: key);

  @override
  _ConfigScreenState createState() => _ConfigScreenState();
}
enum Colores { verde, azul, violeta }


class _ConfigScreenState extends State<ConfigScreen> {
  //TextEditingController _filter = new TextEditingController();

  Colores? _color = Colores.azul;

  List<Config> list = [];
  double value = 0;
  double value37 = 0;
  double value2 = 0;

  double total = 0;

  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {


    return Scaffold(
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
             const HeaderM(title: 'Configuración', ico: Icons.settings),
              Expanded(child: SingleChildScrollView(
                child: Column(
                  children: [
                    Container(
                      margin: EdgeInsets.symmetric(horizontal: 15),
                      padding: EdgeInsets.only(bottom: 10),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(
                              bottomRight: Radius.circular(10),
                              bottomLeft: Radius.circular(10)),
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(
                                color: kPrimaryColor,
                                blurRadius: 10,
                                spreadRadius: 1,
                                offset: Offset(0, 3))
                          ]),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            //padding: EdgeInsets.all(10),

                              decoration: BoxDecoration(
                                //color: Color(0xFF23af7e),
                              ),
                              child:

                              Container(
                                padding: EdgeInsets.all(15),
                                color: kSecondaryColor,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Text(
                                      'Cantidad de consumidores',
                                      style: TextStyle(
                                          color: kPrimaryColor,
                                          fontFamily: 'UbuntuRegular',

                                          fontSize: 16,
                                          fontWeight: FontWeight.w900),
                                    ),
                                    Text(
                                      total.toInt().toString(),
                                      style: TextStyle(
                                          color: kPrimaryColor,

                                          fontSize: 16,
                                          fontWeight: FontWeight.w900),
                                    ),
                                  ],
                                ),
                              )),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Slider(
                                      value: value,
                                      min: 0,
                                      max: 10,
                                      divisions: 10,
                                      activeColor: kPrimaryColor,
                                      inactiveColor: Colors.blueGrey.shade400,
                                      label: value.round().toString(),
                                      onChanged: (value) =>
                                          setState((){

                                            this.value = value;
                                            this.total = value + value2 + value37;
                                          }),
                                    ),

                                    Padding(
                                      padding: const EdgeInsets.only(left: 20),
                                      child: Text(
                                        value.round().toString() +
                                            " mayores de 65 años",
                                        textAlign: TextAlign.start,
                                        style: TextStyle(
                                          fontFamily: 'UbuntuRegular',
                                          color: kPrimaryColor.withOpacity(.7),
                                          fontSize: 16,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Image.asset(
                                Assets.imgViejos,
                                width: 60,
                                height: 40,
                              )
                            ],
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Slider(
                                      value: value37,
                                      min: 0,
                                      max: 10,
                                      divisions: 10,
                                      activeColor: kPrimaryColor,
                                      inactiveColor: Colors.blueGrey.shade400,
                                      label: value37.round().toString(),
                                      onChanged: (value_obj) =>
                                          setState((){

                                            this.value37 = value_obj;
                                            this.total = value_obj + value2 + value;
                                          }),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(left: 20),
                                      child: Text(
                                        value37.round().toString() +
                                            " niños de 3 a 7 años.",
                                        textAlign: TextAlign.start,
                                        style: TextStyle(
                                          fontFamily: 'UbuntuRegular',
                                          color: kPrimaryColor.withOpacity(.7),
                                          fontSize: 16,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Image.asset(
                                'assets/img/ninos.png',
                                width: 60,
                                // color: Colors.black12,
                              )
                            ],
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Slider(
                                      value: value2,
                                      min: 0,
                                      max: 10,
                                      divisions: 10,
                                      activeColor: kPrimaryColor,
                                      inactiveColor: Colors.blueGrey.shade400,
                                      label: value2.round().toString(),
                                      onChanged: (valueObj) =>
                                          setState((){

                                            this.value2 = valueObj;
                                            this.total = valueObj + value37 + value;
                                          }),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(left: 20),
                                      child: Text(
                                        value2.round().toString() +
                                            " bebes menores de 2 años.",
                                        textAlign: TextAlign.start,
                                        style: TextStyle(
                                          fontFamily: 'UbuntuRegular',
                                          color: kPrimaryColor.withOpacity(.7),
                                          fontSize: 16,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Image.asset(
                                'assets/img/ninos2.jpg',
                                width: 60,
                              )
                            ],
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Divider(),
                          SizedBox(
                            height: 10,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              ElevatedButton(onPressed: () {
                                FocusScope.of(context).requestFocus(new FocusNode());
                                Config c = list[0];
                                c.adultos = value.toInt();
                                c.bebes = value2.toInt();
                                c.ninos37 = value37.toInt();
                                c.id = 1;
                                print('Id *-*-*-*-*-*-*');
                                print(list[0].id);
                                Future<int> id =  update(c.toJson(), table_config);

                                if (id.toString().length > 0) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                      duration: Duration(seconds: 1),
                                      content: Text(
                                          'Se modificaron los datos de la configuración correctamente.'),
                                    ),
                                  );
                                }
                              },
                                style: ButtonStyle(
                                  //  fixedSize:  MaterialStateProperty.all(100),

                                    backgroundColor:
                                    MaterialStateProperty.all(kotherColor),
                                    padding:
                                    MaterialStateProperty.all(EdgeInsets.all(15)),
                                    shadowColor: MaterialStateProperty.all(kPrimaryColor),
                                    elevation: MaterialStateProperty.all(3),
                                    shape:
                                    MaterialStateProperty.all<RoundedRectangleBorder>(
                                        RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(10),
                                        ))),


                                child: Text("Modificar datos",style: TextStyle(fontFamily: 'UbuntuRegular',fontWeight: FontWeight.bold, color: kPrimaryColor),),

                              ),
                            ],
                          ),
                          SizedBox(
                            height: 10,
                          ),

                          /* RadioListTile<Colores>(
                        title: const Text('Azul'),
                        value: Colores.azul,
                        groupValue: _color,
                        onChanged: (Colores? value) {
                          setState(() {
                            _color = value;
                           // DynamicTheme.of(context).setBrightness(Brightness.dark);
                          });
                        },
                      ),
                      RadioListTile<Colores>(
                        title: const Text('Verde'),
                        value: Colores.verde,
                        groupValue: _color,
                        onChanged: (Colores? value) {
                          setState(() {
                            _color = value;
                          });
                        },
                      ),*/

                          /* Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Slider(
                                  value: valueK,
                                  min: 0,
                                  max: 5,
                                  divisions: 5,
                                  activeColor: kPrimaryColor,
                                  inactiveColor: Colors.blueGrey.shade400,
                                  label: valueK.round().toString(),
                                  onChanged: (value) =>
                                      setState(() => this.valueK = value),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 20),
                                  child: Text(

                                        valueK.round().toString() + " niños menores de 7 años",
                                    textAlign: TextAlign.start,
                                    style: TextStyle(
                                      color: kPrimaryColor,
                                      fontSize: 16,
                                      fontFamily: 'ComingSoon'),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Image.asset(
                            'assets/img/ninos2.jpg',
                            width: 80,
                          )
                        ],
                      ),*/
                        ],
                      ),
                    ),
                  ],
                ),
              ))

            ],
          ),
        ));
  }

  @override
  void initState() {
    super.initState();
    refreshData();
  }

  @override
  void dispose() {
    super.dispose();
  }

  Future refreshData() async {
    List<Config> lista = await listConfig();
    print('*********** Listaaaaaaa');
    print(lista.length.toString()+ " elemento " + lista[0].adultos.toString() + " adultos " + lista[0].id.toString());
    //print(list.length);

    setState(() {
      list = lista;

      value = lista[0].adultos.toDouble();
      value37 = lista[0].ninos37.toDouble();
      value2 = lista[0].bebes.toDouble();

      total = value + value37 + value2;

      //list.shuffle();
      //filteredProd = this.list;
    });
  }
}
