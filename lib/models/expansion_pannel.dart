import 'package:flutter/material.dart';
import 'package:mandaos/utils/constants.dart';

class ItemModel {
  bool expanded;
  String headerItem;
  String discription;
  Color colorsItem;
  //String img;

  ItemModel({this.expanded: false, required this.headerItem, required this.discription,required this.colorsItem});
}


List<ItemModel> itemData = <ItemModel>[
  ItemModel(
      headerItem: 'Cual es el objetivo de la aplicación ?',
      discription:
      "La aplicación de Mandaos no es más que una herramienta para agilizar la compra en los mercado, su principal objetivo es ayudar a los consumidores "
          " de una manera diferente a como lo hacen hoy, realizar los pagos por cada producto elegido verificando el precio total y su cuota.",
      colorsItem: kPrimaryColor,
      //img: 'assets/images/android_img.png'
  ),

  ItemModel(
    headerItem: 'Como funciona la aplicación ?',
    discription:
    "Usted debe ir a la página del listado de los productos, elegir aquellos que desee comprar y se le adicionará al carrito de compra. "
        "Después ir la página de las compras virtuales para verificar de cada producto el precio y su cuota. Además la aplicación te brinda el Precio Total,"
        "así como la posibilidad de almacenar la compra dentro de la base de datos interna. ",
    colorsItem: kPrimaryColor,
    //img: 'assets/images/android_img.png'
  ),

  ItemModel(
    headerItem: 'Como añadir un producto al carrito de compras ?',
    discription:
    "Usted debe ir a la página del listado de los productos y debe pinchar en el icono en la parte superior izquierda del producto que desee adicionar. "
        "En la parte superior derecha de la página la aplicación actualiza la cantidad de productos adicionados en un círculo rojo encima de un carrito de compras. ",
    colorsItem: kPrimaryColor,
    //img: 'assets/images/android_img.png'
  ),

  ItemModel(
    headerItem: 'Como verificar mi compra virtual ?',
    discription:
    "La compra virtual se puede acceder desde el menú de la aplicación o puede pinchar en el icono del carrito de compra. "
        "En esta pantalla se muestra un listado de productos seleccionados así como el precio de cada uno. También puede verificar el precio total. ",
    colorsItem: kPrimaryColor,
    //img: 'assets/images/android_img.png'
  ),

  ItemModel(
    headerItem: 'Cómo almacenar mi compra virtual ?',
    discription:
    "La compra virtual se puede almacenar dentro de la aplicación en caso de que el usuario desee guardar todos los datos. "
        "En esta pantalla se muestra una fecha que es muy importante en el momento de guardar la compra para tener un histórico de todas las compras realizadas. ",
    colorsItem: kPrimaryColor,
    //img: 'assets/images/android_img.png'
  ),

  ItemModel(
    headerItem: 'Puedo visualizar todas las compras que he realizado ?',
    discription:
    "Sí por supuesto. En la pantalla de compras en la parte superior derecha se encuentra el icono de Datos Historicos donde el usuario debe pinchar para acceder. "
    " Al entrar en la pantalla de Historial de Compras debe seleccionar la fecha cuando realizo la compra y pinchar el boton de obtener los datos de color rojo.",
    colorsItem: kPrimaryColor,
    //img: 'assets/images/android_img.png'
  ),

  ItemModel(
    headerItem: 'Puedo cambiar los datos de un producto ?',
    discription:
    "Sí por supuesto. En la pantalla de los productos usted puede pinchar en cada uno de ellos para ver los detalles en especifico. "
        "También puede modificar sus datos pinchando en el botón rojo con ícono de un lápiz",
    colorsItem: kPrimaryColor,
    //img: 'assets/images/android_img.png'
  ),

];