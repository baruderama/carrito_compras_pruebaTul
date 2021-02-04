import 'dart:async';
import 'package:carrito_compras/model/ProductCart.dart';
import 'package:firebase_database/firebase_database.dart';

FirebaseDatabase db = new FirebaseDatabase();
DatabaseReference productCartReference = db.reference().child('product_cart');

class ProductCartCrud {
  Future<String> addProductCart(ProductCart productCart) async {
    productCartReference.push().set(<String, String>{
      "idProduct": "" + productCart.idProduct,
      "idCart": "" + productCart.idCart,
      "quantity": "" + productCart.quantity,
    }).then((_) {
      print('Transaction  committed.');
    });

    return 'creado';
  }
}

class NetworkError extends Error {}
