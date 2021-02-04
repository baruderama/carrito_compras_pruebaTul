part of 'cart_bloc.dart';

/*
clase en donde se obtienen los estados

*/

@immutable
abstract class CartState extends Equatable {
  const CartState();
}

class CartInitial extends CartState {
  const CartInitial();
  @override
  // TODO: implement props
  List<Object> get props => [];
}

class CartLoading extends CartState {
  const CartLoading();
  @override
  // TODO: implement props
  List<Object> get props => [];
}

class CartLoaded extends CartState {
  final String productCart;
  const CartLoaded(this.productCart);
  @override
  // TODO: implement props
  List<Object> get props => [productCart];
}

class CartError extends CartState {
  final String message;
  const CartError(this.message);

  @override
  // TODO: implement props
  List<Object> get props => [message];
}
