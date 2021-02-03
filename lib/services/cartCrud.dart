import 'dart:async';
import 'package:carrito_compras/model/Cart.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

FirebaseDatabase db = new FirebaseDatabase();
DatabaseReference cartReference = db.reference().child('cart');

class CartCrud {
  void addCart(Cart cart) async {
    cartReference.push().set(<String, String>{
      "status": "" + cart.status,
    }).then((_) {
      print('Transaction  committed.');
    });
  }

  void deleteCart(Cart cart) async {
    await cartReference.child(cart.id).remove().then((_) {
      print('Transaction  committed.');
    });
  }

  void updateCart(String lastkey) async {
    await cartReference.child(lastkey).update({
      "status": "completed",
    }).then((_) {
      print('Transaction  committed.');
    });
  }

  Future<String> laskeyCart() async {
    String lastkey;
    cartReference.once().then((DataSnapshot snapshot) {
      Map<dynamic, dynamic> values = snapshot.value;

      values.forEach((key, values) {
        if (values["status"] == 'pending') {
          debugPrint(key);
          lastkey = key;
        }
      });
    });
    return lastkey;
  }
}
