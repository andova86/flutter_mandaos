import 'package:flutter/material.dart';
import 'package:mandaos/modules/products/models/product.dart';
import 'package:mandaos/services/db_helper.dart';


class ProductProvider with ChangeNotifier {
  List<Product> _productsCart = [];
  List<Product> _productsList = [];

  List<Product> get products => _productsCart;
  List<Product> get productsList => _productsList;

  void getAllProd()
  {
    listP().then((value) {

      _productsList = value;
    });
  }
  void notifyList(){
  notifyListeners();
}

  bool addToCatalog(Product itemModel) {
    print(itemModel.toJson());
    if(!findProduct(itemModel.id!))
      {
        _productsCart.add(itemModel);
        print(itemModel.toJson());
        notifyListeners();
        return true;
      }
    return false;

  }

  bool findProduct(int id){
    bool result = false;

    _productsCart.forEach((element) {
      if(element.id == id)
        result = true;
    });

    return result;
  }

  bool ContainProd(Product itemModel) {
    return _productsCart.contains(itemModel);


  }

  void updateToCatalog(Product? itemModel) {
    for(int i = 0; i < _productsCart.length; i++)
      {
        if(itemModel != null)
          {
            if(_productsCart[i].id == itemModel.id)
            {
              _productsCart[i].title = itemModel.title;
              _productsCart[i].price = itemModel.price;
              _productsCart[i].cuota = itemModel.cuota;
              notifyListeners();
            }
          }

      }

  }

  void removeFromCatalog(int id) {
    _productsCart.remove(id);
    notifyListeners();
  }

  void removeAllFromCatalog() {
    _productsCart.clear();
    notifyListeners();
  }

  double total()
  {
    double vtotal = 0;
    print('Hay ${_productsCart.length} elementos');
    for (int i = 0; i < _productsCart.length; i++) {

      double t = _productsCart[i].price * _productsCart[i].cuota * _productsCart[i].people;
      vtotal = vtotal + t;
    }

    return vtotal;
  }

  void applyAllCantPeople(int people)
  {

    print('Hay ${_productsCart.length} elementos');
    for (int i = 0; i < _productsCart.length; i++) {

      _productsCart[i].people = people;
      updateToCatalog(_productsCart[i]);
    }

      }



}
