import 'package:carrito_compras/constants.dart';
import 'package:carrito_compras/model/Product.dart';
import 'package:flutter/material.dart';
import 'package:faker/faker.dart';

class ProductContent extends StatelessWidget {
  final Product product;
  final Function press;
  const ProductContent({
    Key key,
    this.product,
    this.press,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: press,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Expanded(
            child: Container(
              padding: EdgeInsets.all(kDefaultPaddin),
              // For  demo we use fixed height  and width
              // Now we dont need them
              // height: 180,
              // width: 160,
              decoration: BoxDecoration(
                color: Colors.blue,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Hero(
                tag: "${product.name}",
                child: Image.asset(faker.image.image()),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: kDefaultPaddin / 4),
            child: Text(
              // products is out demo list
              product.name,
              style: TextStyle(color: kTextLightColor),
            ),
          ),
          Text(
            "\$${product.name}",
            style: TextStyle(fontWeight: FontWeight.bold),
          )
        ],
      ),
    );
  }
}
