import 'dart:async';
import 'package:carrito_compras/model/Product.dart';
import 'package:firebase_database/firebase_database.dart';

FirebaseDatabase db = new FirebaseDatabase();
DatabaseReference productReference = db.reference().child('product');

class ProductCrud {
  void addProduct(Product product) async {
    productReference.push().set(<String, String>{
      "name": "" + product.name,
      "stock": "" + product.stock,
      "description": "" + product.description,
    }).then((_) {
      print('Transaction  committed.');
    });
  }

  void deleteProduct(Product product) async {
    await productReference.child(product.id).remove().then((_) {
      print('Transaction  committed.');
    });
  }

  void updateProduct(Product product, int resta) async {
    int valor = int.parse(product.stock) - resta;
    await productReference.child(product.id).update({
      "name": "" + product.name,
      "description": "" + product.description,
      "stock": "" + valor.toString(),
    }).then((_) {
      print('Transaction  committed.');
    });
  }
}
