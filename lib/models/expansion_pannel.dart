import 'package:flutter/material.dart';
import 'package:mandaos/utils/constants.dart';

class ItemModel {
  bool expanded;
  String headerItem;
  String description;
  Color colorsItem;
  //String img;

  ItemModel({this.expanded: false, required this.headerItem, required this.description,required this.colorsItem});
}


List<ItemModel> itemData = <ItemModel>[
  ItemModel(
      headerItem: 'Cuál es el objetivo de la aplicación ?',
      description:
      "La aplicación \"Mis Mandaos\" es una herramienta que facilita y agiliza la compra de los consumidores en las bodegas y mercados. Permite conocer de una manera rápida y segura, el precio total de una compra, así como el precio de cada producto y sus cuota por persona.",
      colorsItem: kPrimaryColor,
      //img: 'assets/images/android_img.png'
  ),

  ItemModel(
    headerItem: 'Cómo funciona la aplicación ?',
    description:
    "Debe ir a la opción \"Productos\" del menú, y añadir al carrito de compras aquellos que desee comprar. En la opción \"Su compra\" del menú, se muestran los productos seleccionados con su precio, así como el precio total de la compra. Tiene la opción de elegir la cantidad de consumidores, y los precios se actualizan automáticamente.",
    colorsItem: kPrimaryColor,
    //img: 'assets/images/android_img.png'
  ),

  ItemModel(
    headerItem: 'Cómo añadir un producto al carrito de compras ?',
    description:
    "Debe ir a la opción \"Productos\" del menú, y seleccionar el ícono del carrito de compra, que aparece en la parte superior izquierda. Seleccionar la opción \"Agregar\".",
    colorsItem: kPrimaryColor,
    //img: 'assets/images/android_img.png'
  ),

  ItemModel(
    headerItem: 'Cómo verificar mi compra virtual ?',
    description:
    "Debe ir a la opción \"Compras\" del menú. O acceder a través del ícono del carrito de compras situado en la parte superior derecha de la aplicación. Se muestra un listado de los productos con su precio, así como el precio total de la compra.",
    colorsItem: kPrimaryColor,
    //img: 'assets/images/android_img.png'
  ),

  ItemModel(
    headerItem: 'Cómo almacenar mi compra virtual ?',
    description:
    "La compra virtual se puede almacenar dentro de la aplicación en caso de que el usuario desee guardar todos los datos. "
        "En esta pantalla se muestra una fecha que es muy importante en el momento de guardar la compra para tener un histórico de todas las compras realizadas. ",
    colorsItem: kPrimaryColor,
    //img: 'assets/images/android_img.png'
  ),

  ItemModel(
    headerItem: 'Puedo visualizar todas las compras que he realizado ?',
    description:
    "Puede visualizar un registro histórico de las compras realizadas accediendo a la opción \"Historial de Compras\" del menú. Debe seleccionar la fecha de compra y actualizar la información correspondiente a esa fecha, seleccionando el ícono en rojo en la parte inferior derecha de la pantalla.",
    colorsItem: kPrimaryColor,
    //img: 'assets/images/android_img.png'
  ),

  ItemModel(
    headerItem: 'Puedo cambiar los datos de un producto ?',
    description:
    "Puede modificar la información asociada a un producto, accediendo a la opción \"Productos\" del menú. Primero selecciona el producto que desea modificar, después selecciona el ícono del lápiz, en la parte superior derecha de la pantalla y modifica los valores que desee.",
    colorsItem: kPrimaryColor,
    //img: 'assets/images/android_img.png'
  ),

];