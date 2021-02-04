import 'package:carrito_compras/bloc/cart_bloc.dart';
import 'package:carrito_compras/constants.dart';
import 'package:carrito_compras/model/Cart.dart';
import 'package:carrito_compras/model/Product.dart';
import 'package:carrito_compras/services/cartCrud.dart';
import 'package:carrito_compras/services/productCrud.dart';
import 'package:carrito_compras/views/productPage/productInfo.dart';
import 'package:faker/faker.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';

class ShopScreen extends StatefulWidget {
  @override
  _ShopScreen createState() => _ShopScreen();
}

int cont = 0; //indicador para limitar los carritos
List<Product> productList = List<Product>(); //lista de productos en el carrito

TextEditingController _nameFieldController = TextEditingController();
TextEditingController _desControllerField = TextEditingController();
TextEditingController _stockControllerField = TextEditingController();
String lastkey; //id del ultimo carrito inmediatamente creado

class _ShopScreen extends State<ShopScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(),
      //FirebaseAnimatedList es la lista directamente sacada de la firebase
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
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        backgroundColor: Colors.teal[200],
        onPressed: () {
          showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  title: Text("Agrega tu producto! "),
                  content: Form(
                      child: Column(mainAxisSize: MainAxisSize.min, children: [
                    TextFormField(
                      controller: _nameFieldController,
                      validator: (value) {
                        return value.isNotEmpty ? null : "Invalido";
                      },
                      decoration:
                          InputDecoration(hintText: "Nombre del Producto "),
                    ),
                    TextFormField(
                      controller: _desControllerField,
                      decoration: InputDecoration(hintText: "Descripción"),
                    ),
                    TextFormField(
                      controller: _stockControllerField,
                      decoration:
                          InputDecoration(hintText: "Cuántos en stock?"),
                    ),
                  ])),
                  actions: <Widget>[
                    FlatButton(
                        onPressed: () {
                          Product product2 = new Product(
                              "",
                              _nameFieldController.text,
                              _desControllerField.text,
                              _stockControllerField.text);

                          ProductCrud().addProduct(product2);

                          Navigator.pop(context);
                        },
                        child: Text("Agregar"))
                  ],
                );
              });
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }

  //Este widget es cada item de la lista de esta pantalla
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
                        showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              Future.delayed(Duration(seconds: 1), () {
                                Navigator.of(context).pop(true);
                              });
                              return AlertDialog(
                                title: Text("ha sido añadido al carrito"),
                              );
                            });

                        setState(() {
                          productList.add(product);
                        });
                      },
                    ),
                    new IconButton(
                      iconSize: 30,
                      icon: const Icon(
                        Icons.delete_forever,
                        color: const Color(0xFF167F67),
                      ),
                      onPressed: () async {
                        ProductCrud().deleteProduct(product);

                        showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              Future.delayed(Duration(seconds: 1), () {
                                Navigator.of(context).pop(true);
                              });
                              return AlertDialog(
                                title: Text("ha sido eliminado"),
                              );
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
          onPressed: () async {
            if (cont == 0) {
              cont = 1;
              cart = new Cart("", "pending");

              CartCrud().addCart(cart);

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
            //ruta hacia la pantalla del carrito
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (_) => BlocProvider.value(
                  value: BlocProvider.of<CartBloc>(context),
                  child: ProductInfo(),
                ),
              ),
            );
          },
        ),
        SizedBox(width: kDefaultPaddin / 2)
      ],
    );
  }
}
