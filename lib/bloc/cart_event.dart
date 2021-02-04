part of 'cart_bloc.dart';

/*
Clase en donde los eventos entran

*/
@immutable
abstract class CartEvent extends Equatable {
  const CartEvent();
}

class GetCart extends CartEvent {
  final String productCart;

  const GetCart(this.productCart);

  @override
  // TODO: implement props
  List<Object> get props => [productCart];
}
