import 'package:flutter/material.dart';
import 'package:mandaos/models/product.dart';


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




}
