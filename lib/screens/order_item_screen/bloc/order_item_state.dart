part of 'order_item_bloc.dart';

abstract class OrderItemState extends Equatable {
  const OrderItemState();

  @override
  List<Object> get props => [];
}

class OrderItemInitial extends OrderItemState {}

class OrderItemLoading extends OrderItemState {}

class OrderItemSuccess extends OrderItemState {
  final List<Order> orders;
  final int quantity;
  final int price;

  const OrderItemSuccess({
    this.orders = const <Order>[],
    this.quantity = 1,
    this.price = 0,
  });

  @override
  List<Object> get props => [orders, quantity, price];
}

class OrderItemFailure extends OrderItemState {
  final String error;
  const OrderItemFailure({this.error});

  @override
  List<Object> get props => [error];
}
