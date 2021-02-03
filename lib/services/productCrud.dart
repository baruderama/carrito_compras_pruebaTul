import 'dart:async';
import 'package:carrito_compras/model/Product.dart';
import 'package:firebase_database/firebase_database.dart';

class FirebaseDatabaseUtil {
  DatabaseReference _counterRef;
  DatabaseReference _userRef;
  StreamSubscription<Event> _counterSubscription;
  StreamSubscription<Event> _messagesSubscription;
  FirebaseDatabase database = new FirebaseDatabase();
  int _counter;
  DatabaseError error;

  static final FirebaseDatabaseUtil _instance =
      new FirebaseDatabaseUtil.internal();

  FirebaseDatabaseUtil.internal();

  factory FirebaseDatabaseUtil() {
    return _instance;
  }

  void initState() {
    // Demonstrates configuring to the database using a file
    //_counterRef = FirebaseDatabase.instance.reference().child('counter');
    // Demonstrates configuring the database directly

    _userRef = database.reference().child('product');
  }

  DatabaseError getError() {
    return error;
  }

  DatabaseReference getUser() {
    return _userRef;
  }

  addUser(Product product) async {
    _userRef.push().set(<String, String>{
      "name": "" + product.name,
      "age": "" + product.description,
      "email": "" + product.stock,
    }).then((_) {
      print('Transaction  committed.');
    });
  }
/*
  void deleteUser(User user) async {
    await _userRef.child(user.id).remove().then((_) {
      print('Transaction  committed.');
    });
  }

  void updateUser(User user) async {
    await _userRef.child(user.id).update({
      "name": "" + user.name,
      "age": "" + user.age,
      "email": "" + user.email,
      "mobile": "" + user.mobile,
    }).then((_) {
      print('Transaction  committed.');
    });
  }
  */

  void dispose() {
    _messagesSubscription.cancel();
    _counterSubscription.cancel();
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
