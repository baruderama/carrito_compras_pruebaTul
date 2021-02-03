import 'package:carrito_compras/constants.dart';
import 'package:carrito_compras/model/Cart.dart';
import 'package:carrito_compras/model/Product.dart';
import 'package:carrito_compras/model/ProductCart.dart';
import 'package:carrito_compras/services/ProductCartCrud.dart';
import 'package:carrito_compras/services/cartCrud.dart';
import 'package:carrito_compras/services/productCrud.dart';
import 'package:carrito_compras/views/homePage/shopScreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class ProductInfo extends StatefulWidget {
  @override
  _ProductInfo createState() => _ProductInfo();
}

Cart cart;

class _ProductInfo extends State<ProductInfo> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // each product have a color
      backgroundColor: Colors.white,
      appBar: buildAppBar(context),
      body: ListView.builder(
        itemCount: productList.length,
        itemBuilder: (BuildContext context, int index) {
          return Dismissible(
            onDismissed: (direction) {
              productList.remove(productList[index]);
            },
            key: Key(productList[index].id),
            child: showCart(productList[index], index),
          );
        },
      ),
      floatingActionButton: FlatButton(
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(18.0)),
        //   side: BorderSide(color: Color.fromRGBO(0, 160, 227, 1))),
        onPressed: () async {
          List<String> aux = new List<String>();
          List<Product> auxProduct = new List<Product>();
          for (int y = 0; y < productList.length; y++) {
            aux.add(productList[y].id);
            aux = aux.toSet().toList();
          }
          debugPrint(aux.length.toString());
          for (int i = 0; i < aux.length; i++) {
            int contProduct = 0;
            int contOne = 0;
            for (int j = 0; j < productList.length; j++) {
              if (productList[j].id == aux[i]) {
                if (contOne == 0) {
                  contOne = 1;
                  auxProduct.add(productList[j]);
                  debugPrint(auxProduct[i].name);
                }
                debugPrint(aux[i] + 'lol');
                contProduct++;
              }
            }
            debugPrint(aux.length.toString() + 'hey');
            ProductCart newProductCart =
                new ProductCart("", aux[i], lastkey, contProduct.toString());

            ProductCartCrud().addProductCart(newProductCart);

            ProductCrud().updateProduct(auxProduct[i], contProduct);

            CartCrud().updateCart(lastkey);

            cont = 0;
          }
          productList.clear();
          Navigator.pop(context);
        },
        padding: EdgeInsets.symmetric(horizontal: 20),
        color: Colors.grey,
        textColor: Colors.white,
        child: Text("Completar Orden ", style: TextStyle(fontSize: 13)),
      ),
    );
  }

  AppBar buildAppBar(BuildContext context) {
    return AppBar(
      title: Text('Tu carrito'),
      backgroundColor: Colors.grey,
      elevation: 0,
      leading: IconButton(
        icon: SvgPicture.asset(
          'assets/icons/back.svg',
          color: Colors.white,
        ),
        onPressed: () => Navigator.pop(context),
      ),
    );
  }

  Widget showCart(Product res, int index) {
    Product productNew = res;

    var item = new Card(
      child: new Container(
          child: new Center(
            child: new Row(
              children: <Widget>[
                new CircleAvatar(
                  radius: 40.0,
                  child: Image.asset("assets/images/giftbox.png"),
                  backgroundColor: const Color(0xFF20283e),
                ),
                new Expanded(
                  child: new Padding(
                    padding: EdgeInsets.all(10.0),
                    child: new Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        new Text(
                          productNew.name,
                          // set some style to text
                          style:
                              new TextStyle(fontSize: 30.0, color: Colors.blue),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          padding: const EdgeInsets.fromLTRB(10.0, 0.0, 0.0, 0.0)),
    );

    return item;
  }
}
