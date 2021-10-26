

final String tableProducts = 'products';

class Product {
  int? id;
  String title;
  double price;
  double cuota;
  String um;
  String img;
  int recomended;
  int kid;
  int people;
  int? prodUser;

  Product(
      {required this.title, required this.price, required this.cuota, required this.um, required this.img, int? id , required this.recomended, required this.kid, this.people=1,  int? prodUser});

  Map<String, dynamic> toJson() =>
      {
        ProductFields.id: id,
        ProductFields.title: title,
        ProductFields.price: price,
        ProductFields.cuota: cuota,
        ProductFields.um: um,
        ProductFields.img: img,
        ProductFields.recomended: recomended,
        ProductFields.kid: kid,
        ProductFields.prodUser: prodUser,

      };

 

  static Product fromJson(Map<String, dynamic> json) {

    int val = json['_id'] as int;
    int val2 = json['prodUser'] as int;
  print(val2);

    return Product(
      id: val,
      title: json[ProductFields.title] as String,
      price: json[ProductFields.price] as double,
      cuota: json[ProductFields.cuota] as double,
      um: json[ProductFields.um] as String,
      img: json[ProductFields.img] as String,
      recomended: json[ProductFields.recomended] as int,
      kid: json[ProductFields.kid] as int,
      prodUser: val2,
    );
  }




}

class ProductFields {

  static final List<String> values = [
    id, title, price, cuota, um, img
  ];
  static final String id = '_id';
  static final String title = 'title';
  static final String price = 'price';
  static final String cuota = 'cuota';
  static final String um = 'um';
  static final String img = 'img';
  static final String recomended = 'recomended';
  static final String kid = 'kid';
  static final String prodUser = 'prodUser';


}

/*


class UserProvider with ChangeNotifier {
  String _username = 'Guest';

  String get username => _username;

  void onChange(value) {
    _username = value;
    notifyListeners();
  }
}
*/

// Define the 'tableCategory' constant as SqfEntityTable for the category table.
/*
const tableProduct = SqfEntityTable(
    tableName: 'product',
    primaryKeyName: 'id',
    primaryKeyType: PrimaryKeyType.integer_auto_incremental,
    useSoftDeleting: true,
    modelName: null,
    fields: [
      SqfEntityField('title', DbType.text),
      SqfEntityField('price', DbType.real),
      SqfEntityField('cuota', DbType.real),
      SqfEntityField('um', DbType.text),
      SqfEntityField('img', DbType.text),
      //SqfEntityField('isActive', DbType.bool, defaultValue: true),
    ]
);
*/
