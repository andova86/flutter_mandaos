/*
import 'package:flutter/material.dart';
import 'package:mandaos/models/product.dart';
import 'package:mandaos/services/ListProducts.dart';
import 'package:mandaos/widgets/card_product_home.dart';


void main() => runApp(new NewScreen());

class NewScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Flutter Api Filter list Demo',
      theme: new ThemeData(
        primarySwatch: Colors.deepPurple,
      ),
      home: new ExamplePage(),
    );
  }
}

class ExamplePage extends StatefulWidget {
  // ExamplePage({ Key key }) : super(key: key);
  @override
  _ExamplePageState createState() => new _ExamplePageState();
}

class _ExamplePageState extends State<ExamplePage> {
  // final formKey = new GlobalKey<FormState>();
  // final key = new GlobalKey<ScaffoldState>();
  final TextEditingController _filter = new TextEditingController();

  String _searchText = "";
  List<Product> list = list_products;
  List<Product>  filteredNames = [];
  Icon _searchIcon = new Icon(Icons.search, color: Colors.white,);
  Widget _appBarTitle = new Text( 'Buscar Producto' );

  _ExamplePageState() {
    _filter.addListener(() {
      if (_filter.text.isEmpty) {
        setState(() {
          _searchText = "";
          filteredNames = list;
        });
      } else {
        setState(() {
          _searchText = _filter.text;
        });
      }
    });
  }

  @override
  void initState() {
    this._getProducts();
    super.initState();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildBar(context),

      body: Container(
        child: _buildList(),
      ),
      resizeToAvoidBottomInset: false,
    );
  }

  PreferredSizeWidget _buildBar(BuildContext context) {
    return  AppBar(
      centerTitle: true,
      title: _appBarTitle,
      elevation: 0,
      leading: new IconButton(
        icon: _searchIcon,
        onPressed: _searchPressed,

      ),
    );
  }



  Widget _buildList() {
    if (!(_searchText.isEmpty)) {
      List<Product>  tempList = [];
      for (int i = 0; i < filteredNames.length; i++) {
        if (filteredNames[i].title.toLowerCase().contains(_searchText.toLowerCase())) {
          tempList.add(filteredNames[i]);
        }
      }


      filteredNames = tempList;
    }
    return ListView.builder(
      itemCount: filteredNames.length == 0 ? 0 : filteredNames.length,
      itemBuilder: (BuildContext context, int index) {
        return CardProductHome(product: filteredNames[index]);
      },
    );
  }

  void _searchPressed() {
    setState(() {
      if (this._searchIcon.icon == Icons.search) {
        this._searchIcon = new Icon(Icons.close);
        this._appBarTitle = new TextField(
          style: TextStyle(color: Colors.white),
          controller: _filter,
          decoration: new InputDecoration(
              prefixIcon: new Icon(Icons.search, color: Colors.white,),
              hintText: 'Buscar...',

          ),
        );
      } else {
        this._searchIcon = new Icon(Icons.search);
        this._appBarTitle = new Text( 'Búsqueda de Productos' );
        filteredNames = list;
        _filter.clear();
      }
    });
  }

  void _getProducts() async {
    setState(() {
      list = list_products;
      list.shuffle();
      filteredNames = list;
    });
  }


}*/
