
final String tableBuy = 'buyProducts';

class Buy {
  int? id;
  String date;
  int cant;



  Buy(
      {required this.date, required this.cant,int? id });

  Map<String, dynamic> toJson() =>
      {
        BuyFields.id: id,
        BuyFields.date: date,
        BuyFields.cant: cant,

      };



  static Buy fromJson(Map<String, dynamic> json) {

    int val = json['_id'] as int;


    return Buy(
      id: val,
      date: json[BuyFields.date] as String,
      cant: json[BuyFields.cant] as int,


    );
  }




}

class BuyFields {

  static final List<String> values = [
    id, date, cant
  ];
  static final String id = '_id';
  static final String date = 'date';
  static final String cant = 'cant';



}

