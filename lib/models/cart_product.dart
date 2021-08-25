
final String tableCartProducts = 'cartProducts';

class CartProduct {
  int? id;
  String date;
  String title;
  double price;
  double cuota;
  String um;
  String img;
  int cant;




  CartProduct(
      {required this.date, int? id, required this.title,  required this.um,  required this.cuota,  required this.price,  required this.img, required this.cant });

  Map<String, dynamic> toJson() =>
      {
        CartProductFields.id: id,
        CartProductFields.date: date,
        CartProductFields.title: title,
        CartProductFields.price: price,
        CartProductFields.cuota: cuota,
        CartProductFields.um: um,
        CartProductFields.img: img,
        CartProductFields.cant: cant,
      };



  static CartProduct fromJson(Map<String, dynamic> json) {

    int val = json['_id'] as int;


    return CartProduct(
      id: val,
      date: json[CartProductFields.date] as String,
      title: json[CartProductFields.title] as String,
      price: json[CartProductFields.price] as double,
      cuota: json[CartProductFields.cuota] as double,
      um: json[CartProductFields.um] as String,
      img: json[CartProductFields.img] as String,
      cant: json[CartProductFields.cant] as int,
    );
  }
}

class CartProductFields {

  static final List<String> values = [
    id, date, title, price, cuota, um, img
  ];
  static final String id = '_id';
  static final String date = 'date';
  static final String title = 'title';
  static final String price = 'price';
  static final String cuota = 'cuota';
  static final String um = 'um';
  static final String img = 'img';
  static final String cant = 'cant';

}

