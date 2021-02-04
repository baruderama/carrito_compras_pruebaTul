import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:carrito_compras/model/Cart.dart';
import 'package:carrito_compras/model/ProductCart.dart';
import 'package:carrito_compras/services/ProductCartCrud.dart';
import 'package:carrito_compras/services/cartCrud.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

part 'cart_event.dart';
part 'cart_state.dart';

/*
Esta clase es la clase principal del bloC del carrito

*/

class CartBloc extends Bloc<CartEvent, CartState> {
  final String mes;

  CartBloc(this.mes);

  @override
  CartState get initialState => CartInitial();

  @override
  Stream<CartState> mapEventToState(
    CartEvent event,
  ) async* {
    yield CartLoading();
    if (event is GetCart) {
      try {
        final cart = event.productCart;
        yield CartLoaded(cart);
      } on NetworkError {
        yield CartError("no se pudo completar la orden");
      }
    }
  }
  // TODO: implement mapEventToState
}
