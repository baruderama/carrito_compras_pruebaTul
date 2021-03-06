import 'package:firebase_database/firebase_database.dart';

class Product {
  String _id;
  String _name;
  String _description;
  String _stock;

  Product(this._id, this._name, this._description, this._stock);

  Product.map(dynamic obj) {
    this._name = obj['name'];
    this._description = obj['description'];

    this._stock = obj['stock'];
  }

  String get id => _id;
  String get name => _name;
  String get description => _description;
  String get stock => _stock;

  Product.fromSnapShot(DataSnapshot snapshot) {
    _id = snapshot.key;
    _name = snapshot.value['name'];
    _description = snapshot.value['description'];
    _stock = snapshot.value['stock'];
  }
}
