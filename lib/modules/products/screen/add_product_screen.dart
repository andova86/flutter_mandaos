import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mandaos/modules/products/models/product.dart';
import 'package:mandaos/modules/products/provider/product_provider.dart';
import 'package:mandaos/services/database_helper.dart';
import 'package:mandaos/services/db_helper.dart';
import 'package:mandaos/utils/constants.dart';
import 'package:mandaos/utils/funtions.dart';
import 'package:mandaos/utils/headers.dart';

import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';

class AddProductScreen extends StatefulWidget {
  AddProductScreen({required this.index});

  final int? index;
  Product? prodModify;

  @override
  _AddProductScreenState createState() => _AddProductScreenState();
}

class _AddProductScreenState extends State<AddProductScreen> {
  final _formKey = GlobalKey<FormState>();
  File file = File('assets/img/noimage.png');
  TextEditingController _tcTittle = TextEditingController();

  List _categoryUM = ["lbs", "oz", "kg", "bolsa", "uno", "caja"];

  late List<DropdownMenuItem<String>> _dropDownMenuItems;
  late String _currentCat;

  TextEditingController _tcPrice = TextEditingController();
  TextEditingController _tcCuota = TextEditingController();
  final ImagePicker _picker = ImagePicker();
  late File fileImage;
  File? _image;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      resizeToAvoidBottomInset: true,
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
        child: Column(children: [
          HeaderM(title: _title(), ico: Icons.account_box_outlined),
          Expanded(
            child: SingleChildScrollView(
              physics: BouncingScrollPhysics(),
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
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
                        height: 15,
                      ),
                      DropdownButton(
                        value: _currentCat,
                        items: _dropDownMenuItems,
                        onChanged: changedDropDownItem,
                      ),
                      Container(
                          child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          IconButton(
                              onPressed: () async {
                                final XFile? image = await _picker.pickImage(
                                    source: ImageSource.gallery);
                                if (image != null) {
                                  if (image.path.isNotEmpty) {
                                    print('FULAAAAAAAAAAAA');
                                    setState(() {
                                      _image = File(image.path);
                                    });
                                    print(_image);
                                  }
                                }
                              },
                              icon: Icon(CupertinoIcons.photo)),
                          IconButton(
                              onPressed: () async {
                                final XFile? photo = await _picker.pickImage(
                                    source: ImageSource.camera);

                                if (photo != null) {

                                  if (photo.path.isNotEmpty) {

                                    setState(() {
                                      _image = File(photo.path);

                                    });
                                  }
                                }
                              },
                              icon: Icon(CupertinoIcons.photo_camera)),
                          CircleAvatar(
                            maxRadius: 60,
                            backgroundColor: kPrimaryColor,
                            backgroundImage: _backgroundImage(),
                          ),
                        ],
                      )),
                      SizedBox(
                        height: 30,
                      ),
                      ElevatedButton(
                        onPressed: () async {
                          FocusScope.of(context).requestFocus(new FocusNode());

                          // devolverá true si el formulario es válido, o falso si
                          // el formulario no es válido.
                          if (_formKey.currentState!.validate()) {
                            // Si el formulario es válido, queremos mostrar un Snackbar

                            double cuota = double.parse(_tcCuota.text);
                            double price = double.parse(_tcPrice.text);
                            String title = _tcTittle.text;

                            // getting a directory path for saving
                            var result =
                                await getApplicationDocumentsDirectory();
                            var list = await listP();
                            String nombre = DateTime.now().millisecondsSinceEpoch.toString();

                            if (widget.prodModify == null) {
                              _insertProduct(
                                  title, price, cuota, context, result, nombre);
                            } else {
                              _modifyProduct(
                                  title, price, cuota, context, result, nombre);
                            }
                          } else {
                            // print('El formulario no es valido');
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
                                RoundedRectangleBorder>(RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ))),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(right: 15),
                              child: Text(
                                widget.prodModify == null
                                    ? 'Guardar Datos'
                                    : 'Modificar Datos',
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
                ),
              ),
            ),
          ),
        ]),
      ),
    );
  }

  void _insertProduct(String title, double price, double cuota,
      BuildContext context, Directory result, String nombre) {
    if (_image == null) {
      _image = file;
      Product prod = new Product(
          title: title,
          price: price,
          cuota: cuota,
          um: _currentCat,
          img: file.path,
          recomended: 0,
          kid: 0,
          prodUser: 1);
      prod.prodUser = 1;
      // print('Prod mod ***** ');
      //print(prod.toJson());
      insert(prod.toJson(), table).then((value) {
        if (value > 0) {
          print('EL valor es $value');
          _tcCuota.text = '';
          _tcPrice.text = '';
          _tcTittle.text = '';
          MessageSnackBar('Se añadió el producto correctamente.', context, Icons.check, Colors.greenAccent);


          Navigator.popUntil(context, ModalRoute.withName('products'));
        }
      });

      //print(prod.toJson());
    } else {
      _image!.copy('${result.path}/$nombre.jpg').then((value) {
        Product prod = new Product(
            title: title,
            price: price,
            cuota: cuota,
            um: _currentCat,
            img: value.path,
            recomended: 0,
            kid: 0,
            prodUser: 1);
        print(prod.toJson());
        prod.prodUser = 1;
        insert(prod.toJson(), table).then((value) {
          print('Add prod : $value');
          if (value > 0) {
            MessageSnackBar('Se añadió el producto correctamente.', context, Icons.check, Colors.greenAccent);

            print('EL valor es $value');
            _tcCuota.text = '';
            _tcPrice.text = '';
            _tcTittle.text = '';
            Navigator.popUntil(context, ModalRoute.withName('products'));
          }
        });

        print(prod.toJson());
      });
    }
  }

  void _modifyProduct(String title, double price, double cuota,
      BuildContext context, Directory result, String nombre) {
    widget.prodModify!.title = title;
    widget.prodModify!.price = price;
    widget.prodModify!.cuota = cuota;
    widget.prodModify!.um = _currentCat;
    //widget.prodModify.img = _image!.path;

    if(_image != null)
      {
        print('ENTROOOOOO FULAAAAAAAAAAAA');
        _image!.copy('${result.path}/$nombre.jpg').then((value){
          //print("Fichero: ${value.path}");

          setState(() {
            _image = value;
          });

          print('Image ${_image!.path}');


          //print(widget.prodModify!.toJson());
        });


        widget.prodModify!.img = _image!.path;

        var row = widget.prodModify!.toJson();
        update(row, table).then((value) {
          print('*/*/*/*/*/*/*/*/*/*/*/* LO GUARDO O NO Q BOLA $value');
          print(row);

          if(value > 0)
          {

            Provider.of<ProductProvider>(context, listen: false).updateToCatalog(widget.prodModify);
            MessageSnackBar('Se modificó el producto correctamente.', context, Icons.check, Colors.greenAccent);

            Navigator.pop(context);

          }

        });

      }
    else{
      var row = widget.prodModify!.toJson();
      update(row, table).then((value) {
        print('*/*/*/*/*/*/*/*/*/*/*/* LO GUARDO O NO Q BOLA $value');
        print(row);

        if(value > 0)
        {

          Provider.of<ProductProvider>(context, listen: false).updateToCatalog(widget.prodModify);
          MessageSnackBar('Se modificó el producto correctamente.', context, Icons.check, Colors.greenAccent);

          Navigator.pop(context);

        }

      });
    }










  }

  String _title() {
    if (widget.prodModify == null) return 'Crear Producto';

    return 'Modificar Datos';
  }

  ImageProvider? _backgroundImage() {
    if (_image == null) {
      if (widget.prodModify != null) {
        return AssetImage(widget.prodModify!.img);
      }
      return AssetImage('assets/img/noimage.png');
    }

    return FileImage(
      _image!,
    );
  }

  void PickedImage() async {
    var image = await _picker.pickImage(source: ImageSource.gallery);
  }



  Future<File> getImageFileFromAssets(String path) async {
    if(path.contains('assets'))
      path = path.replaceAll('assets/', '');
    final byteData = await rootBundle.load('assets/$path');

    final file = File('${(await getTemporaryDirectory()).path}/$path');
    await file.writeAsBytes(byteData.buffer.asUint8List(byteData.offsetInBytes, byteData.lengthInBytes));

    return file;
  }

  void changedDropDownItem(String? selectedCat) {
    print("Categoria seleccionada $selectedCat");
    setState(() {
      _currentCat = selectedCat!;
    });
  }

  @override
  void initState() {
    super.initState();
    _dropDownMenuItems = getDropDownMenuItems();
    _currentCat = _dropDownMenuItems[0].value!;



    getProductoAllData(widget.index!).then((value) {

      if(value != null)
        {
          setState(() {
            widget.prodModify = value;

          });
          if (widget.prodModify != null) {
            _tcCuota.text = widget.prodModify!.cuota.toString();
            _tcPrice.text = widget.prodModify!.price.toString();
            _tcTittle.text = widget.prodModify!.title;

            if (widget.prodModify!.img.contains('assets') == false) {
              setState(() {
                _image = File(widget.prodModify!.img);
              });



            }



            int nro = 0;

            switch (widget.prodModify!.um) {
              case 'oz':
                nro = 1;
                break;
              case 'kg':
                nro = 2;
                break;

              case 'bolsa':
                nro = 3;
                break;

              case 'uno':
                nro = 4;
                break;

              case 'caja':
                nro = 5;
                break;
            }
            _currentCat = _dropDownMenuItems[nro].value!;


          }


        }


    });


  }

//write to app path
  Future<void> writeToFile(ByteData data, String path) {
    final buffer = data.buffer;

    //File f = File(path).writeAsBytes(buffer.asUint8List(data.offsetInBytes, data.lengthInBytes));
    return new File(path).writeAsBytes(
        buffer.asUint8List(data.offsetInBytes, data.lengthInBytes));
  }

  List<DropdownMenuItem<String>> getDropDownMenuItems() {
    List<DropdownMenuItem<String>> items = [];
    for (String cat in _categoryUM) {
      // here we are creating the drop down menu items, you can customize the item right here
      // but I'll just use a simple text for this
      items.add(new DropdownMenuItem(value: cat, child: new Text(cat)));
    }
    return items;
  }
}

Future<void> writeToFile(ByteData data, String path) {
  final buffer = data.buffer;
  return new File(path)
      .writeAsBytes(buffer.asUint8List(data.offsetInBytes, data.lengthInBytes));
}
