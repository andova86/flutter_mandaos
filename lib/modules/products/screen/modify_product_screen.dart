import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mandaos/modules/products/models/product.dart';
import 'package:mandaos/modules/products/provider/product_provider.dart';
import 'package:mandaos/services/database_helper.dart';
import 'package:mandaos/services/db_helper.dart';
import 'package:mandaos/utils/constants.dart';
import 'package:provider/provider.dart';

// Crea un Widget Form
class ModifyProductScreen extends StatefulWidget {
  Product prod;

  @override
  ModifyProductScreenState createState() {
    return ModifyProductScreenState();
  }

  ModifyProductScreen(this.prod);
}

// Crea una clase State correspondiente. Esta clase contendrá los datos relacionados con
// el formulario.
class ModifyProductScreenState extends State<ModifyProductScreen> {
  //String t= '';

  TextEditingController _tcTittle = TextEditingController();

  TextEditingController _tcPrice = TextEditingController();
  TextEditingController _tcCuota = TextEditingController();

  // Crea una clave global que identificará de manera única el widget Form
  // y nos permita validar el formulario
  //
  // Nota: Esto es un GlobalKey<FormState>, no un GlobalKey<MyCustomFormState>!
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    //TextEditingController _tcCuota;
    Size size = MediaQuery.of(context).size;
    final _prodProvider = Provider.of<ProductProvider>(context, listen: false);

    // Crea un widget Form usando el _formKey que creamos anteriormente
    return Scaffold(
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

        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios_outlined,
            size: 32,
            color: Colors.white,
          ),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Container(
              height: size.height * 0.1,
              child: Stack(
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.only(
                        left: kDefaultPadding,
                        right: kDefaultPadding,
                        bottom: 10),
                    height: size.height * 0.1,
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
                            'Modificar Datos',
                            style: TextStyle(
                                fontSize: 28,
                                color: Colors.white,
                                fontFamily: 'UbuntuRegular'),
                          ),
                        ),
                        //Image.network('assets/img/pro.png'),
                        Icon(
                          Icons.edit,
                          size: 35,
                          color: kSecondaryColor,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Form(
              key: _formKey,
              child: Container(
                padding: EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    TextFormField(
                      controller: _tcTittle,

                      style: TextStyle(fontFamily: 'UbuntuRegular'),
                      decoration: InputDecoration(
                        border: UnderlineInputBorder(),
                        labelText: 'Nombre:',
                        alignLabelWithHint: true,
                        labelStyle: TextStyle(fontFamily: 'UbuntuRegular'),
                        errorStyle: TextStyle(
                            fontFamily: 'UbuntuRegular',
                            fontWeight: FontWeight.bold),
                      ),

                      //  keyboardAppearance: numer,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Ingrese el nombre del producto';
                        }
                      },
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    TextFormField(
                      keyboardType: TextInputType.number,
                      controller: _tcPrice,
                      style: TextStyle(fontFamily: 'UbuntuRegular'),
                      decoration: InputDecoration(
                        border: UnderlineInputBorder(),
                        labelText: 'Precio(\$):',
                        alignLabelWithHint: true,
                        labelStyle: TextStyle(fontFamily: 'UbuntuRegular'),
                        errorStyle: TextStyle(
                            fontFamily: 'UbuntuRegular',
                            fontWeight: FontWeight.bold),
                      ),
                      //  keyboardAppearance: numer,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Ingrese el precio del producto';
                        }
                      },
                    ),
                    TextFormField(
                      controller: _tcCuota,
                      style: TextStyle(fontFamily: 'UbuntuRegular'),
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        border: UnderlineInputBorder(),
                        labelText: 'Cuota o Cantidad:',
                        alignLabelWithHint: true,
                        labelStyle: TextStyle(fontFamily: 'UbuntuRegular'),
                        errorStyle: TextStyle(
                            fontFamily: 'UbuntuRegular',
                            fontWeight: FontWeight.bold),
                      ),
                      //  keyboardAppearance: numer,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Ingrese la cuota del producto';
                        }
                      },
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ElevatedButton(
                          onPressed: () {
                            FocusScope.of(context)
                                .requestFocus(new FocusNode());

                            print('Precio anterior');
                            print(widget.prod.price);
                            // devolverá true si el formulario es válido, o falso si
                            // el formulario no es válido.
                            if (_formKey.currentState!.validate()) {
                              // Si el formulario es válido, queremos mostrar un Snackbar

                              widget.prod.cuota = double.parse(_tcCuota.text);
                              widget.prod.price = double.parse(_tcPrice.text);
                              widget.prod.title = _tcTittle.text;
                              Future<int> id =
                                  update(widget.prod.toJson(), table);

                              print('Precio actual');
                              print(widget.prod.price);
                              if (id.toString().length > 0) {
                                _prodProvider.updateToCatalog(widget.prod);
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text(
                                        'Se modificaron los datos del producto correctamente.'),
                                  ),
                                );
                                Navigator.of(context).pop();
                              }
                            }
                          },
                          style: ButtonStyle(
                              //  fixedSize:  MaterialStateProperty.all(100),

                              backgroundColor:
                                  MaterialStateProperty.all(kotherColor),
                              padding:
                                  MaterialStateProperty.all(EdgeInsets.all(15)),
                              shadowColor:
                                  MaterialStateProperty.all(kPrimaryColor),
                              elevation: MaterialStateProperty.all(3),
                              shape: MaterialStateProperty.all<
                                      RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ))),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(right: 15),
                                child: Text(
                                  'Modificar información',
                                  style: TextStyle(
                                    color: kPrimaryColor,
                                    fontWeight: FontWeight.bold,
                                    fontFamily: 'UbuntuRegular',
                                  ),
                                ),
                              ),
                              Icon(
                                Icons.save,
                                color: kPrimaryColor,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
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
    _tcTittle.addListener(() {});

    _tcTittle.text = widget.prod.title;
    _tcPrice.text = widget.prod.price.toString();
    _tcCuota.text = widget.prod.cuota.toString();
  }
}
