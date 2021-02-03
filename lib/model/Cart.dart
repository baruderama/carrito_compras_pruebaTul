import 'package:firebase_database/firebase_database.dart';

class Cart {
  String _id;
  String _status;

  Cart(this._id, this._status);

  Cart.map(dynamic obj) {
    this._status = obj['name'];
  }

  String get id => _id;
  String get status => _status;

  Cart.fromSnapShot(DataSnapshot snapshot) {
    _id = snapshot.key;
    _status = snapshot.value['status'];
  }
}
