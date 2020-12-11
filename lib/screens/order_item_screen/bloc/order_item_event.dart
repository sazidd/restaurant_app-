part of 'order_item_bloc.dart';

abstract class OrderItemEvent extends Equatable {
  const OrderItemEvent();

  @override
  List<Object> get props => [];
}

class FetchOrder extends OrderItemEvent {}

class OrderTotal extends OrderItemEvent {
  final Order order;

  const OrderTotal({this.order});

  @override
  List<Object> get props => [order];
}

class OrderIncrement extends OrderItemEvent {
  final Order order;

  const OrderIncrement({this.order});

  @override
  List<Object> get props => [order];
}

class OrderDecrement extends OrderItemEvent {
  final Order order;

  const OrderDecrement({this.order});

  @override
  List<Object> get props => [order];
}

class OrderDelete extends OrderItemEvent {
  final Order order;

  const OrderDelete({this.order});

  @override
  List<Object> get props => [order];
}
