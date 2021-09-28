import 'package:flutter/material.dart';
import 'package:mandaos/modules/products/models/product.dart';


class ProductProvider with ChangeNotifier {
  List<Product> _products = [];

  List<Product> get products => _products;

  bool addToCatalog(Product itemModel) {
    if(_products.contains(itemModel) == false)
      {
        _products.add(itemModel);
        print(itemModel.toJson());
        notifyListeners();
        return true;
      }
    return false;

  }

  bool ContainProd(Product itemModel) {
    return _products.contains(itemModel);


  }

  void updateToCatalog(Product itemModel) {
    for(int i = 0; i < _products.length; i++)
      {
        if(_products[i].id == itemModel.id)
          {
            _products[i].title = itemModel.title;
            _products[i].price = itemModel.price;
            _products[i].cuota = itemModel.cuota;
            notifyListeners();
          }
      }

  }

  void removeFromCatalog(int id) {
    _products.remove(id);
    notifyListeners();
  }

  void removeAllFromCatalog() {
    _products.clear();
    notifyListeners();
  }

  int total()
  {
    int vtotal = 0;
    print('Hay ${_products.length} elementos');
    for (int i = 0; i < _products.length; i++) {

      double t = _products[i].price * _products[i].cuota * _products[i].people;
      vtotal = vtotal + t.round();
    }

    return vtotal;
  }

  void applyAllCantPeople(int people)
  {

    print('Hay ${_products.length} elementos');
    for (int i = 0; i < _products.length; i++) {

      _products[i].people = people;
      updateToCatalog(_products[i]);
    }

      }



}
