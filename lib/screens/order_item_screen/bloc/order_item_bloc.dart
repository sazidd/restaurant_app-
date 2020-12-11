import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';

import '../../../sqlite/order.dart';
import '../../../sqlite/order_provider.dart';

part 'order_item_event.dart';
part 'order_item_state.dart';

class OrderItemBloc extends Bloc<OrderItemEvent, OrderItemState>
    with ChangeNotifier {
  final OrderDb _orderDb;

  OrderItemBloc({OrderDb orderDb})
      : _orderDb = orderDb,
        super(OrderItemInitial());

  // OrderItemBloc({OrderDb orderDb})
  //     : _orderDb = orderDb,
  //       super(OrderItemInitial());

  @override
  Stream<OrderItemState> mapEventToState(
    OrderItemEvent event,
  ) async* {
    final orders = await _orderDb.getOrder();

    if (event is FetchOrder) {
      yield OrderItemSuccess(orders: orders);
    }

    if (event is OrderTotal) {
      final price = await _orderDb.getMenuPrice();
      final quantity = await _orderDb.getupdateMenuQuantity();
      final total = price + quantity;
      yield OrderItemSuccess(total: total);
    }

    if (event is OrderIncrement) {
      yield OrderItemSuccess(
        orders: orders,
        quantity: int.parse(event.order.menuQuantity) + 1,
        price: int.parse(event.order.menuPrice) + 1,
      );
    }

    if (event is OrderDecrement) {
      yield OrderItemSuccess(
        orders: orders,
        quantity: int.parse(event.order.menuQuantity) - 1,
        price: int.parse(event.order.menuPrice) - 1,
      );
    }

    // if (event is OrderDelete) {
    //   final id =  _orderDb.deleteOrder(id: event.id);
    //    yield OrderItemSuccess(
    //     id :  id;
    //   );
    // }
  }
}

// Stream<TodosState> _mapTodosLoadedToState() async* {
//   try {
//     final todos = await this.todosRepository.loadTodos();
//     yield TodosLoadSuccess(
//       todos.map(Todo.fromEntity).toList(),
//     );
//   } catch (_) {
//     yield TodosLoadFailure();
//   }
// }
