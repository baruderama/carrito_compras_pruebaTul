import 'dart:async';
import 'package:carrito_compras/model/Product.dart';
import 'package:firebase_database/firebase_database.dart';

FirebaseDatabase db = new FirebaseDatabase();
DatabaseReference productReference = db.reference().child('product');

class FirebaseDatabaseUtil {
  static final FirebaseDatabaseUtil _instance =
      new FirebaseDatabaseUtil.internal();

  FirebaseDatabaseUtil.internal();

  factory FirebaseDatabaseUtil() {
    return _instance;
  }

  void addUser(Product product) async {
    productReference.push().set(<String, String>{
      "name": "" + product.name,
      "description": "" + product.description,
      "stock": "" + product.stock,
    }).then((_) {
      print('Transaction  committed.');
    });
  }

  void deleteUser(Product product) async {
    await productReference.child(product.id).remove().then((_) {
      print('Transaction  committed.');
    });
  }

  void updateUser(Product product) async {
    await productReference.child(product.id).update({
      "name": "" + product.name,
      "description": "" + product.description,
      "stock": "" + product.stock,
    }).then((_) {
      print('Transaction  committed.');
    });
  }
}

/*
import 'package:carrito_compras/model/Product.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

class ProductCrud {
  Future<List<Product>> getNeeds() async {
    FirebaseDatabase db = new FirebaseDatabase();
    DatabaseReference productReference = await db.reference().child('product');

    debugPrint(productReference.toString() +
        "hey"); // to debug and see if data is returned

    List<Product> items = [];

    productReference.once().then((DataSnapshot snapshot) {
      Map<dynamic, dynamic> values = snapshot.value;
      values.forEach((key, values) {
        debugPrint(values.toString() + 'aqui');
        //items.add(Product.fromSnapShot(values));
        //Product newProduct = Product.fromSnapShot(values).description;
        //items.add(newProduct);
        //items.add("hey");
      });
    });

    return items;
  }
}
*/
