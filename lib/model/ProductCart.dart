import 'package:firebase_database/firebase_database.dart';

class ProductCart {
  String _id;
  String _idProduct;
  String _idCart;
  String _quantity;

  ProductCart(this._id, this._idProduct, this._idCart, this._quantity);

  ProductCart.map(dynamic obj) {
    this._idProduct = obj['idProduct'];
    this._idCart = obj['idCart'];
    this._quantity = obj['quantity'];
  }

  String get id => _id;
  String get idProduct => _idProduct;
  String get idCart => _idCart;
  String get quantity => _quantity;

  ProductCart.fromSnapShot(DataSnapshot snapshot) {
    _id = snapshot.key;
    _idProduct = snapshot.value['idProduct'];
    _idCart = snapshot.value['idCart'];
    _quantity = snapshot.value['quantity'];
  }
}
