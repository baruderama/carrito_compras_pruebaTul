import 'package:carrito_compras/constants.dart';
import 'package:carrito_compras/model/Cart.dart';
import 'package:carrito_compras/model/Product.dart';
import 'package:carrito_compras/services/productCrud.dart';
import 'package:carrito_compras/views/homePage/principalContent.dart';
import 'package:carrito_compras/views/productPage/productInfo.dart';
import 'package:faker/faker.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class ShopScreen extends StatefulWidget {
  @override
  _ShopScreen createState() => _ShopScreen();
}

int cont = 0;
List<Product> productList = List<Product>();
FirebaseDatabase db = new FirebaseDatabase();
DatabaseReference productReference = db.reference().child('product');
DatabaseReference cartReference = db.reference().child('cart');
DatabaseReference productCartReference = db.reference().child('product_cart');
String lastkey;

class _ShopScreen extends State<ShopScreen> {
  FirebaseDatabaseUtil databaseUtil;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(),
      body: new FirebaseAnimatedList(
        key: new ValueKey<bool>(false),
        query: productReference,
        reverse: false,
        sort: false
            ? (DataSnapshot a, DataSnapshot b) => b.key.compareTo(a.key)
            : null,
        itemBuilder: (BuildContext context, DataSnapshot snapshot,
            Animation<double> animation, int index) {
          return new SizeTransition(
            sizeFactor: animation,
            child: showUser(snapshot),
          );
        },
      ),
    );
  }

  Widget showUser(DataSnapshot res) {
    Product product = Product.fromSnapShot(res);

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
                          product.name,
                          // set some style to text
                          style:
                              new TextStyle(fontSize: 30.0, color: Colors.blue),
                        ),
                        new Text(
                          "descripción: " + product.description,
                          // set some style to text
                          style: new TextStyle(
                              fontSize: 20.0, color: Colors.lightBlueAccent),
                        ),
                        new Text(
                          "stock:  " + product.stock,
                          // set some style to text
                          style: new TextStyle(
                              fontSize: 15.0, color: Colors.amber),
                        ),
                      ],
                    ),
                  ),
                ),
                new Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    new IconButton(
                      iconSize: 30,
                      icon: const Icon(
                        Icons.add_shopping_cart_rounded,
                        color: const Color(0xFF167F67),
                      ),
                      onPressed: () {
                        setState(() {
                          productList.add(product);
                        });
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
          padding: const EdgeInsets.fromLTRB(10.0, 0.0, 0.0, 0.0)),
    );

    return item;
  }

  AppBar buildAppBar() {
    return AppBar(
      title: Text('Tienda'),
      backgroundColor: Colors.teal[100],
      elevation: 0,
      leading: IconButton(
        icon: SvgPicture.asset("assets/icons/back.svg"),
        onPressed: () async {},
      ),
      actions: <Widget>[
        IconButton(
          icon: SvgPicture.asset(
            "assets/icons/cart.svg",
            // By default our  icon color is white
            color: kTextColor,
          ),
          onPressed: () {
            if (cont == 0) {
              cont = 1;
              cart = new Cart("", "pending");

              cartReference.push().set(<String, String>{
                "status": "" + cart.status,
              }).then((_) {
                print('Transaction  committed.');
              });
              cartReference.once().then((DataSnapshot snapshot) {
                Map<dynamic, dynamic> values = snapshot.value;

                values.forEach((key, values) {
                  if (values["status"] == 'pending') {
                    debugPrint(key);
                    lastkey = key;
                  }
                });
              });
              cart = new Cart(lastkey, "pending");
            }
            Navigator.push(context,
                new MaterialPageRoute(builder: (context) => ProductInfo()));

            /*
            Product product2 = new Product(
                "", "Abrigo largo", "12", "abrigo largo azul oscuro");

            productReference.push().set(<String, String>{
              "name": "" + product2.name,
              "stock": "" + product2.description,
              "description": "" + product2.stock,
            }).then((_) {
              print('Transaction  committed.');
            });
            */

            //databaseUtil.addUser(product2);
          },
        ),
        SizedBox(width: kDefaultPaddin / 2)
      ],
    );
  }
}
