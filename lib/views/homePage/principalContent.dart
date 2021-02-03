import 'dart:async';

import 'package:carrito_compras/constants.dart';
import 'package:carrito_compras/model/Product.dart';
import 'package:carrito_compras/services/productCrud.dart';
import 'package:carrito_compras/views/homePage/productContent.dart';
import 'package:carrito_compras/views/productPage/productInfo.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

class PrincipalContent extends StatefulWidget {
  @override
  _principalContent createState() => _principalContent();
}

FirebaseDatabase db = new FirebaseDatabase();
DatabaseReference productReference = db.reference().child('product');
List<Product> items = new List<Product>();

class _principalContent extends State<PrincipalContent> {
  StreamSubscription<Event> _onProductAddedSubscription;
  StreamSubscription<Event> _onProductChangedSubscription;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    _onProductAddedSubscription.cancel();
    _onProductChangedSubscription.cancel();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: kDefaultPaddin),
          child: Text(
            "Women",
            style: Theme.of(context)
                .textTheme
                .headline5
                .copyWith(fontWeight: FontWeight.bold),
          ),
        ),
        //Categories(),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: kDefaultPaddin),
            child: GridView.builder(
                itemCount: items.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: kDefaultPaddin,
                  crossAxisSpacing: kDefaultPaddin,
                  childAspectRatio: 0.75,
                ),
                itemBuilder: (context, index) => ProductContent(
                      product: items[index],
                    )),
          ),
        ),
      ],
    );
  }
}
